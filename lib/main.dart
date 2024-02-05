import 'package:flutter/material.dart';
import 'package:los_pollos_hermanos/app_wrapper.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:los_pollos_hermanos/firebase_options.dart';
import 'package:los_pollos_hermanos/services/ioc_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  IoCContainer.setup();

  runApp(const AppWrapper());
}
