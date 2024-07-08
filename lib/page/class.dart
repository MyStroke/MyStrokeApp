import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Class extends StatelessWidget {
  const Class({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt",
      ),
      home: const ClassScreen(),
    );
  }
}

class ClassScreen extends StatefulWidget {
  const ClassScreen({super.key});

  @override
  State<ClassScreen> createState() => _ClassScreenState();
}

class _ClassScreenState extends State<ClassScreen> {
  final TextEditingController _classIdController = TextEditingController();
  User get user => FirebaseAuth.instance.currentUser!;

  // Fetch class data from Firestore
  Future<Map<String, dynamic>?> fetchClassData() async {
    DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Patient').doc(user.uid).get();
    final userData = userDoc.data() as Map<String, dynamic>?;
    if (userData != null && userData.containsKey('class_id') && userData['class_id'] != "") {
      String classId = userData['class_id'];
      DocumentSnapshot classDoc = await FirebaseFirestore.instance.collection('Class').doc(classId).get();
      return classDoc.data() as Map<String, dynamic>?;
    }
    return null;
  }

  // get data users in class from parameter
  Future<Map<String, dynamic>?> fetchUsersData(List<dynamic> users) async {
    Map<String, dynamic> usersData = {};
    for (var user in users) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Patient').doc(user).get();
      usersData[user] = userDoc.data();
    }
    return usersData;
  }

  // get user data from parameter in class
  // Future<Map<String, dynamic>?> fetchUserDataInClass() async {
  //   DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('Patient').doc(user.uid).get();
  //   final userData = userDoc.data() as Map<String, dynamic>?;
  //   if (userData != null && userData.containsKey('class_id') && userData['class_id'] != "") {
  //     String classId = userData['class_id'];
  //     DocumentSnapshot classDoc = await FirebaseFirestore.instance.collection('Class').doc(classId).get();
  //     return classDoc.data() as Map<String, dynamic>?;
  //   }
  //   return null;
  // }


  @override
  Widget build(BuildContext context) {
    final getClassData = fetchClassData();
    return Scaffold(
      body: DecoratedBox(
        // Set background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        // Content
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: FutureBuilder(
            future: getClassData,
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              // Check if the future is done
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }

              // if error
              if (snapshot.hasError) {
                return Center(
                  child: Text("Error: ${snapshot.error}"),
                );
              }

              // if user not in class
              if (!snapshot.hasData || snapshot.data == null) {
                return Form(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("คุณยังไม่ได้เข้าร่วมคลาส",
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.redAccent,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Class ID input
                      SizedBox(
                          width: double.infinity,
                          child: TextFormField(
                            controller: _classIdController,
                            obscureText: false,
                            decoration: const InputDecoration(
                              hintText: 'กรอกรหัสคลาส',
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
                                return 'กรุณากรอกรหัสคลาส';
                              }
                              return null;
                            },
                          ),
                        ),

                      const SizedBox(height: 20),

                      // Submit button
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
                          setState(() {
                            // Here you can add logic to handle the class ID input
                            // For example, update the user's class ID in the database
                          });
                        },
                        child: const Text('เข้าร่วมคลาส',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.white,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      const SizedBox(height: 20),

                      // Or doctor add patient to class
                      const Text("คุณสามารถให้บุคลากรทางการแพทย์\nเพิ่มคุณเข้าร่วมคลาสได้",
                        style: TextStyle(
                          color: Color(0xBBBBBBBB),
                        ),
                        textAlign: TextAlign.center,
                      ),

                    ],
                  ),
                );
              }

              final classUsers = snapshot.data!["users"] as Map<String, dynamic>;

              // if user in class
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Top title
                    Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Greeting message
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // greeting message
                              const Text(
                                "คลาสของคุณ",
                                style: TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),

                              // Greeting message 2
                              Text(
                                "คลาสนี้อยู่ภายใต้การดูแลของ\n${snapshot.data!["doctor"]["doctorName"]}",
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(187, 187, 187, 1),
                                ),
                              ),
                            
                              const SizedBox(height: 10),
                            ],
                          ),

                          // Profile picture
                          Expanded(
                            flex: 2,
                            child: Column(
                              children: [
                                // Profile
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [Container(
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: const Color.fromRGBO(38, 85, 176, 1),
                                        // Outline border color
                                        width: 1.0, // Outline border width
                                      ),
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(5),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(100),
                                        child: Image.network(
                                          "${snapshot.data!["profile"]}",
                                          width: 64,
                                        ),
                                      ),
                                    ),
                                  ),]
                                ),
                                
                                const SizedBox(height: 10),
                              ],
                            ),
                          ),
                        ]
                      ),
                  
                    const SizedBox(height: 10),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(37, 51, 69, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color.fromRGBO(126, 169, 252, 1), width: 1),
                      ),
                    
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: FutureBuilder(
                          future: fetchClassData(),
                          builder: (context, userClassData) {
                            if (userClassData.connectionState == ConnectionState.waiting) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }

                            if (userClassData.hasError) {
                              return Center(
                                child: Text("Error: ${userClassData.error}"),
                              );
                            }

                            if (!userClassData.hasData || userClassData.data == null) {
                              return const Text("Error: No data");
                            }

                            final userDataInClass = userClassData.data!["users"][user.uid] as Map<String, dynamic>;
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Text title
                                const Text("คำแนะนำจากบุคลากรทางการแพทย์",
                                  style: TextStyle(
                                    fontSize: 18,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const SizedBox(height: 10),

                                // Text content
                                Text("คำแนะนำ: ${userDataInClass["comment"]}",
                                  style: const TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            );
                          }
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Class info
                    Container(
                      width: double.infinity,
                      height: 300,
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(53, 65, 81, 1),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: const Color.fromRGBO(126, 169, 252, 1), width: 1),
                      ),

                      // All members
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Class name
                            Row(
                              children: [
                                Text(
                                  snapshot.data!["name"],
                                  style: const TextStyle(
                                    fontSize: 22,
                                    color: Colors.white,
                                  ),
                                ),

                                Expanded(
                                  child: Text("จำนวนสมาชิก: ${classUsers.length} คน",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                    textAlign: TextAlign.end,
                                  ),
                                ),
                              ]
                            ),

                            const SizedBox(height: 10),

                            // Class Members
                            Expanded(
                              child: ListView(
                                scrollDirection: Axis.vertical,
                                children: [
                                
                                  ...classUsers.entries.take(3).map((entry) {
                                    return FutureBuilder(
                                      future: fetchUsersData([entry.key]), 
                                      builder: (BuildContext context, AsyncSnapshot userSnapshot) {
                                        if (userSnapshot.connectionState == ConnectionState.waiting) {
                                          return const Center(
                                            child: CircularProgressIndicator(),
                                          );
                                        }

                                        if (userSnapshot.hasError) {
                                          return Center(
                                            child: Text("Error: ${userSnapshot.error}"),
                                          );
                                        }

                                        if (!userSnapshot.hasData || userSnapshot.data == null) {
                                          return const Text("Error: No data");
                                        }

                                        final userData = userSnapshot.data[entry.key] as Map<String, dynamic>;
                                    
                                        return Container(
                                          width: double.infinity,
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(12),
                                            color: const Color.fromRGBO(37, 51, 69, 1),
                                          ),
                                          margin: const EdgeInsets.only(bottom: 10),
                                          child: Padding(
                                            padding: const EdgeInsets.all(15),
                                            child: Row(
                                              children: [
                                                  // Profile picture
                                                  CircleAvatar(
                                                    radius: 20,
                                                    backgroundImage: NetworkImage("${userData["information"]["profile"]}",
                                                    ),
                                                  ),

                                                  const SizedBox(width: 10),

                                                  Text("${userData["username"]}",
                                                    style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 14,
                                                    ),
                                                  ),

                                              ]
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  }),
                                ]
                              ),
                            ),

                          ],
                        ),
                      ),
                    ),
                  
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
