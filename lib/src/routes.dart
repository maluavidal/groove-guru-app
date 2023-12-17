import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const Home(),
    login: (context) => const Login(),
    register: (context) => Register(),
  };
}