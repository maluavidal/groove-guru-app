import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:groove_guru_app/firebase_options.dart';
import 'package:groove_guru_app/src/screens/repository/authenticantion_repository.dart';
import 'src/routes.dart';
import 'package:get/get.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform)
      .then((value) => Get.put(AuthenticationRepository()));
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groove Guru',
      routes: Routes.routes,
      initialRoute: Routes.login, // Defina a rota inicial como login
    );
  }
}
