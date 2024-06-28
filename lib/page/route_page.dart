import 'package:flutter/material.dart';

// Page
import './home.dart';
import './account.dart';

class RouterPage extends StatelessWidget {
  const RouterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primaryColor: const Color.fromRGBO(35, 47, 63, 1),
        fontFamily: "Prompt"
      ),
      home: const BottomNavigationBarPage(),
    );
  }
}

class BottomNavigationBarPage extends StatefulWidget {
  const BottomNavigationBarPage({super.key});

  @override
  State<BottomNavigationBarPage> createState() => _BottomNavigationBarPageState();
}

class _BottomNavigationBarPageState extends State<BottomNavigationBarPage> {

  int _selectedIndex = 2;
  static const List<Widget> _widgetOptions = <Widget>[
    Text("History"),
    Text("Class"),
    HomeScreen(),
    Text("Game"),
    AccountScreen(),
  ];

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