import 'dart:async';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'voice_service.dart'; 
import 'location_service.dart';

// Future<bool> onStart(ServiceInstance service) async {
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



Future<bool> onStart(ServiceInstance service) async {
  VoiceService voiceService = VoiceService();
  voiceService.startListening((p0) {
    
  },);

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


