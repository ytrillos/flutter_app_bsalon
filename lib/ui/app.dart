import 'dart:developer';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_app_bsalon/domain/use_cases/controllers/authentication.dart';
import 'package:flutter_app_bsalon/domain/use_cases/controllers/connectivity.dart';
import 'package:flutter_app_bsalon/domain/use_cases/controllers/ui.dart';
import 'package:flutter_app_bsalon/ui/pages/authentication/auth_page.dart';
import 'package:flutter_app_bsalon/ui/pages/content/content_page.dart';
import 'package:flutter_app_bsalon/ui/theme/theme.dart';

class App extends StatelessWidget {
  const App({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    _stateManagementInit();
    return GetMaterialApp(
      title: 'Beauty salon',
      // Quitamos el banner DEBUG
      debugShowCheckedModeBanner: false,
      // Establecemos el tema claro
      theme: MyTheme.ligthTheme,
      // Establecemos el tema oscuro
      darkTheme: MyTheme.darkTheme,
      // Por defecto tomara la seleccion del sistema
      themeMode: ThemeMode.system,
      home: const AuthenticationPage(),
      // We add the two possible routes
      routes: {
        '/auth': (context) => const AuthenticationPage(),
        '/content': (context) => const ContentPage(),
      },
    );
  }

  void _stateManagementInit() {
    // Dependency Injection
    Get.put(UIController());
    AuthController authController = Get.put(AuthController());
    ConnectivityController connectivityController =
        Get.put(ConnectivityController());
    // Watching auth state changes
    // State management: listening for changes on using the reactive var
    ever(authController.reactiveAuth, (bool authenticated) {
      // Using Get.off so we can't go back when auth changes
      // This navigation triggers automatically when auth state changes on the app state
      if (authenticated) {
        Get.offNamed('/content');
      } else {
        Get.offNamed('/auth');
      }
    });
    // Connectivity stream

    // ACTIVIDAD
    // IMPLEMENTE LA ESCUCHA PARA EL STRING DE CONECTIVIDAD
    Connectivity().onConnectivityChanged.listen((connectivityStatus) {
      log("Cambios en la conectividad");
      connectivityController.connectivity = connectivityStatus;
    });
  }
}
