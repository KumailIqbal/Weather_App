// ignore: import_of_legacy_library_into_null_safe
import 'package:geolocator/geolocator.dart';

class Location {
  late double latitude;
  late double longitude;
  Future<void> getCurrentLocation() async {
    try {
      Position position = await Geolocator.getCurrentPosition(
          forceAndroidLocationManager: false,
          desiredAccuracy: LocationAccuracy.low);
      latitude = position.latitude;
      longitude = position.longitude;
    } catch (e) {
      // ignore: avoid_print
      print(e);
      latitude = 0.0;
      longitude = 0.0;
    }
  }
}
