import 'package:flutter/material.dart';
import 'package:flutter_app_bsalon/domain/controller/authentication_controller.dart';
import 'package:get/get.dart';
import 'firebase_signup.dart';

class FirebaseLogIn extends StatefulWidget {
  const FirebaseLogIn({Key? key}) : super(key: key);

  @override
  _FirebaseLogInState createState() => _FirebaseLogInState();
}

class _FirebaseLogInState extends State<FirebaseLogIn> {
  final _formKey = GlobalKey<FormState>();
  final controllerEmail = TextEditingController();
  final controllerPassword = TextEditingController();
  AuthenticationController authenticationController = Get.find();

  _login(theEmail, thePassword) async {
    print('_login $theEmail $thePassword');
    try {
      await authenticationController.login(theEmail, thePassword);
    } catch (err) {
      Get.snackbar(
        "Login",
        err.toString(),
        icon: const Icon(Icons.person, color: Colors.red),
        snackPosition: SnackPosition.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Form(
            key: _formKey,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: SizedBox(
                      width: 100,
                      height: 80,
                      child: Image.asset('asset/images/logo1.png')),
                ),
              ),
              const Text(
                "Beauty Salon",
                style: TextStyle(fontSize: 10),
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: controllerEmail,
                decoration: const InputDecoration(labelText: "Email address"),
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter email";
                  } else if (!value.contains('@')) {
                    return "Enter valid email address";
                  }
                },
              ),
              const SizedBox(
                height: 20,
              ),
              TextFormField(
                controller: controllerPassword,
                decoration: const InputDecoration(labelText: "Password"),
                keyboardType: TextInputType.number,
                obscureText: true,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter password";
                  } else if (value.length < 6) {
                    return "Password should have at least 6 characters";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                  onPressed: () async {
                    // this line dismiss the keyboard by taking away the focus of the TextFormField and giving it to an unused
                    FocusScope.of(context).requestFocus(FocusNode());
                    final form = _formKey.currentState;
                    form!.save();
                    if (_formKey.currentState!.validate()) {
                      await _login(
                          controllerEmail.text, controllerPassword.text);
                    }
                  },
                  child: const Text("Submit")),
            ]),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const FirebaseSignUp()));
              },
              child: const Text("Create account"))
        ],
      ),
    );
  }
}
