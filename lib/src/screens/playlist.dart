import 'package:flutter/material.dart';

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
    return ListView.builder(
      itemCount: 20, // Replace with the actual number of songs
      itemBuilder: (context, index) {
        final songName = 'Song ${index + 1}';
        return Dismissible(
          key: Key(songName),
          direction: DismissDirection.endToStart,
          onDismissed: (direction) {
            // Handle song removal
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('$songName removed from playlist'),
                duration: const Duration(seconds: 2),
              ),
            );
          },
          background: Container(
            color: Colors.red,
            alignment: AlignmentDirectional.centerEnd,
            padding: const EdgeInsets.only(right: 16.0),
            child: const Icon(
              Icons.delete,
              color: Colors.white,
            ),
          ),
          child: ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(songName),
                const Icon(Icons.remove_circle, color: Colors.red),
              ],
            ),
          ),
        );
      },
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
