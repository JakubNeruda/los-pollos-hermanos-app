import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';
import 'package:los_pollos_hermanos/util/utils.dart';

class AddAddressDialog extends StatefulWidget {
  final usersStream = GetIt.instance.get<GenericService<RegisteredUser>>();
  final RegisteredUser user;
  AddAddressDialog({super.key, required this.user});

  @override
  State<AddAddressDialog> createState() => _AddAddressDialogState();
}

class _AddAddressDialogState extends State<AddAddressDialog> {
  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Add Address'),
      content: TextFormField(
        controller: _addressController,
        validator: (value) =>
            Utils.isNullOrEmpty(_addressController.text.trim())
                ? "Address cannot be empty"
                : null,
        decoration: const InputDecoration(
          hintText: 'Enter your address',
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: const Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        TextButton(
          child: const Text('Add'),
          onPressed: () {
            widget.user.addresses.add(_addressController.text.trim());
            widget.usersStream.update(widget.user.id, widget.user);
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }
}
