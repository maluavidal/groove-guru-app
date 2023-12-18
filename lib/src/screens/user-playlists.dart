import 'package:flutter/material.dart';

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
      automaticallyImplyLeading: false, // Disable the default back button
      title: Row(
        children: [
          IconButton(
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
            ),
            onPressed: () {
              // Handle back arrow press
            },
          ),
          const SizedBox(width: 8), // Adjust the width as needed
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
              // Handle creating a new playlist
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
    return Container(
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

void main() {
  runApp(const MaterialApp(
    home: UserPlaylists(),
  ));
}
