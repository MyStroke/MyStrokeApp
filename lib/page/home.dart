import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../service/auth_getdata.dart';

// Page
import './route_page.dart';

class Home extends StatelessWidget {
  final User user;
  final List<Map<String, dynamic>> data;
  const Home({super.key, required this.user, required this.data});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt",
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  User get user => FirebaseAuth.instance.currentUser!;

  /*-------------------------- Read History --------------------------*/
  Future<List<Map<String, dynamic>>> fetchData() async {
    CollectionReference history = FirebaseFirestore.instance.collection('History');
    QuerySnapshot querySnapshot = await history
        .where('UID_user', isEqualTo: user.uid)
        .orderBy('time', descending: true)
        .limit(7)
        .get();
    return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }

  List<Map<String, dynamic>> processData(List<Map<String, dynamic>> rawData) {
    return rawData.map((data) {
      return {
        'date': "${DateFormat('H').format(data['time'].toDate())}:${DateFormat('m').format(data['time'].toDate())} น.",
        'score': data['score'],
      };
    }).toList();
  }
  
  Future<int> getActive() async {
    CollectionReference history = FirebaseFirestore.instance.collection('History');
    DateTime now = DateTime.now();
    String todayFormat = DateFormat('yyyy-MM-dd').format(now);
    QuerySnapshot querySnapshot = await history
        .where('UID_user', isEqualTo: user.uid)
        .where('date', isEqualTo: todayFormat)
        .get();

    return querySnapshot.docs.length;
  }

  /*-------------------------- Read Class --------------------------*/
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

