import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';
import 'package:los_pollos_hermanos/widgets/other/add_address_dialog.dart';
import 'package:los_pollos_hermanos/widgets/other/address_item.dart';

class AddressesPage extends StatelessWidget {
  final userChangeStream = GetIt.instance.get<LoggedUserService>();
  AddressesPage({super.key});

  @override
  Widget build(BuildContext context) {
    RegisteredUser currentUser = userChangeStream.currentUser!;

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AddAddressDialog(user: currentUser);
                  }),
              icon: const Icon(Icons.add))
        ],
        title: const Text("Addresses"),
      ),
      body: StreamBuilder(
        stream: userChangeStream.currentUserChanges,
        builder: (context, snapshot) {
          currentUser = userChangeStream.currentUser!;
          if (currentUser.addresses.isEmpty) {
            return const Center(
              child: Text(
                'No addresses.',
                style: TextStyle(fontSize: 20),
              ),
            );
          }
          return ListView.builder(
              padding: EdgeInsets.zero,
              itemCount: currentUser.addresses.length,
              itemBuilder: (context, index) => AddressItem(
                    address: currentUser.addresses[index],
                    index: index,
                    user: currentUser,
                  ));
        },
      ),
    );
  }
}
