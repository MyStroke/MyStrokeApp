import 'package:camera/camera.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:flutter/material.dart';

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
    WidgetsFlutterBinding.ensureInitialized();
    _cameras = await availableCameras();
    controller = CameraController(_cameras[1], ResolutionPreset.medium);
    await controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {
        isCameraInitialized = true;
      });
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

                const SizedBox(height: 75),

                // Face icon
                Image.asset(
                  "assets/login_face/face_icon.png",
                  width: 200,
                ),

                // Camera preview
                !isCameraInitialized
                    ? const CircularProgressIndicator()
                    : AspectRatio(
                        aspectRatio: controller!.value.aspectRatio,
                        child: CameraPreview(controller!),
                      ),

                const SizedBox(height: 75), 

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

                const SizedBox(height: 100),

                // Button capture
                ElevatedButton(onPressed: () {},
                  // Button style
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

                    // Shadow
                    elevation: MaterialStateProperty.all<double>(0),

                    // Width
                    fixedSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
                  ),

                  // Button content
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      Icon(Icons.camera_alt,
                        color: Color.fromRGBO(79, 121, 201, 1),
                      ),

                      SizedBox(width: 8),

                      // Text on button
                      Text("จับภาพ",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(79, 121, 201, 1),
                          fontFamily: "Prompt",
                        ),
                      ),
                    ],
                  )
                ),

                const SizedBox(height: 20),

                // Button move to login page.
                ElevatedButton(onPressed: () {
                    // Move to login page with route
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginForm()),
                    );
                  },

                  // Button style
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

                    // Shadow
                    elevation: MaterialStateProperty.all<double>(0),

                    // Width
                    fixedSize: MaterialStateProperty.all<Size>(const Size(300, 50)),
                  ),
                  
                  child: const Text("เข้าสู่ระบบด้วยบัญชี",
                    style: TextStyle(
                      fontSize: 18,
                      color: Color.fromRGBO(79, 121, 201, 1),
                      fontFamily: "Prompt",
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
