import 'dart:async';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:groove_guru_app/src/screens/controllers/register_controller.dart';

void main() => runApp(Register());

// ignore: use_key_in_widget_constructors
class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFF0B759D);
    final controller = Get.put(RegisterController());
    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: null,
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("images/tela-inicial.png"), 
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
            key: _formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                // Conteiner-Pai 1
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 4,
                      color: buttonColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Realize seu cadastro',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Nome',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: controller.email,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Seu email',
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Conteiner-Pai 2
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 10),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(
                      width: 4,
                      color: buttonColor,
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Senha',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10),
                        child: TextField(
                          controller: controller.passowrd,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Sua senha',
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: buttonColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(bottom: 10),
                        // box
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                RegisterController.instance.registerUser(
                                    controller.email.text.trim(),
                                    controller.passowrd.text.trim());
                              }
                            },
                            style: ButtonStyle(
                              backgroundColor:
                                  MaterialStateProperty.all(buttonColor),
                            ),
                            child: const Text('salvar', style: TextStyle(color: Colors.white)),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
