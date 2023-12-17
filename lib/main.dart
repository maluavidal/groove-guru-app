import 'package:flutter/material.dart';
import 'src/routes.dart';

void main() {
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
