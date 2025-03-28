import 'package:flutter/material.dart';
import 'package:women_safety/pages/login.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void startVoiceService() {
    print(
      "Voice detection started",
    ); // Replace with actual voice detection logic
  }

  void openLocationService() {
    print("Location service activated"); // Replace with actual location logic
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Login()),
              );
            },

            // Navigator.pushReplacement(
            //     context, MaterialPageRoute(builder: (context) => Login()));
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: startVoiceService,
              child: Text("Add Emergency Contacts"),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: startVoiceService,
              child: Text("Record voice"),
            ),
          ],
        ),
      ),
    );
  }
}
