import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/forgot.dart';
import 'package:flutter_app_bsalon/home.dart';
import 'package:flutter_app_bsalon/homeprivate.dart';
import 'package:flutter_app_bsalon/login.dart';
import 'package:flutter_app_bsalon/logout.dart';
import 'package:flutter_app_bsalon/register.dart';
import 'package:get/get.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'Beauty Salon - MinTic',
    theme: ThemeData(primarySwatch: Colors.red),
    initialRoute: '/login',
    getPages: [
      GetPage(
          name: '/login',
          page: () => const Login(),
          transition: Transition.zoom),
      GetPage(
          name: '/register',
          page: () => const Register(),
          transition: Transition.zoom),
      GetPage(
          name: '/logout',
          page: () => const Logout(),
          transition: Transition.zoom),
      GetPage(
          name: '/forgot',
          page: () => const Forgot(),
          transition: Transition.zoom),
      GetPage(
          name: '/home', page: () => const Home(), transition: Transition.zoom),
      GetPage(
          name: '/homeprivate',
          page: () => const Homeprivate(),
          transition: Transition.zoom),
    ],
  ));
}
