import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

import '../service/auth_service.dart';

import 'login.dart';

late List<CameraDescription> _cameras;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  _cameras = await availableCameras();
  runApp(MaterialApp(
    title: 'MyStroke',
    theme: ThemeData(
      primaryColor: const Color.fromRGBO(35, 47, 63, 1),
      fontFamily: "Prompt"
    ),
    home: const LoginFace(),
  ));
}

class LoginFace extends StatefulWidget {
  const LoginFace({super.key});

  @override
  State<LoginFace> createState() => _LoginFaceScreenState();
}

class _LoginFaceScreenState extends State<LoginFace> {
  CameraController? controller;
  bool isCameraInitialized = false;

  @override
  void initState() {
    super.initState();
    requestStoragePermission();
    initCamera();
  }

  void initCamera() async {    
    _cameras = await availableCameras();
    controller = CameraController(_cameras[1], ResolutionPreset.medium);
    await controller?.initialize().then((_) {
      if (!mounted) return;
      setState(() => isCameraInitialized = true);
    });
  }

  void requestStoragePermission() async {
    var cameraStatus = await Permission.camera.status;
    if (!cameraStatus.isGranted) {
      await Permission.camera.request();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        // Set background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"), 
            fit: BoxFit.cover,
          ),
        ),

        // Screen content
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Header text
                const Text(
                  "เข้าสู่ระบบ",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Prompt",
                  ),
                ),

                const SizedBox(height: 50),

                // Camera preview
                !isCameraInitialized
                    ? // Face icon
                      Image.asset(
                        "assets/login_face/face_icon.png",
                        width: 200,
                      )
                    : AspectRatio(
                        aspectRatio: controller!.value.aspectRatio,
                        child: CameraPreview(controller!),
                      ),

                const SizedBox(height: 50), 

                // Text title
                const Text(
                  "เข้าสู่ระบบด้วยการจดจำใบหน้า",
                  style: TextStyle(
                    fontSize: 22,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Prompt",
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 5), 

                // Sub text
                const Text(
                  "คุณไม่ควรอยู่ในแสงย้อนหรือพื้นที่อื่นๆ\nที่ทำให้คุณภาพการตรวจจับลดลง",
                  style: TextStyle(
                    fontSize: 16,
                    color: Color.fromRGBO(187, 187, 187, 1),
                    fontFamily: "Prompt",
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 50),

                // Capture button
                ElevatedButton(
                  onPressed: () async {
                    try {
                      final image = await controller?.takePicture();
                      if (image != null) {
                        final imagePath = image.path;
                        await AuthService().uploadFaceData(imagePath);
                      } else {
                        print('Image is null');
                      }
                    } catch (e) {
                      print('Error capturing image: $e');
                    }
                  },
                  style: ButtonStyle(
                    // Background color none
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),

                    // Border radius
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),

                    // Border
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Color.fromRGBO(79, 121, 201, 1),
                        width: 1,
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                    fixedSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
                  ),
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.camera_alt, color: Color.fromRGBO(79, 121, 201, 1)),
                      SizedBox(width: 8),
                      Text(
                        "จับภาพ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(79, 121, 201, 1),
                          fontFamily: "Prompt",
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 20),

                // Login with account button
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                      MaterialPageRoute(builder: (context) => const LoginForm()),
                    );
                    // dispose();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(Colors.transparent),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    side: MaterialStateProperty.all<BorderSide>(
                      const BorderSide(
                        color: Color.fromRGBO(79, 121, 201, 1),
                        width: 1,
                      ),
                    ),
                    elevation: MaterialStateProperty.all<double>(0),
                    fixedSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
                  ),
                  
                  child: const Text(
                    "เข้าสู่ระบบด้วยบัญชี",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(79, 121, 201, 1),
                      fontFamily: "Prompt",
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
