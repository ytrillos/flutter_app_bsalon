import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Logout extends StatelessWidget {
  const Logout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Sesión Cerrada')),
      body: Center(
        child: ElevatedButton(
            child: const Text('Login'),
            onPressed: () {
              Get.offNamed('/login');
            }),
      ),
    );
  }
}
