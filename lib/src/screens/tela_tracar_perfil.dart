import 'package:flutter/material.dart';

void main() {
  runApp(FavoritesScreen());
}

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(

        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/tela-inicial.png'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            FavoritesBody(),
          ],
        ),
        bottomNavigationBar: BottomMenu(),
      ),
    );
  }
}

class FavoritesBody extends StatelessWidget {
  const FavoritesBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Text(
            'Selecione seus Favoritos',
            style: TextStyle(
              fontSize: 26,
              fontFamily: 'Poppins',
              fontWeight: FontWeight.bold,
              color: Color(0xFF0B759D),
            ),
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: 5, 
              itemBuilder: (context, index) {
                return FavoriteItem(
                  songName: 'Nome da Música $index',
                  artistName: 'Nome do Artista $index',
                  imagePath: 'caminho/para/imagem.jpg',
                );
              },
            ),
          ),

          Container(
            margin: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                  onPressed: () {
                    print('Refresh Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0B759D), 
                    onPrimary: Colors.white, 
                    side: BorderSide(color: Colors.white), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), 
                    ),
                  ),
                  child: Text('Refresh'),
                ),
                ElevatedButton(
                  onPressed: () {
                    print('Pronto Pressed');
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Color(0xFF0B759D), 
                    onPrimary: Colors.white, 
                    side: BorderSide(color: Colors.white), 
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(0), 
                    ),
                  ),
                  child: Text('Pronto'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FavoriteItem extends StatelessWidget {
  final String songName;
  final String artistName;
  final String imagePath;

  const FavoriteItem({
    required this.songName,
    required this.artistName,
    required this.imagePath,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      height: 120,
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.8),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: const Color(0xFF0B759D), width: 4),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [  
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: Colors.grey, 
                borderRadius: BorderRadius.circular(8),
              ),  
            ), 
            SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    songName,
                    style: TextStyle(
                      fontSize: 16,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF0B759D),
                    ),
                  ),
                  SizedBox(height: 5),
                  Text(
                    artistName,
                    style: TextStyle(
                      fontSize: 14,
                      fontFamily: 'Poppins',
                      color: Color(0xFF0B759D),
                    ),
                  ),
                ],
              ),
            ),

            InkWell(
              onTap: () {
                print('Coração Clicado');
              },
              child: Icon(
                Icons.favorite,
                color: Color(0xFF0B759D),
                size: 24,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class BottomMenu extends StatelessWidget {
  const BottomMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: Color(0xFF1FBABF), 
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconButton(
              onPressed: () {
                print('Ícone 1 Pressionado');
              },
              icon: Image.asset(
                'assets/music_info.png',
                width: 100,
                height: 100,
              ),
            ),
            IconButton(
              onPressed: () {
                print('Ícone 2 Pressionado');
              },
              icon: Image.asset(
                'assets/Sikh.png',
                width: 100,
                height: 100,
              ),
            ), 
            IconButton(
              onPressed: () {
                print('Ícone 3 Pressionado');
              },
              icon: Image.asset(
                'assets/playlists.png',
                width: 100,
                height: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}