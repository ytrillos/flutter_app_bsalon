import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/domain/controller/authentication_controller.dart';
import 'package:flutter_app_bsalon/domain/controller/theme_controller.dart';
import 'package:get/get.dart';

class CustomAppBar extends AppBar {
  final Widget tile;
  final BuildContext context;
  final ThemeController controller;
  final AuthenticationController authController;

  // Creating a custom AppBar that extends from Appbar with super();
  CustomAppBar({
    Key? key,
    required this.controller,
    required this.authController,
    required this.context,
    required this.tile,
  }) : super(
          key: key,
          centerTitle: true,
          title: tile,
          actions: [
            IconButton(
              icon: Obx(
                () => Icon(
                  controller.darkMode
                      ? Icons.light_mode_rounded
                      : Icons.dark_mode_rounded,
                ),
              ),
              onPressed: () => controller.darkMode = !controller.darkMode,
            ),
            IconButton(
                icon: const Icon(Icons.exit_to_app),
                onPressed: () async {
                  try {
                    await authController.logOut();
                  } catch (e) {
                    print(e);
                  }
                }),
          ],
        );
}
