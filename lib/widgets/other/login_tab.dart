import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../util/utils.dart';

class LoginTab extends StatefulWidget {
  const LoginTab({super.key});

  @override
  _LoginTabState createState() => _LoginTabState();
}

class _LoginTabState extends State<LoginTab> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController loginEmailController = TextEditingController();
    TextEditingController loginPasswordController = TextEditingController();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(labelText: "Email"),
                controller: loginEmailController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: "Password"),
                controller: loginPasswordController,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text("Login"),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();
                  if (await tryLogin(loginEmailController.text.trim(),
                      loginPasswordController.text.trim())) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> tryLogin(String email, String password) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      return true;
    } catch (e) {
      Utils.showErrorDialog(context, "Email or password incorrect!");
      return false;
    }
  }
}
