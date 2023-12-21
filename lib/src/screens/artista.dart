import 'package:flutter/material.dart';
import 'music_info.dart';

void main() {
  runApp(MaterialApp(
    home: ArtistPage(artist: Artist(name: 'Nome do Artista', songs: List.generate(20, (index) => 'Música ${index + 1}'))),
  ));
}

class Artist {
  final String name;
  final List<String> songs;

  Artist({required this.name, required this.songs});
}

class ArtistPage extends StatefulWidget {
  final Artist artist;

  const ArtistPage({Key? key, required this.artist}) : super(key: key);

  @override
  State<ArtistPage> createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.asset(
            'images/tela-inicial.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Container(
              width: 350.0,
              margin: const EdgeInsets.only(top: 50.0, bottom: 20.0),
              decoration: const BoxDecoration(
                color: Colors.transparent,
              ),
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(20.0),
                            topRight: Radius.circular(20.0),
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            IconButton(
                              icon: const Icon(
                                Icons.arrow_back_ios,
                                color: Colors.white,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Text(
                        widget.artist.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      Container(
                        width: 250.0,
                        height: 150.0,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.0),
                          image: const DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage('images/matt.jpg'),
                          ),
                        ),
                      ),
                      const SizedBox(height: 16.0),
                      const SizedBox(height: 8.0),
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: _buildSongList(),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildSongList() {
    return SingleChildScrollView(
      child: Column(
        children: widget.artist.songs.map((songName) {
          return _buildSongContainer(songName);
        }).toList(),
      ),
    );
  }

  Widget _buildSongContainer(String songName) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _buildDismissibleSong(songName),
    );
  }

  Widget _buildDismissibleSong(String songName) {
    return Dismissible(
      key: Key(songName),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        _removeSong(songName);
        _showSongRemovedSnackBar(songName);
      },
      background: _buildDismissBackground(),
      child: _buildSongTile(songName),
    );
  }

  Widget _buildDismissBackground() {
    return Container(
      color: Colors.red,
      alignment: AlignmentDirectional.centerEnd,
      padding: const EdgeInsets.only(right: 16.0),
      child: const Icon(
        Icons.delete,
        color: Colors.white,
      ),
    );
  }

  Widget _buildSongTile(String songName) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(songName),
          _buildPopupMenu(songName),
        ],
      ),
    );
  }

  Widget _buildPopupMenu(String songName) {
    return PopupMenuButton<String>(
      onSelected: (value) {
        _handlePopupMenuSelection(value, songName);
      },
      itemBuilder: (context) => [
        const PopupMenuItem<String>(
          value: 'info',
          child: Text('Sobre a música'),
        ),
        const PopupMenuItem<String>(
          value: 'addToPlaylist',
          child: Text('Adicionar a:'),
        ),
      ],
    );
  }

  void _removeSong(String songName) {
    setState(() {
      widget.artist.songs.remove(songName);
    });
  }

  void _showSongRemovedSnackBar(String songName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$songName foi removida da lista de músicas do artista'),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _handlePopupMenuSelection(String value, String songName) {
    if (value == 'info') {
      _navigateToMusicInfoScreen(songName);
    } else if (value == 'delete') {
      ScaffoldMessenger.of(context).hideCurrentSnackBar();
      _removeSong(songName);
      _showSongRemovedSnackBar(songName);
    }
  }

  void _navigateToMusicInfoScreen(String songName) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => MusicInfo(songName: songName),
      ),
    );
  }

  Widget _buildBottomNavigationBar() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.11,
      padding: const EdgeInsets.all(8.2),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 33, 205, 243),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildBottomNavItem('images/music_info.png', 'Info'),
          _buildBottomNavItem('images/Sikh.png', 'Home'),
          _buildBottomNavItem('images/playlists.png', 'Playlists'),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(String iconPath, String label) {
    return TextButton(
      onPressed: () {
      
      },
      child: Column(
        children: <Widget>[
          Image.asset(iconPath),
          Text(
            label,
            style: const TextStyle(
              fontSize: 12.0,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
