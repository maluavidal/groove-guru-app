import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../routes.dart';

void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({Key? key});

  @override
  Widget build(BuildContext context) {
    TextEditingController usernameController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    String? emailError;
    String? passwordError;

    Future<void> signIn(
        String username, String password, BuildContext context) async {
      if (username.isEmpty || password.isEmpty) {
        emailError = 'Por favor, preencha todos os campos';
        passwordError = 'Por favor, preencha todos os campos';
        return;
      }

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: username,
          password: password,
        );
        print("User: ${userCredential.user}");
        if (userCredential.user != null) {
          String? userName = await getCurrentUserName(userCredential.user!.uid);
          Navigator.pushReplacementNamed(context, Routes.home,
              arguments: {'userName': userName}); // Avançar para a página Home
        } else {
          emailError = 'Email ou senha incorretos';
          passwordError = 'Email ou senha incorretos';
        }
      } on FirebaseAuthException catch (e) {
        print("Error: $e");
        if (e.code == 'user-not-found' || e.code == 'wrong-password') {
          emailError = 'Email ou senha incorretos';
          passwordError = 'Email ou senha incorretos';
        }
      } catch (e) {
        print("Error: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao realizar login: $e'),
          ),
        );
      }
    }

    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        appBar: null,
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/tela-inicial.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    // Container-Pai 1 (Login)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xFF0B759D), width: 4),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 20, 15, 15),
                            child: const Text(
                              'Login',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Color(0xFF0B759D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15, bottom: 5),
                            child: const Text(
                              'Email',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Color(0xFF0B759D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: usernameController,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF0B759D),
                                    width: 2.0,
                                  ),
                                ),
                                hintText: 'Digite seu email',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF0B759D),
                                  fontWeight: FontWeight.bold,
                                ),
                                errorText: emailError,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Colors.black, // Alterado para preto
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            alignment: Alignment.centerLeft,
                            padding: const EdgeInsets.only(
                                left: 15, top: 10, right: 15, bottom: 5),
                            child: const Text(
                              'Senha',
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Poppins',
                                color: Color(0xFF0B759D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: TextFormField(
                              controller: passwordController,
                              obscureText: true,
                              decoration: InputDecoration(
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color(0xFF0B759D),
                                    width: 2.0,
                                  ),
                                ),
                                hintText: 'Digite sua senha',
                                hintStyle: TextStyle(
                                  fontFamily: 'Poppins',
                                  color: Color(0xFF0B759D),
                                  fontWeight: FontWeight.bold,
                                ),
                                errorText: passwordError,
                              ),
                              style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'Poppins',
                                color: Colors.black, // Alterado para preto
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: ElevatedButton(
                                onPressed: () {
                                  signIn(
                                      usernameController.text,
                                      passwordController.text,
                                      context); // Chama a função signIn se ambos os campos estiverem preenchidos
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0B759D),
                                ),
                                child: const Text(
                                  'Entrar',
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Container-Pai 2 (Registro)
                    Container(
                      margin: const EdgeInsets.symmetric(vertical: 20),
                      width: 300,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.8),
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            color: const Color(0xFF0B759D), width: 4),
                      ),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.fromLTRB(15, 15, 15, 20),
                            child: const Text(
                              'Ainda não possui conta?',
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Poppins',
                                color: Color(0xFF0B759D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Center(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              child: ElevatedButton(
                                onPressed: () {
                                  Navigator.pushReplacementNamed(
                                      context,
                                      Routes
                                          .register); // Avança para a página de registro
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF0B759D),
                                ),
                                child: const Text(
                                  'Cadastre-se',
                                  style: TextStyle(color: Colors.white),
                                ),
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
          ],
        ),
      ),
    );
  }

  Future<String?> getCurrentUserName(String uid) async {
    // Função para obter o nome de usuário atual do Firestore
    DocumentSnapshot snapshot =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();
    return snapshot['userName'];
  }
}
