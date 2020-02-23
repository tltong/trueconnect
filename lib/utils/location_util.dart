import 'package:geolocator/geolocator.dart';

class LocationUtil {


  final Geolocator geolocator = Geolocator()..forceAndroidLocationManager;

  String country;
  String city;

getLocation() async {
  await geolocator
  .getCurrentPosition(desiredAccuracy: LocationAccuracy.best)
        .then((Position position) async {
     
      List<Placemark> p = await geolocator.placemarkFromCoordinates(
          position.latitude, position.longitude);
      Placemark place = p[0];
      country=place.country;
      city=place.locality;
    });
}

}