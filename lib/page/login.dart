import 'package:mystroke_app/service/auth_exception.dart';
import '../service/auth_service.dart';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

import 'login_face.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: LoginFormScreen(),
    );
  }
}

class LoginFormScreen extends StatefulWidget {
  const LoginFormScreen({super.key});

  @override
  State<LoginFormScreen> createState() => _LoginFormScreen();
}

class _LoginFormScreen extends State<LoginFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscureText = true;

  // Login function
  void handleLogin() {
    AuthService().loginWithEmailAndPassword(
      email: _emailController.text, 
      password: _passwordController.text
    ).then((status) {
      if (status == AuthResultStatus.successful) {
        Fluttertoast.showToast(msg: "เข้าสู่ระบบสำเร็จ");
      } else {
        final errorMsg = AuthExceptionHandler.errorMessage(status);
        Fluttertoast.showToast(msg: errorMsg);
      }
    });
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
                // Icon App
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: const Color.fromRGBO(38, 85, 176, 1), // Outline border color
                      width: 1.0, // Outline border width
                    ),
                    borderRadius: BorderRadius.circular(100),
                  ),
                  
                  child: Padding(
                    padding: const EdgeInsets.all(5),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(100),
                      child: Image.asset(
                        "assets/icon.png",
                        width: 200,
                      ),
                    ),
                  )
                ),

                const SizedBox(height: 50),

                // Login form
                Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Input username
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _emailController,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'กรอกอีเมลผู้ใช้',
                            hintStyle: TextStyle(color: Colors.white),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            fillColor: Color.fromRGBO(53, 65, 80, 1),
                            filled: true,

                            // On focus border color
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Color.fromRGBO(35, 47, 63, 1), width: 3),
                            ),

                            // Validate
                            errorStyle: TextStyle(
                              fontFamily: "Prompt",
                            ),
                          ),
                          
                          // Style
                          style: const TextStyle(
                            color: Colors.white,
                            // fontSize: 12,
                            fontFamily: "Prompt",
                          ),
                          
                          // Validate
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'กรุณากรอกอีเมลผู้ใช้';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Input password
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'กรอกรหัสผ่าน',
                            hintStyle: const TextStyle(color: Colors.white),
                            border: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                            ),
                            fillColor: const Color.fromRGBO(53, 65, 80, 1),
                            filled: true,

                            // icon for show password
                            suffixIcon: IconButton(
                              icon: Icon(_obscureText ? Icons.visibility : Icons.visibility_off,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscureText = !_obscureText;
                                });
                              },
                            ),

                            // On focus border color
                            focusedBorder: const OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(color: Color.fromRGBO(35, 47, 63, 1), width: 3),
                            ),

                            // Validate
                            errorStyle: const TextStyle(
                              fontFamily: "Prompt",
                            ),
                          ),

                          // Style
                          style: const TextStyle(
                            color: Colors.white,
                            // fontSize: 12,
                            fontFamily: "Prompt",
                          ),

                          // Validate
                          validator: (text) {
                            if (text == null || text.isEmpty) {
                              return 'กรุณากรอกรหัสผ่าน';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 50),

                      // Login button
                      ElevatedButton(onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          handleLogin();
                        }
                      }, 
                        // Button style
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(38, 85, 176, 1)),
                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                          ),
                          elevation: MaterialStateProperty.all<double>(0),
                          fixedSize: MaterialStateProperty.all<Size>(const Size(250, 50)),
                        ),

                        // Button content
                        child: const Text("เข้าสู่ระบบ",
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                            fontFamily: "Prompt",
                          ),
                        ),
                      ),
                    
                    ],
                  ),
                ),

                const SizedBox(height: 50),

                // Button move to login face page
                ElevatedButton(onPressed: () {
                    // Move to login page with route
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginFace()),
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
                  
                  child: const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Icon
                      Icon(Icons.face,
                        color: Color.fromRGBO(79, 121, 201, 1),
                      ),

                      SizedBox(width: 10),

                      // Text on button
                      Text("เข้าสู่ระบบด้วยใบหน้า",
                        style: TextStyle(
                          fontSize: 18,
                          color: Color.fromRGBO(79, 121, 201, 1),
                          fontFamily: "Prompt",
                        ),
                      ),
                    ],
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