import 'package:flutter/material.dart';
import 'music_info.dart';

void main() {
  runApp(const MaterialApp(
    home: Playlist(playlistName: 'Your Playlist Name'),
  ));
}

class Playlist extends StatefulWidget {
  final String playlistName;

  const Playlist({Key? key, required this.playlistName}) : super(key: key);

  @override
  State<Playlist> createState() => _PlaylistState();
}

class _PlaylistState extends State<Playlist> {
  List<String> songs = List.generate(20, (index) => 'Song ${index + 1}');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildBody() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('images/tela-inicial.png'),
                fit: BoxFit.cover,
              ),
            ),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
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
                const SizedBox(height: 8.0),
                Text(
                  widget.playlistName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8.0),
                Expanded(
                  child: _buildSongList(),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSongList() {
    return ListView(
      children: songs.map((songName) {
        return _buildSongContainer(songName);
      }).toList(),
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
          value: 'delete',
          child: Text('Remover'),
        ),
      ],
    );
  }

  void _removeSong(String songName) {
    setState(() {
      songs.remove(songName);
    });
  }

  void _showSongRemovedSnackBar(String songName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$songName foi removida de sua playlist'),
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
        // handle button action
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
