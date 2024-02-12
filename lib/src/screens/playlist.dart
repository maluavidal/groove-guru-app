import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groove_guru_app/src/screens/music_info.dart';
import 'package:groove_guru_app/src/screens/home.dart';
import 'package:groove_guru_app/src/screens/user_playlists.dart';
import 'package:groove_guru_app/src/screens/music_select.dart';

class Playlist extends StatefulWidget {
  final String playlistId;

  const Playlist({Key? key, required this.playlistId}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<String> songs = [];

  @override
  void initState() {
    super.initState();
    _fetchSongs();
  }

  Future<void> _fetchSongs() async {
    try {
      DocumentSnapshot playlistSnapshot = await FirebaseFirestore.instance
          .collection('playlists')
          .doc(widget.playlistId)
          .get();

      if (playlistSnapshot.exists) {
        List<dynamic> musicIds = playlistSnapshot.get('musicIds');

        List<String> songNames = [];

        for (dynamic musicId in musicIds) {
          DocumentSnapshot musicSnapshot = await FirebaseFirestore.instance
              .collection('musics')
              .doc(musicId)
              .get();

          if (musicSnapshot.exists) {
            String songName = musicSnapshot.get('track_name') as String;
            songNames.add(songName);
          }
        }

        setState(() {
          songs = songNames;
        });
      }
    } catch (error) {
      print("Erro ao buscar músicas: $error");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/tela-inicial.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Pesquisar músicas...',
                prefixIcon: IconButton(
                  icon: Image.asset(
                    'images/search.png',
                    width: 20,
                    height: 20,
                  ),
                  onPressed: () {
                    // Implemente a lógica de pesquisa de músicas
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: songs.isEmpty
                ? Center(
                    child: ElevatedButton(
                      onPressed: () async {
                        await Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => MusicListPage(),
                          ),
                        );
                        _fetchSongs();
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.cyan,
                        onPrimary: Colors.blue,
                      ),
                      child: Text(
                        'Adicionar Músicas Agora',
                        style: TextStyle(
                          color: const Color.fromARGB(255, 255, 255, 255),
                        ),
                      ),
                    ),
                  )
                : _buildSongList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSongList() {
    return ListView.builder(
      itemCount: songs.length,
      itemBuilder: (context, index) {
        return _buildSongContainer(songs[index], index);
      },
    );
  }

  Widget _buildSongContainer(String songName, int index) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: _buildDismissibleSong(songName, index),
    );
  }

  Widget _buildDismissibleSong(String songName, int index) {
    return Dismissible(
      key: Key(songName),
      direction: DismissDirection.endToStart,
      onDismissed: (direction) {
        // Remove a música da playlist
        _removeSong(index);
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
        ],
      ),
    );
  }

  void _removeSong(int index) async {
    try {
      List<dynamic> musicIds = [];

      DocumentSnapshot playlistSnapshot = await FirebaseFirestore.instance
          .collection('playlists')
          .doc(widget.playlistId)
          .get();

      if (playlistSnapshot.exists) {
        musicIds = List.from(playlistSnapshot.get('musicIds'));
      }

      // Remove o ID da música da lista de IDs na playlist
      musicIds.removeAt(index);

      // Atualiza a lista de IDs de músicas na playlist
      await FirebaseFirestore.instance
          .collection('playlists')
          .doc(widget.playlistId)
          .update({'musicIds': musicIds});
    } catch (error) {
      print("Erro ao remover música da playlist: $error");
    }

    _fetchSongs();
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
          _buildBottomNavItem('images/music_info.png', 'Search', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MusicListPage(),
              ),
            );
          }),
          _buildBottomNavItem('images/Sikh.png', 'Home', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => Home(),
              ),
            );
          }),
          _buildBottomNavItem('images/playlists.png', 'Playlists', () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => UserPlaylists(),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
      String iconPath, String label, VoidCallback onTap) {
    return TextButton(
      onPressed: onTap,
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
