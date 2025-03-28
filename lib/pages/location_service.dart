import 'package:geolocator/geolocator.dart';
// import 'package:telephony/telephony.dart';


// Future<void> startLocationTracking() async {
//   Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
//   sendEmergencySMS(position);
// }

// void sendEmergencySMS(Position position) {
//   final Telephony telephony = Telephony.instance;

//   telephony.sendSms(
//     to: "+1234567890", // Change to actual emergency contact
//     message: "🚨 Scream detected! Location: https://maps.google.com/?q=${position.latitude},${position.longitude}",
//   );

//   print("Emergency SMS Sent!");
// }


class LocationService {
  Future<Position?> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if GPS is enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) return null;

    // Check permissions
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.deniedForever) return null;
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }
}

