import 'package:mystroke_app/service/auth_exception.dart';
import 'package:mystroke_app/service/auth_service.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:flutter/material.dart';

import './login.dart';

class RegisterForm extends StatelessWidget {
  const RegisterForm({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt"
      ),
      home: const RegisterFormScreen(),
    );
  }
}

class RegisterFormScreen extends StatefulWidget {
  const RegisterFormScreen({super.key});

  @override
  State<RegisterFormScreen> createState() => _RegisterFormScreenState();
}

class _RegisterFormScreenState extends State<RegisterFormScreen> {
  final _keyForm = GlobalKey<FormState>();
  final _userController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _obscureText = true;

  void handleSignUp() {
    AuthService().registerWithEmailAndPassword(
      username: _userController.text, 
      email: _emailController.text, 
      password: _passwordController.text
    ).then((status) {
      if (status == AuthResultStatus.successful) {
        Fluttertoast.showToast(
          msg: "สมัครสมาชิกสำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(38, 85, 176, 1),
          textColor: Colors.white,
          fontSize: 16.0
        );
      } else {
        Fluttertoast.showToast(
          msg: "สมัครสมาชิกไม่สำเร็จ",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: const Color.fromRGBO(38, 85, 176, 1),
          textColor: Colors.white,
          fontSize: 16.0
        );
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

        // Set content
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Set title
                const Text(
                  "สมัครสมาชิก",
                  style: TextStyle(
                    fontSize: 28,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Prompt",
                  ),
                ),

                const SizedBox(height: 30),

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
                        width: 170,
                      ),
                    ),
                  )
                ),

                const SizedBox(height: 30),

                // Register Form
                Form(
                  key: _keyForm,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      // Input username
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _userController,
                          obscureText: false,
                          decoration: const InputDecoration(
                            hintText: 'กรอกชื่อผู้ใช้',
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
                              return 'กรุณากรอกชื่อผู้ใช้';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Input email
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

                      const SizedBox(height: 20),

                      // Inpur confirm password 
                      SizedBox(
                        width: 350,
                        child: TextFormField(
                          controller: _confirmPasswordController,
                          obscureText: _obscureText,
                          decoration: InputDecoration(
                            hintText: 'กรอกยืนยันรหัสผ่าน',
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
                              return 'กรุณากรอกยืนยันรหัสผ่าน';
                            }
                            return null;
                          },
                        ),
                      ),

                      const SizedBox(height: 30),

                      // Register button
                      ElevatedButton(onPressed: () {
                        // Check if password and confirm password are the same
                        if (_passwordController != _confirmPasswordController) {
                          Fluttertoast.showToast(
                            msg: "รหัสผ่านไม่ตรงกัน",
                            toastLength: Toast.LENGTH_SHORT,
                            gravity: ToastGravity.BOTTOM,
                            timeInSecForIosWeb: 1,
                            backgroundColor: const Color.fromRGBO(38, 85, 176, 1),
                            textColor: Colors.white,
                            fontSize: 16.0
                          );
                        }

                        // Validate form
                        if (_keyForm.currentState!.validate()) {
                          handleSignUp();
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
                        child: const Text("สมัครสมาชิก",
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

                const SizedBox(height: 20),

                // Button to login
                ElevatedButton(onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const LoginForm()),
                  );
                }, 
                  // Button style
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(53, 65, 80, 1)),
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
        ),
      ),
    );
  }
}