import 'package:flutter/material.dart';
import 'package:groove_guru_app/src/screens/home.dart';
import 'package:groove_guru_app/src/screens/user_playlists.dart';
import 'package:groove_guru_app/src/screens/NavegationBarBottom.dart';

class MusicInfo extends StatelessWidget {
  final String songName;

  const MusicInfo({Key? key, required this.songName}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: NavegationBarBottom(),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          child: Container(
            decoration: _buildContainerDecoration(),
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 3.0),
                _buildBackArrow(context),
                const SizedBox(height: 16.0),
                _buildSongImage(),
                const SizedBox(height: 16.0),
                Text(
                  songName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16.0),
                _buildDetailsContainer(),
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
    return Container(
      height: 300.0,
      width: 300.0,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(10.0),
        color: Colors.grey,
      ),
      // replace the color property with the actual image in the future
      // child: Image.asset('your_image_path_here'),
    );
  }

  Widget _buildDetailsContainer() {
  return Expanded(
    child: Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue, width: 4.0),
        borderRadius: BorderRadius.circular(16.0),
        color: Colors.white,
      ),
      margin: const EdgeInsets.only(bottom: 8.0),
      padding: const EdgeInsets.all(16.0),
      child: ListView(
        children: [
          _buildSongDetails(),
        ],
      ),
    ),
  );
}

  Widget _buildSongDetails() {
    return const Text(
      'song details',
      style: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.bold,
        color: Colors.black,
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
        _buildBottomNavItem(context, 'images/music_info.png', 'Info', () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => Home(),
          ));
        }),
        _buildBottomNavItem(context, 'images/Sikh.png', 'Home', () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => Home(),
          ));
        }),
        _buildBottomNavItem(context, 'images/playlists.png', 'Playlists', () {
          Navigator.push(context, MaterialPageRoute(
            builder: (_) => UserPlaylists(),
          ));
        }),
      ],
    ),
  );
}

Widget _buildBottomNavItem(BuildContext context, String iconPath, String label, VoidCallback onTap) {
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
