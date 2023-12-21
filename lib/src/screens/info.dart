import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MusicInfo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MusicScreen(),
    );
  }
}

class MusicScreen extends StatelessWidget {
  const MusicScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Music Player'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
                'assets\_606ef8e1-e655-4c35-8965-7ff8cbd6e772 1.png'), // Coloque o caminho da sua imagem aqui
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Título
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Your Music Library',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors
                      .white, // Adicionando cor ao título para visibilidade
                ),
              ),
            ),
            // Barra de Pesquisa
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Search songs...',
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
            ),
            // Lista de Músicas
            Expanded(
              child: ListView(
                children: List.generate(
                  20,
                  (index) => ListTile(
                    leading: Icon(Icons.music_note),
                    title: Text('Song Title $index'),
                    subtitle: Text('Artist $index'),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: Icon(Icons.home),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.library_music),
              onPressed: () {},
            ),
            IconButton(
              icon: Icon(Icons.settings),
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
