import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Forgot extends StatelessWidget {
  const Forgot({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Forgot Password')),
      body: Center(
        child: ElevatedButton(
            child: const Text('Forgot Password'),
            onPressed: () {
              Get.offNamed('/login');
            }),
      ),
    );
  }
}
