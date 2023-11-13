//Tela Carol

import 'package:flutter/material.dart';

void main() => runApp(MaterialApp(home: MyApp()));

// ignore: use_key_in_widget_constructors
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Color buttonColor = Color(0xFF0B759D); // Cor usada nos outros locais

    return MaterialApp(
      title: 'Cadastro',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Groove Guru'),
        ),
        body: Container(
          decoration: BoxDecoration(
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
                  margin: EdgeInsets.symmetric(vertical: 14),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white, // Cor de fundo do contêiner
                    border: Border.all(
                      width: 4,
                      color: buttonColor, // Define a cor da borda aqui
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Realize seu cadastro',
                          style: TextStyle(
                            fontSize: 22,
                            fontFamily: 'Poppins',
                            color: buttonColor, // Usar mesma cor para o texto
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Nome',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: buttonColor, // Usar a mesma cor para o texto
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Seu usuário',
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: buttonColor, // Usar a mesma cor para o texto
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Conteiner-Pai 2
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  width: 300,
                  decoration: BoxDecoration(
                    color: Colors.white, // Cor de fundo do contêiner
                    border: Border.all(
                      width: 4,
                      color: buttonColor, // Define a cor da borda aqui
                    ),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Senha',
                          style: TextStyle(
                            fontSize: 18,
                            fontFamily: 'Poppins',
                            color: buttonColor, // Usar mesma cor para o texto
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          decoration: InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Sua senha',
                          ),
                          style: TextStyle(
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            color: buttonColor, // Usar a mesma cor para o texto
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(bottom: 10),
                        // box
                        // ignore: sized_box_for_whitespace
                        child: Container(
                          width: 200,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all(buttonColor), // Define a cor do botão
                            ),
                            child: Text('salvar'),
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