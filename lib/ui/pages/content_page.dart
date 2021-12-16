import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/domain/controller/authentication_controller.dart';
import 'package:flutter_app_bsalon/domain/controller/theme_controller.dart';
import 'package:flutter_app_bsalon/ui/theme/colors.dart';
import 'package:flutter_app_bsalon/ui/widgets/appbar.dart';
import 'package:flutter_app_bsalon/ui/widgets/location_page.dart';
import 'package:flutter_app_bsalon/ui/widgets/product_page.dart';
import 'package:get/get.dart';

import '../widgets/chat_page.dart';
import '../widgets/firestore_page.dart';

class ContentPage extends StatefulWidget {
  const ContentPage({Key? key}) : super(key: key);

  @override
  _ContentPageState createState() => _ContentPageState();
}

class _ContentPageState extends State<ContentPage> {
  int _selectIndex = 0;
  AuthenticationController authenticationController = Get.find();
  static final List<Widget> _widgets = <Widget>[
    const FireStorePage(),
    const ChatPage(),
    const LocationPage(),
    const ProductPage()
  ];

  _onItemTapped(int index) {
    setState(() {
      _selectIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final ThemeController themeController = Get.find<ThemeController>();
    return Scaffold(
      appBar: CustomAppBar(
        controller: themeController,
        authController: authenticationController,
        context: context,
        tile: Text(authenticationController.userEmail()),
      ),
      body: _widgets.elementAt(_selectIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Firestore"),
          BottomNavigationBarItem(
              icon: Icon(Icons.chat_bubble_outline), label: "Chat"),
          BottomNavigationBarItem(
              icon: Icon(Icons.place_outlined), label: 'Ubicación'),
          BottomNavigationBarItem(
              icon: Icon(Icons.public_outlined), label: 'Productos'),
        ],
        currentIndex: _selectIndex,
        selectedItemColor: AppColors.primaryColor,
        unselectedItemColor: AppColors.accentColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
