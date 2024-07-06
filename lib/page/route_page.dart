import 'package:flutter/material.dart';

// Page
import './home.dart';
import './account.dart';
import './history.dart';

class RouterPage extends StatelessWidget {
  final int selectedIndex;

  const RouterPage({super.key, this.selectedIndex = 2});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt",
      ),
      home: BottomNavigationBarPage(selectedIndex: selectedIndex),
    );
  }
}

class BottomNavigationBarPage extends StatefulWidget {
  final int selectedIndex;

  const BottomNavigationBarPage({super.key, required this.selectedIndex});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {
  late int _selectedIndex;

  static const List<Widget> _widgetOptions = <Widget>[
    HistoryScreen(),
    Text("Class"),
    HomeScreen(),
    Text("Game"),
    AccountScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.selectedIndex;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/background.jpg"), 
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
      ),
      
      // Bottom navigation bar
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          // History
          BottomNavigationBarItem(
            icon: Icon(Icons.content_paste, size: 28),
            label: "History",
            backgroundColor: Color.fromRGBO(53, 65, 81, 1),
          ),

          // Class
          BottomNavigationBarItem(
            icon: Icon(Icons.groups, size: 28),
            label: "Class",
            backgroundColor: Color.fromRGBO(53, 65, 81, 1),
          ),

          // Home
          BottomNavigationBarItem(
            icon: Icon(Icons.home, size: 30),
            label: "Home",
            backgroundColor: Color.fromRGBO(53, 65, 81, 1),
          ),

          // Game
          BottomNavigationBarItem(
            icon: Icon(Icons.sports_esports, size: 28),
            label: "Game",
            backgroundColor: Color.fromRGBO(53, 65, 81, 1),
          ),

          // Account
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle, size: 28),
            label: "Account",
            backgroundColor: Color.fromRGBO(53, 65, 81, 1),
          ),
        ],

        currentIndex: _selectedIndex,
        type: BottomNavigationBarType.shifting,
        backgroundColor: const Color.fromRGBO(53, 65, 81, 1),
        selectedItemColor: const Color.fromRGBO(96, 138, 220, 1),
        selectedFontSize: 15,
        unselectedItemColor: const Color.fromRGBO(96, 138, 220, 1),
        onTap: _onItemTapped,
      ),
    );
  }
}
