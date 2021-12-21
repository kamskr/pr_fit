import 'package:authentication_client/authentication_client.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'app/view/app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final _authenticationClient = AuthenticationClient();
  runApp(
    App(authenticationClient: _authenticationClient),
  );
}
