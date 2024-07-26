import 'package:flutter/material.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
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
      controller = CameraController(_cameras[0], ResolutionPreset.medium, enableAudio: false);
      await controller?.initialize().then((_) {
        if (!mounted) return;
        setState(() => isCameraInitialized = true);
      });
    } catch (e) {
      if (e is CameraException) {
        debugPrint('CameraException: ${e.code}, ${e.description}');
        if (e.code == 'CameraAccessDenied') {
          debugPrint('Camera access permission was denied.');
        }
        initCamera();
      }
    }
  }

  void requestCameraPermission() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
      
    } else {
      initCamera();
      setupWebView();
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
          debugPrint('Requesting camera permission');
          request.grant();
        } else {
          request.deny();
        }
      },
    )
    ..loadRequest(
      LoadRequestParams(
        uri: Uri.parse('https://mystrokegame-webgl.onrender.com/'),
      ),
    );
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isCameraInitialized
          ? 
            // AspectRatio(
            //   aspectRatio: controller!.value.aspectRatio,
            //   child: CameraPreview(controller!),
            //   child: PlatformWebViewWidget(
            //     PlatformWebViewWidgetCreationParams(controller: _webViewController),
            //   ).build(context)
            // )


            PlatformWebViewWidget(
              PlatformWebViewWidgetCreationParams(controller: _webViewController),
            ).build(context)
          : const Center(child: CircularProgressIndicator()),
    );
  }
}
