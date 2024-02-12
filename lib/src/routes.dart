import 'package:flutter/material.dart';
import 'screens/home.dart';
import 'screens/login.dart';
import 'screens/register.dart';
import 'screens/user_playlists.dart';
import 'screens/music_select.dart';

class Routes {
  static const String home = '/';
  static const String login = '/login';
  static const String register = '/register';
  static const String userPlaylists = '/user-playlists';
  static const String musicSelect = '/music-select';

  static final Map<String, WidgetBuilder> routes = {
    home: (context) => const Home(),
    login: (context) => const Login(),
    register: (context) => Register(),
    userPlaylists: (context) => const UserPlaylists(),
    musicSelect: (context) =>
        const MusicListPage()
  };
}
