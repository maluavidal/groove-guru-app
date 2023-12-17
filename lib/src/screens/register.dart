import 'package:flutter/material.dart';

void main() => runApp(Register());

// ignore: use_key_in_widget_constructors
class Register extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = const Color(0xFF0B759D);

    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Groove Guru'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("_606ef8e1-e655-4c35-8965-7ff8cbd6e772 1.png"), 
              fit: BoxFit.cover,
            ),
          ),
          child: Center(
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
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Seu usuário',
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
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(buttonColor),
                            ),
                            child: const Text('salvar'),
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