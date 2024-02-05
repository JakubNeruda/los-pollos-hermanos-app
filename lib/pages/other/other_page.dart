import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:los_pollos_hermanos/models/registered_user.dart';
import 'package:los_pollos_hermanos/pages/other/addresses_page.dart';
import 'package:los_pollos_hermanos/pages/other/contacts_page.dart';
import 'package:los_pollos_hermanos/pages/other/order_history_page.dart';
import 'package:los_pollos_hermanos/pages/other/terms_conditions_page.dart';
import 'package:los_pollos_hermanos/services/logged_user_service.dart';
import 'package:los_pollos_hermanos/util/utils.dart';
import 'package:los_pollos_hermanos/widgets/other/profile_item.dart';

import 'login_page.dart';

class OtherPage extends StatelessWidget {
  final userChangeStream = GetIt.instance.get<LoggedUserService>();

  OtherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: MediaQuery.of(context).viewPadding.top),
        Expanded(
          child: Card(
            shadowColor: Colors.transparent,
            margin: const EdgeInsets.all(8.0),
            child: StreamBuilder<RegisteredUser?>(
                stream: userChangeStream.currentUserChanges,
                builder: (context, snapshot) {
                  var currentUser = userChangeStream.currentUser;
                  if (currentUser != null) Utils.cleanupRoutine();
                  return Column(
                    children: [
                      const SizedBox(height: 10),
                      buildUserSignInWidget(context, currentUser),
                      const Divider(),
                      SingleChildScrollView(
                        child: Column(
                          children: [
                            ProfileItem(
                              isEnabled: currentUser != null,
                              icon: const Icon(Icons.fastfood),
                              name: "Orders overview",
                              onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => OrdersPage()),
                              ),
                            ),
                            ProfileItem(
                              isEnabled: currentUser != null,
                              icon: const Icon(Icons.contact_mail),
                              name: "Contact details",
                              onClick: () => Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          ContactsPage(isEditingMode: false))),
                            ),
                            ProfileItem(
                              isEnabled: currentUser != null,
                              icon: const Icon(Icons.map),
                              name: "Delivery address",
                              onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddressesPage()),
                              ),
                            ),
                            ProfileItem(
                              icon: const Icon(Icons.folder_special_outlined),
                              name: "Terms and conditions",
                              onClick: () => Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        TermsConditionsPage()),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }),
          ),
        ),
      ],
    );
  }

  Widget buildUserSignInWidget(
      BuildContext context, RegisteredUser? registeredUser) {
    return registeredUser == null
        ? Align(
            alignment: Alignment.centerRight,
            child: TextButton(
              onPressed: () => Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const LoginPage())),
              child: const Text(
                "Login",
                style: TextStyle(fontSize: 16),
              ),
            ),
          )
        : Row(
            children: [
              const SizedBox(
                width: 10,
              ),
              Text(
                "${registeredUser.firstName} ${registeredUser.surname}",
                style: const TextStyle(fontSize: 20),
                overflow: TextOverflow.ellipsis,
              ),
              const Spacer(),
              TextButton(
                onPressed: () => FirebaseAuth.instance.signOut(),
                child: const Text(
                  "Logout",
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ],
          );
  }
}
