import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Login',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Groove Guru'),
        ),
        body: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/tela-inicial.jpg'),
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
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF0B759D), width: 4),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 20, 15, 15),
                          child: Text(
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
                          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
                          child: Text(
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
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
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
                          padding: EdgeInsets.only(left: 15, top: 10, right: 15, bottom: 5),
                          child: Text(
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
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: TextField(
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
                            padding: EdgeInsets.all(15),
                            child: ElevatedButton(
                              onPressed: () {
                                // Implemente a ação de login aqui
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Color(0xFF0B759D),
                              ),
                              child: Text('entrar'),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Container-Pai 2 (Registro)
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 20),
                    width: 300,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Color(0xFF0B759D), width: 4),
                    ),
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(15, 15, 15, 20),
                          child: Text(
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
                          padding: EdgeInsets.all(15),
                          child: ElevatedButton(
                            onPressed: () {
                              // Implemente a ação de registro aqui
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Color(0xFF0B759D),
                            ),
                            child: Text('cadastrar'),
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
