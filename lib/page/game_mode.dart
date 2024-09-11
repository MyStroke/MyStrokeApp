import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';  
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class GameModeScreen extends StatefulWidget {
  const GameModeScreen({Key? key}) : super(key: key);

  @override
  State<GameModeScreen> createState() => _GameModeScreenState();
}

class _GameModeScreenState extends State<GameModeScreen> {
  late PlatformWebViewController  controller;

  @override
  void initState() {
    super.initState();
    setupWebView();
  }

  void setupWebView() {
    controller = PlatformWebViewController(
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
        uri: Uri.parse('https://mystrokegamemode-webgl.onrender.com/'),
      ),
    );

    // เพิ่ม JavaScript เพื่อตรวจสอบสถานะกล้องและแจ้งเตือนหากมีปัญหา
    Future.delayed(const Duration(seconds: 5), () {
      controller.runJavaScript('''
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
      appBar: AppBar(
        title: const Text('เล่นแบบโหมด'),
      ),
      body: PlatformWebViewWidget(
              PlatformWebViewWidgetCreationParams(controller: controller),
            ).build(context)
    );
  }
}