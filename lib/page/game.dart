import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

late List<CameraDescription> _cameras;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();

  runApp(MaterialApp(
    title: 'MyStroke',
    theme: ThemeData(
      primaryColor: const Color.fromRGBO(35, 47, 63, 1),
      fontFamily: "Prompt"
    ),
    home: const GameScreen(),
  ));
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  CameraController? controller;
  bool isCameraInitialized = false;
  late PlatformWebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    requestCameraPermission();
  }

  void initCamera() async {
    try {
      _cameras = await availableCameras();
      controller = CameraController(_cameras[1], ResolutionPreset.medium, enableAudio: false);
      await controller?.initialize().then((_) {
        if (!mounted) return;
        setState(() => isCameraInitialized = true);
        debugPrint('Camera initialized');
      });
    } catch (e) {
      debugPrint('Error initializing camera: $e');
    }
  }


  void requestCameraPermission() async {
    var cameraStatus = await Permission.camera.request();
    if (cameraStatus.isGranted) {
      initCamera();
      setupWebView();
    } else {
      // แสดงข้อความแจ้งเตือนให้ผู้ใช้อนุญาตการใช้งานกล้อง
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('การอนุญาตใช้งานกล้อง'),
          content: const Text('แอปนี้ต้องการสิทธิ์ในการเข้าถึงกล้อง โปรดอนุญาตในการตั้งค่า'),
          actions: [
            TextButton(
              child: const Text('ตกลง'),
              onPressed: () async {
                await openAppSettings();
                // ตรวจสอบการอนุญาตอีกครั้งหลังจากกลับมาจากการตั้งค่า
                var newStatus = await Permission.camera.status;
                if (newStatus.isGranted) {
                  initCamera();
                  setupWebView();
                }
              },
            ),
          ],
        ),
      );
    }
  }


  void setupWebView() {
    _webViewController = PlatformWebViewController(
      AndroidWebViewControllerCreationParams(),
    )
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..setOnPlatformPermissionRequest(
      (PlatformWebViewPermissionRequest request) {
        if (request.types.contains(WebViewPermissionResourceType.camera)) {
          debugPrint('Granting camera permission to WebView');
          request.grant();
        } else {
          debugPrint('Denying permission request from WebView');
          request.deny();
        }
      },
    )
    ..loadRequest(
      LoadRequestParams(
        uri: Uri.parse('https://tk17250.github.io/MyStrokeGame-WebGL/'),
      ),
    );

    // เพิ่ม JavaScript เพื่อตรวจสอบสถานะกล้องและแจ้งเตือนหากมีปัญหา
    Future.delayed(Duration(seconds: 5), () {
      _webViewController.runJavaScript('''
        navigator.mediaDevices.getUserMedia({ video: true })
          .then(function(stream) {
            console.log('Camera access granted');
            // จัดการ stream ที่นี่
          })
          .catch(function(error) {
            console.error('Error accessing camera:', error);
            alert('ไม่สามารถเข้าถึงกล้องได้ กรุณาตรวจสอบการอนุญาตในการตั้งค่า');
          });
      ''');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: isCameraInitialized
                ? PlatformWebViewWidget(
                    PlatformWebViewWidgetCreationParams(controller: _webViewController),
                  ).build(context)
                : const Center(child: CircularProgressIndicator()),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                child: Text('รีโหลด WebView'),
                onPressed: () {
                  _webViewController.reload();
                },
              ),
              ElevatedButton(
                child: Text('เปิดการตั้งค่า'),
                onPressed: () async {
                  await openAppSettings();
                  // ตรวจสอบการอนุญาตอีกครั้งหลังจากกลับมาจากการตั้งค่า
                  var newStatus = await Permission.camera.status;
                  if (newStatus.isGranted) {
                    initCamera();
                    setupWebView();
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
