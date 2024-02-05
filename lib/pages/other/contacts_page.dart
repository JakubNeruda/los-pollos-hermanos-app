import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';

import '../../services/generic_service.dart';
import '../../services/logged_user_service.dart';
import '../../util/utils.dart';

class ContactsPage extends StatefulWidget {
  final userService = GetIt.instance.get<GenericService<RegisteredUser>>();
  final userChangeStream = GetIt.instance.get<LoggedUserService>();
  final _formKey = GlobalKey<FormState>();
  final bool isEditingMode;
  ContactsPage({super.key, required this.isEditingMode});

  @override
  State<ContactsPage> createState() => _ContactsPageState();
}

class _ContactsPageState extends State<ContactsPage> {
  TextEditingController registerNameController = TextEditingController();
  TextEditingController registerSurnameController = TextEditingController();
  TextEditingController registerEmailController = TextEditingController();
  TextEditingController registerPhoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return _conditionalStreamWrappedBody();
  }

  Widget buildEditingButton(RegisteredUser currentUser) {
    return widget.isEditingMode
        ? IconButton(
            onPressed: () {
              try {
                if (!widget._formKey.currentState!.validate()) return;
                widget.userService
                    .update(currentUser.id, _getUpdatedUser(currentUser));
                FirebaseAuth.instance.currentUser!
                    .updateEmail(registerEmailController.text.trim());
                Navigator.pop(context);
              } catch (e) {
                Utils.showErrorDialog(context, e.toString());
              }
            },
            icon: const Icon(Icons.check))
        : IconButton(
            onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ContactsPage(isEditingMode: true)),
                ),
            icon: const Icon(Icons.edit));
  }

  Widget _conditionalStreamWrappedBody() {
    return widget.isEditingMode
        ? _buildBody()
        : StreamBuilder<RegisteredUser?>(
            stream: widget.userChangeStream.currentUserChanges,
            builder: (context, snapshot) {
              return _buildBody();
            });
  }

  Widget _buildBody() {
    var currentUser = widget.userChangeStream.currentUser!;
    registerNameController.text = currentUser.firstName;
    registerSurnameController.text = currentUser.surname;
    registerEmailController.text = currentUser.email;
    registerPhoneController.text = currentUser.phoneNumber;

    return Scaffold(
      appBar: AppBar(actions: [buildEditingButton(currentUser)]),
      body: Form(
        key: widget._formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                    enabled: widget.isEditingMode,
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
                    enabled: widget.isEditingMode,
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
                    enabled: widget.isEditingMode,
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
                    enabled: widget.isEditingMode,
                    decoration:
                        const InputDecoration(labelText: "Phone number"),
                    controller: registerPhoneController,
                    validator: (value) {
                      return Utils.isNullOrEmpty(value)
                          ? "Please enter phone number"
                          : null;
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }

  RegisteredUser _getUpdatedUser(RegisteredUser currentUser) {
    return RegisteredUser(
      firstName: registerNameController.text.trim(),
      surname: registerSurnameController.text.trim(),
      email: registerEmailController.text.trim(),
      phoneNumber: registerPhoneController.text.trim(),
      addresses: currentUser.addresses,
      coupons: currentUser.coupons,
      orders: currentUser.orders,
      openOrder: currentUser.openOrder,
    );
  }
}
