import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/domain/controller/location.dart';
import 'package:flutter_app_bsalon/domain/controller/permissions.dart';
import 'package:flutter_app_bsalon/domain/use_case/location_management.dart';
import 'package:flutter_app_bsalon/ui/widgets/location/location_card.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class LocationPage extends StatefulWidget {
  // UsersOffers empty constructor
  const LocationPage({Key? key}) : super(key: key);

  @override
  _State createState() => _State();
}

enum RadioState { on, off }

class _State extends State<LocationPage> {
  late PermissionsController permissionsController;
  late LocationController locationController;
  late LocationManager manager;

  var latitud = 0.0;
  var longitud = 0.0;
  var _isLoading = false;

  @override
  initState() {
    super.initState();
    permissionsController = Get.find();
    locationController = Get.find();
    manager = LocationManager();
    locationController.location.value = null;
    localizacion();
  }

  final items = List<String>.generate(3, (i) => "Item $i");

  Future localizacion() async {
    _isLoading = true;
    if (permissionsController.locationGranted) {
      final position = await manager.getCurrentLocation();
      locationController.location.value = position;
      latitud = position.latitude;
      longitud = position.longitude;
      //Get.snackbar('Tu ubicación es:', 'Latitud: $latitud Longitud: $longitud');
    }
    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisSize: MainAxisSize.min,
      children: [
        LocationCard(
            key: const Key("myLocationCard"),
            title: 'MI UBICACIÓN',
            lat: latitud,
            long: longitud,
            onUpdate: () {
              if (locationController.location.value != null) {
                final location = locationController.location.value;
                final url =
                    "https://www.google.es/maps?q${location?.latitude},${location?.longitude}";
                launch(url);
              }
            }),
        /*
          Padding(
            padding: null,
            child: const Center(child: CircularProgressIndicator())
          ),
          */
      ],
    ));
  }
}
