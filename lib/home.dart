import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[const Text('Hola')],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addText(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }

  addText() {}
}
