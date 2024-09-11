import 'package:flutter/material.dart';

class Quests extends StatelessWidget {
  const Quests({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt",
      ),
      // home: const ClassScreen(),
    );
  }
}

class QuestsScreen extends StatefulWidget {
  const QuestsScreen({super.key});

  @override
  State<QuestsScreen> createState() => _QuestsScreenState();
}

class _QuestsScreenState extends State<QuestsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        // Set background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background2.png"),
            fit: BoxFit.cover,
          ),
        ),

        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Back button
            Container(
              alignment: Alignment.topLeft,
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromRGBO(53, 65, 81, 1),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(12),
                      bottomRight: Radius.circular(12),
                    ),
                  ),
                ),
                child: const Icon(
                  Icons.close,
                  color: Colors.white,
                  size: 40,
                ),
              ),
            ),

            // Box quests
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Box quests
                  Container(
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(35, 47, 63, 0.79), // Background color
                      borderRadius: BorderRadius.all(Radius.circular(20)),
                    ),
                    height: 520,

                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Title
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "ภารกิจประจำวัน",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          // Subtitle
                          Container(
                            alignment: Alignment.topLeft,
                            child: const Text(
                              "ภารกิจทั้งหมดที่ต้องทำในวันนี้",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 12,
                              ),
                              textAlign: TextAlign.start,
                            ),
                          ),

                          // Space
                          const SizedBox(height: 20),

                          // Quest 1
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(37, 51, 69, 1), // Background color
                              borderRadius: BorderRadius.all(Radius.circular(17)), // Rounded corner
                            ),
                            width: double.infinity,

                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // Text
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "กายภาพบำบัดใน โหมดง่าย",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  // Subtitle
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "เล่น MyStrokeGame\nในความยากระดับง่าย 2 ครั้ง",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                
                                  // Space
                                  const SizedBox(height: 10),
                                
                                  // Procress
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    child: SizedBox(
                                      height: 16,
                                      child: Stack(
                                        children: [
                                          // Background color (Solid)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(61, 75, 90, 1), // สีพื้นหลังของ progress bar
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),

                                          // Gradient progress bar
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Container(
                                                width: constraints.maxWidth * 0.5, 
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [Color.fromRGBO(123, 127, 223, 1), Colors.white], // สี gradient
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              );
                                            },
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),

                          // Space
                          const SizedBox(height: 20),

                          // Quest 2
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(37, 51, 69, 1), // Background color
                              borderRadius: BorderRadius.all(Radius.circular(17)), // Rounded corner
                            ),
                            width: double.infinity,

                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // Text
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "กายภาพบำบัดใน โหมดปานกลาง",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  // Subtitle
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "เล่น MyStrokeGame\nในความยากระดับปานกลาง 1 ครั้ง",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                
                                  // Space
                                  const SizedBox(height: 10),
                                
                                  // Procress
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    child: SizedBox(
                                      height: 16,
                                      child: Stack(
                                        children: [
                                          // Gradient progress bar
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              // If completed
                                              if (1 == 1) {
                                                return Container(
                                                  alignment: Alignment.center,
                                                  width: constraints.maxWidth * 1,
                                                  child: const Text("สำเร็จแล้ว",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15,
                                                    ),
                                                  ),
                                                );
                                              }

                                              // If not completed
                                              return Container(
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(61, 75, 90, 1), // สีพื้นหลังของ progress bar
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                        
                                                child: Container(
                                                  width: constraints.maxWidth * 0.5, 
                                                  decoration: BoxDecoration(
                                                    gradient: const LinearGradient(
                                                      colors: [Color.fromRGBO(123, 127, 223, 1), Colors.white], // สี gradient
                                                      begin: Alignment.centerLeft,
                                                      end: Alignment.centerRight,
                                                    ),
                                                    borderRadius: BorderRadius.circular(5),
                                                  ),
                                                )
                                              );
                                            
                                            },
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        
                          // Space
                          const SizedBox(height: 20),

                          // Quest 3
                          Container(
                            decoration: const BoxDecoration(
                              color: Color.fromRGBO(37, 51, 69, 1), // Background color
                              borderRadius: BorderRadius.all(Radius.circular(17)), // Rounded corner
                            ),
                            width: double.infinity,

                            child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  // Text
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "กายภาพบำบัดใน โหมดยาก",
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold
                                      ),
                                    ),
                                  ),

                                  // Subtitle
                                  Container(
                                    alignment: Alignment.topLeft,
                                    child: const Text(
                                      "เล่น MyStrokeGame\nในความยากระดับยาก 1 ครั้ง",
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ),
                                
                                  // Space
                                  const SizedBox(height: 10),
                                
                                  // Procress
                                  ClipRRect(
                                    borderRadius: const BorderRadius.all(Radius.circular(5)),
                                    child: SizedBox(
                                      height: 16,
                                      child: Stack(
                                        children: [
                                          // Background color (Solid)
                                          Container(
                                            decoration: BoxDecoration(
                                              color: const Color.fromRGBO(61, 75, 90, 1), // สีพื้นหลังของ progress bar
                                              borderRadius: BorderRadius.circular(5),
                                            ),
                                          ),

                                          // Gradient progress bar
                                          LayoutBuilder(
                                            builder: (context, constraints) {
                                              return Container(
                                                width: constraints.maxWidth * 0.5, 
                                                decoration: BoxDecoration(
                                                  gradient: const LinearGradient(
                                                    colors: [Color.fromRGBO(123, 127, 223, 1), Colors.white], // สี gradient
                                                    begin: Alignment.centerLeft,
                                                    end: Alignment.centerRight,
                                                  ),
                                                  borderRadius: BorderRadius.circular(5),
                                                ),
                                              );
                                            },
                                          ),
                                          
                                        ],
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}