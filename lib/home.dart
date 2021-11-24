import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:math';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  _StateHome createState() => _StateHome();
}

class _StateHome extends State<Home> {
  final numbers = List<int>.generate(4, (i) => i + 1);

  List<String> titles = [
    "Brian Armstrong",
    "Justin Allen",
    "Daniel Miller",
    "Maurice Evans",
    "Denise Horn"
  ];
  final subtitles = [
    "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Sed vitae tincidunt nulla, nec porta massa. Sed viverra non orci ac.",
    "Donec ultricies laoreet ligula et volutpat. Etiam pellentesque libero lorem, nec efficitur magna maximus a.",
    "Aliquam iaculis est in nulla placerat ultrices. Etiam ligula orci, fermentum eget dapibus vel, aliquam quis dui."
  ];
  final icons = [Icons.ac_unit, Icons.access_alarm, Icons.access_time];

  @override
  Widget build(BuildContext context) {
    bool lTheme = true;
    return Scaffold(
      //backgroundColor: const Color(0xFFFEFEFA),
      appBar: AppBar(
        title: const Text("Publicaciones Públicas"),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.admin_panel_settings_outlined),
            tooltip: 'Publicaciones Privadas',
            onPressed: () {
              Get.toNamed('/homeprivate');
              /*
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('This is a snackbar')));
              */
            },
          ),
          IconButton(
            icon: const Icon(Icons.palette_outlined),
            tooltip: 'Theme',
            onPressed: () {
              if (lTheme) {
                Get.changeTheme(ThemeData.dark());
                lTheme = false;
              } else {
                Get.changeTheme(ThemeData(primarySwatch: Colors.red));
                lTheme = true;
              }
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Logout',
            onPressed: () {
              Get.offNamed('/login');
            },
          )
        ],
      ),
      body: bodyContent(),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        //backgroundColor: Colors.blueAccent,
        //foregroundColor: Colors.white70,
        onPressed: () {
          setState(() {
            numbers.insert(numbers.length, numbers.length + 1);
          });
        },
      ),
    );
  }

  bodyContent() {
    Random random = Random();
    return ListView.builder(
        itemCount: numbers.length,
        itemBuilder: (context, index) {
          return Card(
              //color: const Color(0xFFE6E6FA),
              child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  title: Text(titles[random.nextInt(4)] + " ${numbers[index]}"),
                  subtitle: Text(subtitles[random.nextInt(2)]),
                  leading: CircleAvatar(
                      backgroundImage: const NetworkImage(
                          "https://images.unsplash.com/photo-1547721064-da6cfb341d50")),
                  trailing: Icon(icons[random.nextInt(2)])));
        });
  }
}
