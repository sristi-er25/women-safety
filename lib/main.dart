import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:women_safety/firebase_options.dart';
import 'package:women_safety/pages/login.dart';
import 'package:women_safety/pages/sign_up_page.dart';
import 'package:women_safety/pages/voice_service.dart';
// import 'package:telephony/telephony.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

Future<bool> onStart(ServiceInstance service) async {
  VoiceService voiceService = VoiceService();
  voiceService.startListening((p0) {});

  service.on('stopService').listen((event) {
    voiceService.stopListening();
    service.stopSelf();
  });
  return true;
}

void initializeService() async {
  final service = FlutterBackgroundService();

  await service.configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onStart,
    ),
  );

  service.startService();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(primaryColor: Color(0xff142831)),
      initialRoute: '/login',
      routes: {
        '/login': (context) => Login(),
        '/signup': (context) => SignUpPage(),
      }, // home: Login(),
      //  SignUpPage()
    );
  }
}


// done run koira dek