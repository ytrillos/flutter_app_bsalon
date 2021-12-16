import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/domain/controller/authentication_controller.dart';
import 'package:flutter_app_bsalon/domain/controller/chat_controller.dart';
import 'package:flutter_app_bsalon/domain/controller/connectivity.dart';
import 'package:flutter_app_bsalon/domain/controller/firestore_controller.dart';
import 'package:flutter_app_bsalon/domain/controller/location.dart';
import 'package:flutter_app_bsalon/domain/controller/permissions.dart';
import 'package:flutter_app_bsalon/domain/controller/theme_controller.dart';
import 'package:flutter_app_bsalon/domain/use_case/permission_management.dart';
import 'package:flutter_app_bsalon/domain/use_case/theme_management.dart';
import 'package:flutter_app_bsalon/ui/theme/theme.dart';
import 'package:get/get.dart';
import 'firebase_central.dart';

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<MyApp> {
  // Dependency injection: setting up state management
  late final ThemeController controller;
  // Theme management
  late final ThemeManager manager;
  bool isLoaded = false;

  Future<void> initializeTheme() async {
    controller.darkMode = await manager.storedTheme;
    setState(() => isLoaded = true);
  }

  @override
  void initState() {
    // final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    // Dependency injection: setting up state management
    ConnectivityController connectivityController =
        Get.put(ConnectivityController());

    controller = Get.put(ThemeController());
    // Theme management
    manager = ThemeManager();
    ever(controller.reactiveDarkMode, (bool isDarkMode) {
      manager.changeTheme(isDarkMode: isDarkMode);
    });

    Connectivity().onConnectivityChanged.listen((connectivityStatus) {
      connectivityController.connectivity = connectivityStatus;
    });

    PermissionsController permissionsController =
        Get.put(PermissionsController());
    permissionsController.permissionManager = PermissionManager();
    Get.lazyPut(() => LocationController());

    initializeTheme();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Future<FirebaseApp> _initialization = Firebase.initializeApp();
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Beauty Salon',
      theme: MyTheme.ligthTheme,
      darkTheme: MyTheme.darkTheme,
      themeMode: ThemeMode.system,
      home: Scaffold(
          body: FutureBuilder(
        future: _initialization,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            print("error ${snapshot.error}");
            return const Wrong();
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Get.put(FirebaseController());
            Get.put(AuthenticationController());
            Get.put(ChatController());
            return const FirebaseCentral();
          }

          return const Loading();
        },
      )),
    );
  }
}

class Wrong extends StatelessWidget {
  const Wrong({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Something went wrong"));
  }
}

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text("Loading"));
  }
}
