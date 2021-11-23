import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('User Register')),
      body: Center(
        child: ElevatedButton(
            child: const Text('Register'),
            onPressed: () {
              Get.offNamed('/login');
            }),
      ),
    );
  }
}
