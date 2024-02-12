import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groove_guru_app/src/screens/home.dart';
import 'package:groove_guru_app/src/screens/user_playlists.dart';

class MusicInfo extends StatelessWidget {
  final DocumentSnapshot musicSnapshot;

  const MusicInfo({Key? key, required this.musicSnapshot}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildBody(context),
      bottomNavigationBar: _buildBottomNavigationBar(context),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/tela-inicial.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildBackArrow(context),
            SizedBox(height: 10),
            Expanded(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    width: 300,
                    height: 300,
                    child: Image.asset(
                      'images/logos.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 0),
            _buildDetailsContainer(),
          ],
        ),
      ],
    );
  }

  Widget _buildBackArrow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(
            width: 40,
            height: 35,
            child: IconButton(
              icon: Image.asset('images/back.png'),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildDetailsContainer() {
    return Container(
      margin: const EdgeInsets.all(16.0),
      padding: const EdgeInsets.symmetric(vertical: 50.0, horizontal: 16.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Colors.grey[200],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildDetail('Artista', musicSnapshot['artist(s)_name']),
          _buildDetail('Nome da música', musicSnapshot['track_name']),
          _buildDetail('Streams', musicSnapshot['streams'].toString()),
          _buildDetail('Data de Lançamento',
              '${musicSnapshot['released_day']}/${musicSnapshot['released_month']}/${musicSnapshot['released_year']}'),
        ],
      ),
    );
  }

  Widget _buildDetail(String label, String detail) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 2.0),
      child: RichText(
        text: TextSpan(
          style: TextStyle(
              color: Colors.black,
              fontSize: 19.0),
          children: [
            TextSpan(
              text: '$label: ',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            TextSpan(text: detail),
          ],
        ),
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
          _buildBottomNavItem(context, 'images/music_info.png', 'Search', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Home(),
                ));
          }),
          _buildBottomNavItem(context, 'images/Sikh.png', 'Home', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Home(),
                ));
          }),
          _buildBottomNavItem(context, 'images/playlists.png', 'Playlists', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => UserPlaylists(),
                ));
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(
      BuildContext context, String iconPath, String label, VoidCallback onTap) {
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
