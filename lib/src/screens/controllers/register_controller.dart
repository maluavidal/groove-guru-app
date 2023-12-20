import 'package:flutter/widgets.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final email = TextEditingController();
  final passowrd = TextEditingController();

  void registerUser(String email, String passowrd) {}
}
