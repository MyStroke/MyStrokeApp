import 'package:flutter/material.dart';
import 'package:mystroke_app/page/quests.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'MyStroke',
    theme: ThemeData(
      primaryColor: const Color.fromRGBO(35, 47, 63, 1),
      fontFamily: "Prompt"
    ),
    home: const GameScreen(),
  ));
}

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
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

        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Quest
              Align(
                alignment: Alignment.topRight,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color.fromRGBO(53, 65, 81, 1), // Background color
                    shape: BoxShape.circle, // Circular shape
                  ),
                  child: IconButton(
                    icon: const Icon(Icons.receipt_long, 
                      color: Colors.white, 
                      size: 30
                    ),
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => const QuestsScreen())
                      );
                    },
                    padding: const EdgeInsets.all(16), // Adjust padding as needed
                  ),
                ),
              ),

              // Space
              const SizedBox(height: 20),

              // Game regular
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(39, 48, 61, 1)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(300, 200)),
                ),
                child: const Column(
                  children: [
                    // Titile
                    Text('เล่นแบบต่อเนื่อง', 
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),

                    // Description
                    Text('(แบบปกติ)', 
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                  ],
                )
              ),

              // Space
              const SizedBox(height: 20),

              // Game mode
              ElevatedButton(
                onPressed: () {},
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(const Color.fromRGBO(39, 48, 61, 0.60)),
                  padding: MaterialStateProperty.all<EdgeInsetsGeometry>(const EdgeInsets.all(20)),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(const Size(300, 200)),
                ),
                child: const Text('เล่นแบบโหมด', 
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
              ),
              
            ],
          ),
        ),
      ),
    );
  }
}
