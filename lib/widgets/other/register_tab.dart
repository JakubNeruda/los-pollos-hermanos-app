import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/coupon.dart';
import 'package:los_pollos_hermanos/models/food_order.dart';

import '../../models/registered_user.dart';
import '../../services/generic_service.dart';
import '../../util/utils.dart';

class RegisterTab extends StatefulWidget {
  final userService = GetIt.instance.get<GenericService<RegisteredUser>>();
  final couponService = GetIt.instance.get<GenericService<Coupon>>();
  RegisterTab({super.key});

  @override
  _RegisterTabState createState() => _RegisterTabState();
}

class _RegisterTabState extends State<RegisterTab> {
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    TextEditingController registerNameController = TextEditingController();
    TextEditingController registerSurnameController = TextEditingController();
    TextEditingController registerEmailController = TextEditingController();
    TextEditingController registerPhoneController = TextEditingController();
    TextEditingController registerPasswordController = TextEditingController();
    TextEditingController registerPasswordRepeatController =
        TextEditingController();

    return Form(
      key: _formKey,
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: const InputDecoration(labelText: "First name"),
                  controller: registerNameController,
                  validator: (value) {
                    return Utils.isNullOrEmpty(value)
                        ? "Please enter your name"
                        : null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: const InputDecoration(labelText: "Surname"),
                  controller: registerSurnameController,
                  validator: (value) {
                    return Utils.isNullOrEmpty(value)
                        ? "Please enter your surname"
                        : null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: const InputDecoration(labelText: "Email"),
                  controller: registerEmailController,
                  validator: (value) {
                    return Utils.isNullOrEmpty(value)
                        ? "Please enter email address"
                        : null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  decoration: const InputDecoration(labelText: "Phone number"),
                  controller: registerPhoneController,
                  validator: (value) {
                    return Utils.isNullOrEmpty(value)
                        ? "Please enter phone number"
                        : null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                  obscureText: true,
                  decoration: const InputDecoration(labelText: "Password"),
                  controller: registerPasswordController,
                  validator: (value) {
                    return Utils.isNullOrEmpty(value)
                        ? "Please enter password"
                        : null;
                  }),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                obscureText: true,
                decoration: const InputDecoration(labelText: "Repeat password"),
                controller: registerPasswordRepeatController,
                validator: (value) {
                  if (!Utils.isNullOrEmpty(value)) {
                    return registerPasswordController.text.trim() ==
                            registerPasswordRepeatController.text.trim()
                        ? null
                        : "Passwords do not match";
                  }
                  return "Please enter repeated password";
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ElevatedButton(
                child: const Text("Register"),
                onPressed: () async {
                  if (!_formKey.currentState!.validate()) return;
                  _formKey.currentState!.save();
                  if (await tryRegister(
                    registerNameController.text.trim(),
                    registerSurnameController.text.trim(),
                    registerEmailController.text.trim(),
                    registerPhoneController.text.trim(),
                    registerPasswordController.text.trim(),
                    widget.userService,
                  )) {
                    Navigator.popUntil(context, (route) => route.isFirst);
                  } else {
                    // TODO on register fail
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<bool> tryRegister(String firstName, String surname, String email,
      String phoneNumber, String password, GenericService userService) async {
    try {
      UserCredential credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      var snapshot = await widget.couponService.collection
          .where('expiration', isGreaterThan: DateTime.timestamp())
          .get();
      var coupons = snapshot.docs.map((e) => e.data().id!).toList();

      if (credential.user != null) {
        RegisteredUser user = RegisteredUser(
            firstName: firstName,
            surname: surname,
            email: email,
            phoneNumber: phoneNumber,
            addresses: List.empty(),
            coupons: coupons,
            orders: List.empty(),
            openOrder: FoodOrder.getEmptyOrder(null));
        userService.add(user, credential.user!.uid);

        return true;
      } else {
        return false;
      }
    } catch (e) {
      Utils.showErrorDialog(context, e.toString());
      return false;
    }
  }
}
