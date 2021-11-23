import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/home.dart';
import 'package:flutter_app_bsalon/login.dart';
import 'package:flutter_app_bsalon/logout.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    title: 'Beauty Salon - MinTic',
    theme: ThemeData(primaryColor: Colors.green),
    initialRoute: '/login',
    getPages: [
      GetPage(name: '/login', page: () => const Login()),
      GetPage(name: '/signup', page: () => const Login()),
      GetPage(name: '/logout', page: () => const Logout()),
      GetPage(
          name: '/home', page: () => const Home(), transition: Transition.zoom),
    ],
  ));
}
