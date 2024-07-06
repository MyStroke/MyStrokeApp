import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';

class History extends StatelessWidget {
  const History({super.key, required this.user});
  final User user;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt",
      ),
      home: const HistoryScreen(),
    );
  }
}

class HistoryScreen extends StatelessWidget {
  const HistoryScreen({super.key});

  User get user => FirebaseAuth.instance.currentUser!;

  // Get 10 latest history
  Future<Map<String, Object>> getHistory() async {
    final FirebaseFirestore firestore = FirebaseFirestore.instance;
    final QuerySnapshot result = await firestore
        .collection('History')
        .where('UID_user', isEqualTo: user.uid)
        .orderBy('time', descending: true)
        .limit(10)
        .get();

    final List<DocumentSnapshot> documents = result.docs;
    final numHistory = documents.length;
    final Map<String, Object> data = {
      'num_history': numHistory,
      'history': documents,
    };
    return data;
  }

  @override
  Widget build(BuildContext context) {
    final Future<Map<String, Object>> data = getHistory();
    return Scrollbar(
      child: DecoratedBox(
        // Set background image
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Title
            Container(
              margin: const EdgeInsets.only(top: 80),
              child: const Text(
                'ประวัติการบำบัด',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                ),
              ),
            ),

            Expanded(
              child: FutureBuilder(
                future: data,
                builder: (context, snapshot) {
                  // Check if snapshot has data and is not null
                  if (snapshot.hasData && snapshot.data != null) {
                    final itemCount = (snapshot.data!['num_history'] as int?) ?? 0;
                    final List<DocumentSnapshot> documents = snapshot.data!['history'] as List<DocumentSnapshot>;

                    return ListView.builder(
                      itemCount: itemCount,
                      itemBuilder: (context, index) {
                        final gestures = Map<String, dynamic>.from(documents[index]["gestures"]);

                        return ListTile(
                          // Set time bar chart
                          title: Container(
                            margin: const EdgeInsets.only(bottom: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Expanded(
                                  child: Divider(
                                    color: Color.fromRGBO(79, 121, 201, 1),
                                    thickness: 1,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                                  child: Text(
                                    "วันที่ ${DateFormat('dd/MM/yyyy').format(documents[index]["time"].toDate())} เวลา ${DateFormat('HH:mm').format(documents[index]["time"].toDate())} น.",
                                    style: const TextStyle(
                                      color: Color.fromRGBO(79, 121, 201, 1),
                                    ),
                                  ),
                                ),
                                const Expanded(
                                  child: Divider(
                                    color: Color.fromRGBO(79, 121, 201, 1),
                                    thickness: 1,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          // Bar chart
                          subtitle: Container(
                            // Set gradient background
                            decoration: BoxDecoration(
                              gradient: const LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Color.fromRGBO(38, 85, 176, 1),
                                  Color.fromRGBO(16, 36, 74, 1)
                                ], // Example gradient colors
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(20, 30, 20, 30),
                              child: SizedBox(
                                height: 200,
                                child: BarChart(
                                  BarChartData(
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
                                    alignment: BarChartAlignment.spaceAround,
                                    maxY: gestures.values.reduce((a, b) => a > b ? a : b).toDouble() + 5,
                                    gridData: FlGridData(
                                      show: true,
                                      drawVerticalLine: false,
                                      drawHorizontalLine: true,
                                      horizontalInterval: (gestures.values.reduce((a, b) => a > b ? a : b).toDouble() + 5) / 4,
                                      // gridData 4 horizontal line only
                                      getDrawingHorizontalLine: (value) {
                                        return const FlLine(
                                          color: Color.fromRGBO(71, 143, 238, 0.66),
                                          strokeWidth: 1,
                                        );
                                      },
                                    ),
                                    barGroups: gestures.entries.map<BarChartGroupData>((entry) {
                                      final int x = gestures.keys.toList().indexOf(entry.key);
                                      final int y = entry.value as int;

                                      return BarChartGroupData(
                                        x: x,
                                        barRods: [
                                          BarChartRodData(
                                            toY: y.toDouble(),
                                            width: 11.59,
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
                                    titlesData: FlTitlesData(
                                      rightTitles: const AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                      topTitles: const AxisTitles(
                                        sideTitles: SideTitles(showTitles: false),
                                      ),
                                      bottomTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          getTitlesWidget: (double value, TitleMeta meta) {
                                            final index = value.toInt();
                                            if (index < 0 || index >= gestures.length) {
                                              return const SizedBox.shrink();
                                            }
                                            final key = gestures.keys.elementAt(index);
                                            return Text(
                                              key,
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                      leftTitles: AxisTitles(
                                        sideTitles: SideTitles(
                                          showTitles: true,
                                          interval: 20,
                                          getTitlesWidget: (double value, TitleMeta meta) {
                                            return Text(
                                              value.toInt().toString(),
                                              style: const TextStyle(
                                                color: Colors.white,
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                        );
                      },
                    );
                  } else {
                    return const Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
