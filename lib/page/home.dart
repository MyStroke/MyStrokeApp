import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../service/auth_getdata.dart';

// Page
// import '';

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

  @override
  Widget build(BuildContext context) {
    final Future<Map<String, dynamic>> getUserData = AuthGetdata().getUserData();
    final Future<List<Map<String, dynamic>>> getHistoryData = fetchData();

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
                    return const CircularProgressIndicator();
                  }
                  if (!snapshot.hasData) {
                    // Handle the case where snapshot doesn't have data
                    return const Text("No data available");
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
                                    ElevatedButton(onPressed: () {},
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
                                        padding: const EdgeInsets.fromLTRB(0, 15, 0, 5),
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
                                                  return const CircularProgressIndicator();
                                                }
                                                final data = processData(snapshot.data!);
                                                return AspectRatio(
                                                  aspectRatio: 2.0,
                                                  child: BarChart(
                                                    BarChartData(
                                                      alignment: BarChartAlignment.spaceAround,
                                                      barTouchData: BarTouchData(enabled: false),
                                                      borderData: FlBorderData(show: false),
                                                      gridData: FlGridData(
                                                        show: true,
                                                        drawVerticalLine: false,
                                                        drawHorizontalLine: true,
                                                        horizontalInterval: 1.8,
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
