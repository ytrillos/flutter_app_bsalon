import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/domain/use_cases/auth_management.dart';
import 'package:flutter_app_bsalon/domain/use_cases/controllers/authentication.dart';
import 'package:flutter_app_bsalon/domain/use_cases/controllers/connectivity.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback onViewSwitch;

  const LoginScreen({Key? key, required this.onViewSwitch}) : super(key: key);

  @override
  _State createState() => _State();
}

class _State extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final controller = Get.find<AuthController>();
  final connectivityController = Get.find<ConnectivityController>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Center(
              child: SizedBox(
                  width: 100,
                  height: 80,
                  child: Image.asset('asset/images/logo1.png')),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "Iniciar sesión",
              style: Theme.of(context).textTheme.headline1,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signInEmail"),
              controller: emailController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Correo electrónico',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              key: const Key("signInPassword"),
              controller: passwordController,
              obscureText: true,
              obscuringCharacter: "*",
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Clave',
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ElevatedButton(
                    child: const Text("Login"),
                    onPressed: () async {
                      // ACTIVIDAD
                      // LUEGO DE VALIDAR EL ESTADO DE RED:
                      if (connectivityController.connected) {
                        // PERMITA LA AUTENTICACIÓN A LA APP SI SE DETECTA CONEXIÓN
                        var result = await AuthManagement.signIn(
                            email: emailController.text,
                            password: passwordController.text);
                        controller.authenticated = result;
                      } else {
                        // MUESTRE UN SNACKBAR (notificación) INDICANDO QUE NO EXISTE CONEXIÓN
                        Get.showSnackbar(GetBar(
                          message: "No estas conectado",
                          duration: const Duration(seconds: 2),
                        ));
                      }
                    },
                  ),
                ),
              )
            ],
          ),
          TextButton(
            key: const Key("toSignUpButton"),
            child: const Text("Registrarse"),
            onPressed: widget.onViewSwitch,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}