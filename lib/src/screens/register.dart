import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'home.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(Register());
}

class RegisterController {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController userName = TextEditingController();

  static final RegisterController instance = RegisterController();

  Future<void> registerUser(String email, String password, String userName,
      BuildContext context) async {
    try {
      UserCredential userCredential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      await FirebaseFirestore.instance
          .collection('users')
          .doc(userCredential.user!.uid)
          .set({
        'email': email,
        'userName': userName,
      });

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => Home()),
      );
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              'O endereço de e-mail já está em uso por outra conta.',
              textAlign: TextAlign.center,
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('Erro de cadastro'),
              content: Text('Ocorreu um erro durante o cadastro: $e'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      }
      print("Erro: $e");
    } catch (e) {
      print("Erro: $e");
    }
  }
}

class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFF0B759D);
    final controller = RegisterController.instance;
    final _formKey = GlobalKey<FormState>();

    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: null,
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/tela-inicial.png'),
              fit: BoxFit.cover,
            ),
          ),
          child: Form(
            key: _formKey,
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
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
                            child: TextFormField(
                              controller: controller.userName,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Seu nome de usuário',
                                hintStyle: TextStyle(
                                  color: Color(0xFF0B759D),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu nome de usuário';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.all(10),
                            child: TextFormField(
                              controller: controller.email,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Seu email',
                                hintStyle: TextStyle(
                                  color: Color(0xFF0B759D),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira seu endereço de email';
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
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
                            child: TextFormField(
                              controller: controller.password,
                              obscureText: true,
                              decoration: InputDecoration(
                                border: UnderlineInputBorder(),
                                hintText: 'Sua senha',
                                hintStyle: TextStyle(
                                  color: Color(0xFF0B759D),
                                ),
                              ),
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.bold),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Por favor, insira sua senha';
                                }
                                if (value.length < 6) {
                                  return 'A senha deve ter pelo menos 6 caracteres';
                                }
                                return null;
                              },
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: Container(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    controller.registerUser(
                                      controller.email.text.trim(),
                                      controller.password.text.trim(),
                                      controller.userName.text.trim(),
                                      context,
                                    );
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(buttonColor),
                                  foregroundColor:
                                      MaterialStateProperty.all(Colors.white),
                                ),
                                child: const Text('Salvar'),
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
        ),
      ),
    );
  }
}
