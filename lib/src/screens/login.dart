import 'package:flutter/material.dart';
import '../routes.dart';


void main() => runApp(const Login());

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
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
                      border: Border.all(color: const Color(0xFF0B759D), width: 4),
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
                          padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
                          child: const Text(
                            'Nome',
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
                          child: const TextField(
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0B759D),
                                  width: 2.0,
                                ),
                              ),
                              labelText: '. . . . . . ',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF0B759D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
                              fontFamily: 'Poppins',
                              color: Color(0xFF0B759D),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          padding: const EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
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
                          child: const TextField(
                            obscureText: true,
                            decoration: InputDecoration(
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(
                                  color: Color(0xFF0B759D),
                                  width: 2.0,
                                ),
                              ),
                              labelText: '. . . . . . .',
                              labelStyle: TextStyle(
                                fontFamily: 'Poppins',
                                color: Color(0xFF0B759D),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextStyle(
                              fontSize: 14,
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
                                Navigator.pushNamed(context, Routes.home);
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF0B759D),
                              ),
                              child: const Text('entrar',
                              style: TextStyle(color: Colors.white),),
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
                      border: Border.all(color: const Color(0xFF0B759D), width: 4),
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
                        Container(
                          padding: const EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: () {
                              Navigator.pushNamed(context, Routes.register);
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF0B759D),
                            ),
                            child: const Text('cadastrar',
                            style: TextStyle(color: Colors.white),),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