  @override
  Widget build(BuildContext context) {
    final Future<Map<String, dynamic>> getUserData = AuthGetdata().getUserData();
    final Future<List<Map<String, dynamic>>> getHistoryData = fetchData();
    final Future<Map<String, dynamic>?> getClassData = fetchClassData();

    // Function to shorten UID
    String shortenUid(String uid) {
      if (uid.length > 8) {
        return '${uid.substring(0, 4)}...${uid.substring(uid.length - 4)}';
      }
      return uid;
    }

    return Scaffold(
      body: DecoratedBox(
        // Set background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),

        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FutureBuilder<Map<String, dynamic>>(
                future: getUserData,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData) {
                    // Handle the case where snapshot doesn't have data
                    return const Center(child: Text("No data available"));
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        // crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Greeting message
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // greeting message
                              Text(
                                "สวัสดี ${snapshot.data!["username"]}!",
                                style: const TextStyle(
                                  fontSize: 24,
                                  color: Colors.white,
                                ),
                              ),

                              // Greeting message 2
                              const Text(
                                "วันนี้คุณทำไรไปบ้าง?",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Color.fromRGBO(187, 187, 187, 1),
                                ),
                              ),
                            
                              const SizedBox(height: 10),

                              // Mood rating  (5 smiley faces)
                              Container(
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color.fromRGBO(100, 123, 155, 1),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                
                                child: const Padding(
                                  padding: EdgeInsets.all(10),
                                  child: Row(
                                    children: [
                                      Icon(Icons.sentiment_satisfied_alt_rounded,
                                        color: Color.fromRGBO(97, 255, 41, 1),
                                        size: 25,
                                      ),

                                      SizedBox(width: 10),

                                      Icon(Icons.sentiment_satisfied_alt_rounded,
                                        color: Color.fromRGBO(97, 255, 41, 1),
                                        size: 25,
                                      ),

                                      SizedBox(width: 10),

                                      Icon(Icons.sentiment_satisfied_alt_rounded,
                                        color: Color.fromRGBO(97, 255, 41, 1),
                                        size: 25,
                                      ),

                                      SizedBox(width: 10),

                                      Icon(Icons.sentiment_satisfied_alt_rounded,
                                        color: Color.fromRGBO(187, 187, 187, 1),
                                        size: 25,
                                      ),

                                      SizedBox(width: 10),

                                      Icon(Icons.sentiment_satisfied_alt_rounded,
                                        color: Color.fromRGBO(187, 187, 187, 1),
                                        size: 25,
                                      ),
                                    ]
                                  ),
                                ),
                              ),
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
                                          "${snapshot.data!["information"]["profile"]}",
                                          width: 64,
                                        ),
                                      ),
                                    ),
                                  ),]
                                ),
                                
                                const SizedBox(height: 10),

                                // UID
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text("UID: ${shortenUid(user.uid)}",
                                      style: const TextStyle(
                                        color: Color.fromRGBO(187, 187, 187, 1),
                                        fontSize: 12,
                                      ),
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                    ),
                                  ]
                                ),
                              ],
                            ),
                          ),
                        ]
                      ),

                      const SizedBox(height: 30),

                      // Box scrolling
                      Container(
                        height: 366,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(100, 123, 155, 1),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromRGBO(39, 48, 61, 0.5),
                        ),

                        // Box content
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(25, 10, 25, 10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Menu
                              const Text("เมนู",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),

                              // Scrolling items
                              Expanded(
                                child: ListView(
                                  scrollDirection: Axis.vertical,
                                  children: [
                                    // Histoty box
                                    ElevatedButton(onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => const RouterPage(selectedIndex: 0)),
                                      );
                                    },
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(39, 48, 61, 1)),

                                        side: MaterialStateProperty.all<BorderSide>(
                                          const BorderSide(
                                            color: Color.fromRGBO(100, 123, 155, 1),
                                            width: 1.0,
                                          ),
                                        ),

                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                      
                                      // Box content
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // History
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.content_paste,
                                                  color: Color.fromRGBO(126, 169, 252, 1),
                                                  size: 25,
                                                ),

                                                SizedBox(width: 5),

                                                Text("ประวัติการบำบัด",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              
                                              ]
                                            ),

                                            const SizedBox(height: 10),

                                            // History description
                                            const Text("การบำบัดล่าสุด",
                                              style: TextStyle(
                                                color: Color(0xBBBBBBBB),
                                                fontSize: 15,
                                              ),
                                            ),
                                          
                                            const SizedBox(height: 20),

                                            // Bar chart
                                            FutureBuilder<List<Map<String, dynamic>>>(
                                              future: getHistoryData,
                                              builder: (context, snapshot) {
                                                if (snapshot.connectionState == ConnectionState.waiting) {
                                                  return const Center(child: CircularProgressIndicator());
                                                }
                                                final data = processData(snapshot.data!);
                                                return AspectRatio(
                                                  aspectRatio: 2.0,
                                                  child: BarChart(
                                                    BarChartData(
                                                      maxY: 100,
                                                      alignment: BarChartAlignment.spaceAround,
                                                      barTouchData: BarTouchData(enabled: false),
                                                      borderData: FlBorderData(
                                                        show: true,
                                                        border: const Border(
                                                          top: BorderSide(
                                                            color: Color.fromRGBO(71, 143, 238, 0.66),
                                                            width: 1,
                                                          ),
                                                          right: BorderSide.none,
                                                          left: BorderSide.none,
                                                          bottom: BorderSide(
                                                            color: Color.fromRGBO(71, 143, 238, 0.66),
                                                            width: 1,
                                                          ),
                                                        ),
                                                      ),
                                                      gridData: FlGridData(
                                                        show: true,
                                                        drawVerticalLine: false,
                                                        drawHorizontalLine: true,
                                                        horizontalInterval: 20,
                                                        getDrawingHorizontalLine: (value) {
                                                          return const FlLine(
                                                            color: Color.fromRGBO(71, 143, 238, 1),
                                                            strokeWidth: 1,
                                                          );
                                                        },
                                                      ),
                                                      titlesData: FlTitlesData(
                                                        rightTitles: const AxisTitles(
                                                          sideTitles: SideTitles(showTitles: false),
                                                        ),
                                                        topTitles: const AxisTitles(
                                                          sideTitles: SideTitles(showTitles: false),
                                                        ),
                                                        leftTitles: AxisTitles(
                                                          sideTitles: SideTitles(
                                                            showTitles: true,
                                                            reservedSize: 28,
                                                            getTitlesWidget: (value, meta) {
                                                              return Text(
                                                                value.toString().split(".")[0],
                                                                style: const TextStyle(color: Colors.white),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                        bottomTitles: AxisTitles(
                                                          sideTitles: SideTitles(
                                                            showTitles: true,
                                                            getTitlesWidget: (value, meta) {
                                                              return Text(
                                                                data[value.toInt()]['date'],
                                                                style: const TextStyle(color: Colors.white),
                                                              );
                                                            },
                                                          ),
                                                        ),
                                                      ),
                                                      barGroups: data.asMap().entries.map((entry) {
                                                        final index = entry.key;
                                                        final item = entry.value;
                                                        return BarChartGroupData(
                                                          x: index,
                                                          barRods: [
                                                            BarChartRodData(
                                                              toY: item['score'].toDouble(),
                                                              width: 11.59,
                                                              // gradient color
                                                              gradient: const LinearGradient(
                                                                colors: [
                                                                  Color.fromRGBO(255, 255, 255, 1),
                                                                  Color.fromRGBO(123, 127, 223, 1),
                                                                ],
                                                                begin: Alignment.topCenter,
                                                                end: Alignment.bottomCenter,
                                                              ),
                                                            ),
                                                          ],
                                                        );
                                                      }).toList(),
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    // Class box
                                    ElevatedButton(onPressed: () {},
                                      style: ButtonStyle(
                                        backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(53, 65, 81, 1)),

                                        side: MaterialStateProperty.all<BorderSide>(
                                          const BorderSide(
                                            color: Color.fromRGBO(100, 123, 155, 1),
                                            width: 1.0,
                                          ),
                                        ),

                                        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                          RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(20),
                                          ),
                                        ),
                                      ),
                                    
                                      // Box content
                                      child: Padding(
                                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            // Class title
                                            const Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              children: [
                                                Icon(Icons.supervisor_account,
                                                  color: Color.fromRGBO(126, 169, 252, 1),
                                                  size: 25,
                                                ),

                                                SizedBox(width: 5),

                                                Text("คลาสของคุณ",
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 18,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              
                                              ]
                                            ),
                                          
                                            const SizedBox(height: 10),

                                            // Class member
                                            FutureBuilder<Map<String, dynamic>?>(
                                              future: getClassData,
                                              builder: (context, classSnapshot) {
                                                // Loading
                                                if (classSnapshot.connectionState == ConnectionState.waiting) {
                                                  return const Center(child: CircularProgressIndicator());
                                                }

                                                // No class
                                                if (!classSnapshot.hasData || classSnapshot.data == null) {
                                                  return const Center(
                                                    child: Text(
                                                      "คุณยังไม่ได้เข้าคลาส",
                                                      style: TextStyle(
                                                        color: Colors.redAccent,
                                                        fontSize: 18,
                                                        // fontWeight: FontWeight.bold,
                                                      ),
                                                    ),
                                                  );
                                                }

                                                // Class data
                                                final Map<String, dynamic> classData = classSnapshot.data as Map<String, dynamic>;
                                                
                                                final Map<String, dynamic> users = classData['users'] as Map<String, dynamic>? ?? {};


                                                return Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Class description
                                                    Text("สมาชิกภายในคลาส ${classData['name']}",
                                                      style: const TextStyle(
                                                        color: Color(0xBBBBBBBB),
                                                        fontSize: 15,
                                                      ),
                                                    ),
                                          
                                                    const SizedBox(height: 10),

                                                    ...users.entries.take(3).map((entry) {
                                                      return 
                                                      Container(
                                                        width: double.infinity,
                                                        decoration: BoxDecoration(
                                                          borderRadius: BorderRadius.circular(50),
                                                          color: const Color.fromRGBO(37, 51, 69, 1),
                                                        ),
                                                        child: Padding(
                                                          padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                                          child: Row(
                                                            children: [

                                                                Text("${entry.value['username']}",
                                                                style: const TextStyle(
                                                                  color: Colors.white,
                                                                  fontWeight: FontWeight.bold,
                                                                ),


                                                              ),
                                                            ],
                                                          )
                                                        ),
                                                      );
                                                    }),
                                                  ],
                                                );
                                              },
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),

                                    const SizedBox(height: 15),

                                    // Box game and active
                                    Row(
                                      children: [
                                        // Game box
                                        Expanded(
                                          child: Container(
                                            constraints: const BoxConstraints.tightFor(height: 150.0),

                                            child: ElevatedButton(onPressed: () {},
                                              style: ButtonStyle(
                                                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(53, 65, 81, 1)),

                                                side: MaterialStateProperty.all<BorderSide>(
                                                  const BorderSide(
                                                    color: Color.fromRGBO(100, 123, 155, 1),
                                                    width: 1.0,
                                                  ),
                                                ),

                                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                                  RoundedRectangleBorder(
                                                    borderRadius: BorderRadius.circular(20),
                                                  ),
                                                ),
                                              ),
                                            
                                              // Box content
                                              child: Padding(
                                                padding: const EdgeInsets.fromLTRB(0, 3, 0, 3),
                                                child: Column(
                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                  children: [
                                                    // Game title
                                                    const Row(
                                                      mainAxisAlignment: MainAxisAlignment.start,
                                                      children: [
                                                        Icon(Icons.sports_esports,
                                                          color: Color.fromRGBO(126, 169, 252, 1),
                                                          size: 25,
                                                        ),

                                                        SizedBox(width: 5),

                                                        Text("เกม",
                                                          style: TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 18,
                                                            fontWeight: FontWeight.bold,
                                                          ),
                                                        ),
                                                      
                                                      ]
                                                    ),

                                                    // Game description
                                                    const Text("MyStrokeGame",
                                                      style: TextStyle(
                                                        color: Color(0xBBBBBBBB),
                                                        fontSize: 12,
                                                      ),
                                                    ),

                                                    // Image game
                                                    Center(
                                                      child: Image.asset("assets/page/gameinfo.png"),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                        ),
                                      ),

                                        const SizedBox(width: 15),

                                        // Active box
                                        Expanded(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              border: Border.all(
                                                color: const Color.fromRGBO(100, 123, 155, 1),
                                                width: 1.0,
                                              ),
                                              borderRadius: BorderRadius.circular(20),
                                              color: const Color.fromRGBO(39, 48, 61, 1),
                                            ),
                                            height: 150,

                                            // Box content
                                            child: Padding(
                                              padding: const EdgeInsets.fromLTRB(10, 3, 10, 3),
                                              child: Column(
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  // Active title
                                                  const Row(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    children: [
                                                      Icon(Icons.check_circle_outline,
                                                        color: Color.fromRGBO(126, 169, 252, 1),
                                                        size: 25,
                                                      ),

                                                      SizedBox(width: 5),

                                                      Text("กิจกรรม",
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                          fontWeight: FontWeight.bold,
                                                        ),
                                                      ),
                                                    
                                                    ]
                                                  ),

                                                  // Active description
                                                  const Text("วันนี้บำบัดไปแล้ว",
                                                    style: TextStyle(
                                                      color: Color(0xBBBBBBBB),
                                                      fontSize: 12,
                                                    ),
                                                  ),

                                                  const SizedBox(height: 20),

                                                  // text active
                                                  FutureBuilder(
                                                    future: getActive(), 
                                                    builder: (context, snapshot) {
                                                      if (snapshot.connectionState == ConnectionState.waiting) {
                                                        return const Center(child: CircularProgressIndicator());
                                                      }
                                                      return Center(
                                                        child: Text("${snapshot.data} ครั้ง",
                                                          style: const TextStyle(
                                                            color: Color.fromARGB(255, 18, 212, 118),
                                                            fontSize: 20,
                                                          ),
                                                        ),
                                                      );
                                                    }
                                                  ),
                                                ],
                                              ),
                                            ),
                                          )
                                        ),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // Take a walk box
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: const Color.fromRGBO(100, 123, 155, 1),
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(12),
                          color: const Color.fromRGBO(39, 48, 61, 1),
                        ),

                        // Box content
                        child: const Padding(
                          padding: EdgeInsets.fromLTRB(20, 15, 20, 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Take a walk
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(Icons.directions_walk,
                                    color: Color.fromRGBO(126, 169, 252, 1),
                                    size: 25,
                                  ),

                                  SizedBox(width: 5),

                                  Text("เดินเล่น",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ]
                              ),

                              SizedBox(height: 10),

                              // Take a walk description
                              Text("การเดินเป็นกิจกรรมหนึ่งสำหรับโรคหลอดเลือดสมอง ช่วยให้ฟื้นสมดุลของความแข็งแรงของกล้ามเนื้อและความแข็งแกร่ง",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
