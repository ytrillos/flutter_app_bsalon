import 'package:flutter_app_bsalon/data/services/geolocation.dart';
import 'package:geolocator/geolocator.dart';

class LocationManager {
  final gpsService = GpsService();

  Future<Position> getCurrentLocation() async {
    // TODO Retorna la ubicacion actual
    return await gpsService.getCurrentLocation();
  }
}
