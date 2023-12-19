import 'package:flutter/material.dart';

class MusicInfo extends StatelessWidget {
  final String songName;

  const MusicInfo({Key? key, required this.songName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody(context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: _buildContainerDecoration(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 3.0),
                _buildBackArrow(context),
                const SizedBox(height: 16.0),
                _buildSongImage(),
                const SizedBox(height: 16.0),
                _buildSongDetails(),
              ],
            ),
          ),
        ),
      ],
    );
  }

  BoxDecoration _buildContainerDecoration() {
    return const BoxDecoration(
      image: DecorationImage(
        image: AssetImage('images/tela-inicial.png'),
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildBackArrow(BuildContext context) {
    return Row(
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
    );
  }

  Widget _buildSongImage() {
    // Replace this with the actual widget you want to use for the song image
    return Container(
      height: 200.0,
      color: Colors.grey, // Placeholder color
    );
  }

  Widget _buildSongDetails() {
    return Text(
      'Song Details: $songName',
      style: const TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    );
  }

  Widget _buildBottomNavigationBar(BuildContext context) {
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
