import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/services/generic_service.dart';

class AddressItem extends StatelessWidget {
  final usersStream = GetIt.instance.get<GenericService<RegisteredUser>>();
  final String address;
  final int index;
  final RegisteredUser user;
  AddressItem(
      {super.key,
      required this.address,
      required this.index,
      required this.user});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Row(
        children: [
          Text(address),
          const Spacer(),
          IconButton(
              onPressed: () {
                user.addresses.removeAt(index);
                usersStream.update(user.id, user);
              },
              icon: const Icon(Icons.delete))
        ],
      ),
    );
  }
}
