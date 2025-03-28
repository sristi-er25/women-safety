import 'package:flutter/material.dart';
import 'package:women_safety/pages/add_contact_page.dart';
import 'package:women_safety/pages/location_service.dart';
import 'package:women_safety/pages/voice_service.dart';

class Homepage extends StatefulWidget {
  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  String locationText = "Fetching location...";
  String detectedSpeech = "Say something...";
  // String detectedSpeech = "Listening...";
  final VoiceService _voiceService = VoiceService();

  void fetchLocation() async {
    var location = await LocationService().getCurrentLocation();
    if (location != null) {
      setState(() {
        locationText = "Lat: ${location.latitude}, Long: ${location.longitude}";
      });
    }
  }

  void startVoiceDetection() async {
    await _voiceService.startListening((text) async {
      setState(() {
        detectedSpeech = text;
      });

      if (text.contains("help") || text.contains("scream")) {
        print("Emergency detected!");
        var location = await LocationService().getCurrentLocation();
        String emergencyMessage =
            "Emergency! Location: ${location?.latitude}, ${location?.longitude}";

        // TODO: Implement sending SMS with the location
        print(emergencyMessage);
      }
    });
  }

  //   Future<bool> onStart(ServiceInstance service) async {
  //   VoiceService voiceService = VoiceService();

  //   voiceService.startListening((p) {
  //     double amplitude = _calculateAmplitude(p);

  //     if (amplitude > 0.8) {
  //       print("Scream detected!");
  //       startLocationTracking(); // Trigger GPS tracking
  //     }
  //   });

  //   service.on('stopService').listen((event) {
  //     voiceService.stopListening();
  //     service.stopSelf();
  //   });

  //   return true;
  // }

  // double _calculateAmplitude(dynamic data) {
  //   return (data as double) / 100; // Adjust this logic as needed
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.pinkAccent,
        title: Text("Home", style: TextStyle(color: Colors.white)),
      ),
      body: Center(
        // Ensure 'body:' is properly defined
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => AddContactPage()),
                );
              },
              child: Text("Add Emergency Contacts"),
            ),
            SizedBox(height: 20), // Add spacing
            Text("detectedSpeech"), // Text Widget
            SizedBox(height: 10), // Add spacing
            ElevatedButton(
              onPressed: startVoiceDetection,
              child: Text("Start Listening"),
            ),
          ],
        ),
      ),
    );
  }
}
