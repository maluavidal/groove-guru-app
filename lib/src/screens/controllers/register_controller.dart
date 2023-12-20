import 'package:flutter/widgets.dart';
import 'package:groove_guru_app/src/screens/repository/authenticantion_repository.dart';

class RegisterController extends GetxController {
  static RegisterController get instance => Get.find();

  final email = TextEditingController();
  final passowrd = TextEditingController();

  void registerUser(String email, String passowrd) {
    AuthenticationRepository.instance
        .createUserWithEmailAndPassword(email, password);
  }
}
