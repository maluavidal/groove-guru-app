import 'package:flutter/material.dart';
import 'playlist.dart';
import 'package:groove_guru_app/src/screens/home.dart';

class UserPlaylists extends StatefulWidget {
  const UserPlaylists({Key? key}) : super(key: key);

  @override
  State<UserPlaylists> createState() => _UserPlaylistsState();
}

class _UserPlaylistsState extends State<UserPlaylists> {
  List<String> playlists = [
    "My Playlist 1",
    "My Playlist 2",
    "My Playlist 3",
    "My Playlist 4",
    "My Playlist 5",
    "My Playlist 6",
    "My Playlist 7",
    "My Playlist 8",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("images/tela-inicial.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            _buildSearchBar(),
            _buildPlaylistContainers(),
          ],
        ),
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: const Color.fromARGB(255, 33, 205, 243),
      automaticallyImplyLeading: false,
      title: Row(
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
          const SizedBox(width: 8),
          const Text(
            'Minhas Playlists',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              Icons.add,
              color: Colors.white,
            ),
            onPressed: () {
              _showCreatePlaylistDialog();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0, left: 13.0, right: 13.0, top: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar playlists',
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          filled: true,
          fillColor: Colors.white,
        ),
        onChanged: (value) {
          // Handle search input
        },
      ),
    );
  }

  Widget _buildPlaylistContainers() {
    return Expanded(
      child: ListView.builder(
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return _buildPlaylistContainer(playlists[index]);
        },
      ),
    );
  }

  Widget _buildPlaylistContainer(String playlistName) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Playlist(playlistName: playlistName),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: 70,
        margin: const EdgeInsets.only(bottom: 16.0, left: 13.0, right: 13.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(108, 12, 102, 175),
            ),
          ],
        ),
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Text(
            playlistName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
        ),
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

  Future<void> _showCreatePlaylistDialog() async {
  String playlistName = '';

  return showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        title: const Text('Nomeie a sua playlist'),
        content: TextField(
          onChanged: (value) {
            playlistName = value;
          },
          style: const TextStyle(color: Colors.black),
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            filled: true,
            fillColor: Colors.white,
          ),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () {
              _createPlaylist(playlistName);
              Navigator.of(context).pop();
            },
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            child: const Text('Criar',
              style: TextStyle(color: Colors.white)),
          ),
        ],
      );
    },
  );
}

  void _createPlaylist(String playlistName) {
    setState(() {
      playlists.add(playlistName);
    });
  }
}

void main() {
  runApp(const MaterialApp(
    home: UserPlaylists(),
  ));
}
