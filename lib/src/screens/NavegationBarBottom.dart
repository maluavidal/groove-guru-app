// bottom_navigation_bar.dart
import 'package:flutter/material.dart';
import 'package:groove_guru_app/src/screens/home.dart';
import 'package:groove_guru_app/src/screens/user_playlists.dart';

class NavegationBarBottom extends StatelessWidget {
  const NavegationBarBottom({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.17,
      height: MediaQuery.of(context).size.height * 0.17,
      padding: const EdgeInsets.all(8.2),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 33, 205, 243),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          _buildBottomNavItem('images/music_info.png', 'Info', () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => Home(),
            ));
          }),
          _buildBottomNavItem('images/Sikh.png', 'Home', () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => Home(),
            ));
          }),
          _buildBottomNavItem('images/playlists.png', 'Playlists', () {
            Navigator.push(context, MaterialPageRoute(
              builder: (_) => UserPlaylists(),
            ));
          }),
        ],
      ),
    );
  }

  Widget _buildBottomNavItem(String iconPath, String label, VoidCallback onTap) {
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
