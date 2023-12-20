import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groove_guru_app/firebase_options.dart';
import 'src/routes.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groove Guru',
      routes: Routes.routes,
    );
  }
}
