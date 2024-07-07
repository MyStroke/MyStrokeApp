import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../service/auth_getdata.dart';

class Account extends StatelessWidget {
  final User user;
  const Account({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt"
      ),
      home: const AccountScreen(),
    );
  }
}

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreen();
}

class _AccountScreen extends State<AccountScreen> {
  // Create controller for form
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _ageController = TextEditingController();
  final _additionalDiseasesController = TextEditingController();

  // Get current user
  User get user => FirebaseAuth.instance.currentUser!;

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
        
        // Set child
        child: FutureBuilder(
          future: AuthGetdata().getUserData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return const Center(child: Text('No data available'));
            }

            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                SizedBox(
                  child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Profile image
                      CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(snapshot.data!["information"]["profile"]),
                      ),

                      const SizedBox(height: 10),
                      
                      // Text test with user name
                      Text("${snapshot.data!["username"]}",
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      
                      // Text test with user email
                      const Text("ผู้ป่วยโรคหลอดเลือดสมอง",
                        style: TextStyle(
                          fontSize: 16,
                          color: Color(0xBBBBBBBB),
                        ),
                      ),
                      
                      const SizedBox(height: 10),
                      
                      // Button sign out
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(Colors.red),
                          padding: MaterialStateProperty.all(const EdgeInsets.symmetric(horizontal: 30, vertical: 10)),
                        ),
                        onPressed: () async {
                          await FirebaseAuth.instance.signOut();
                        },
                        child: const Text("ออกจากระบบ", style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        )),
                      ),
                    ],
                  )
                ),

                const SizedBox(height: 20),
                
                // Form for update user information
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(37, 51, 69, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color.fromRGBO(126, 169, 252, 1), width: 1),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Form
                            Form(
                              child: Column(
                                children: [
                                  // First name
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _firstNameController,
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        hintText: "ชื่อผู้ใช้",
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
                                  
                                  const SizedBox(height: 10),

                                  // Last name
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _lastNameController, // Use appropriate controller
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        hintText: "นามสกุล",
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
                                        fontFamily: "Prompt",
                                      ),
                                      // Validate
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'กรุณากรอกนามสกุล';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Email
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _emailController, // Use appropriate controller
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        hintText: "อีเมล",
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
                                        fontFamily: "Prompt",
                                      ),
                                      // Validate
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'กรุณากรอกอีเมล';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 10),

                                  // Age
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _ageController, // Use appropriate controller
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        hintText: "อายุ",
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
                                        fontFamily: "Prompt",
                                      ),
                                      // Validate
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'กรุณากรอกอายุ';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),

                                  const SizedBox(height: 10),

                                  // Prefix and Gender row
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // Prefix dropdown
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: DropdownButtonFormField<String>(
                                            decoration: const InputDecoration(
                                              hintText: "คำนำหน้า",
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
                                              fontFamily: "Prompt",
                                            ),
                                            // Validate
                                            validator: (text) {
                                              if (text == null || text.isEmpty) {
                                                return 'กรุณาเลือกคำนำหน้า';
                                              }
                                              return null;
                                            },
                                            items: <String>['นาย', 'นาง', 'นางสาว']
                                              .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(), 
                                            onChanged: (String? value) {  },
                                          ),
                                        ),
                                      ),
                                      
                                      const SizedBox(width: 10),
                                      
                                      // Gender dropdown
                                      Expanded(
                                        flex: 1,
                                        child: SizedBox(
                                          width: double.infinity,
                                          child: DropdownButtonFormField<String>(
                                            decoration: const InputDecoration(
                                              hintText: "เพศ",
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
                                              fontFamily: "Prompt",
                                            ),
                                            // Validate
                                            validator: (text) {
                                              if (text == null || text.isEmpty) {
                                                return 'กรุณาเลือกเพศ';
                                              }
                                              return null;
                                            },
                                            items: <String>['ชาย', 'หญิง']
                                              .map<DropdownMenuItem<String>>((String value) {
                                                return DropdownMenuItem<String>(
                                                  value: value,
                                                  child: Text(value),
                                                );
                                              }).toList(), 
                                            onChanged: (String? value) {  },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),

                                  const SizedBox(height: 10),

                                  // Additional diseases
                                  SizedBox(
                                    width: double.infinity,
                                    child: TextFormField(
                                      controller: _additionalDiseasesController,
                                      obscureText: false,
                                      decoration: const InputDecoration(
                                        hintText: "โรคประจำตัว",
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
                                        fontFamily: "Prompt",
                                      ),
                                      // Validate
                                      validator: (text) {
                                        if (text == null || text.isEmpty) {
                                          return 'กรุณากรอกโรคประจำตัว';
                                        }
                                        return null;
                                      },
                                    ),
                                  ),
                                  
                                  const SizedBox(height: 10),

                                  // Button update
                                  ElevatedButton(
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
                                    
                                    onPressed: () {
                                      // Handle update button press
                                    },
                                    child: const Text(
                                      "บันทึกข้อมูล",
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
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
                ),

                const SizedBox(height: 50),

              ],
            );
          },
        ),
      )
    );
  }
}
