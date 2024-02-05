import 'package:flutter/material.dart';
import 'package:los_pollos_hermanos/widgets/other/login_tab.dart';
import 'package:los_pollos_hermanos/widgets/other/register_tab.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          bottom: const TabBar(
            tabs: [Text("Login"), Text("Register")],
          ),
        ),
        body: TabBarView(
          children: [
            LoginTab(),
            RegisterTab(),
          ],
        ),
      ),
    );
  }
}
