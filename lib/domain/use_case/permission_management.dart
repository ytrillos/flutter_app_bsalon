import 'package:permission_handler/permission_handler.dart';

class PermissionManager {
  Future<bool> gpsPermission() async {
    // TODO retorna el estado del permiso de ubicacion
    var status = await Permission.location.status;
    return status.isGranted;
  }

  Future<bool> requestGpsPermission() async {
    // TODO Solicita los permisos necesarios
    var status = await Permission.location.request();
    return status.isGranted;
  }
}
