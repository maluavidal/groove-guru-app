import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groove_guru_app/src/screens/home.dart';
import 'playlist.dart';
import 'package:groove_guru_app/src/screens/music_select.dart';

void main() {
  runApp(const MaterialApp(
    home: UserPlaylists(),
  ));
}

class UserPlaylists extends StatefulWidget {
  const UserPlaylists({Key? key}) : super(key: key);

  @override
  State<UserPlaylists> createState() => _UserPlaylistsState();
}

class _UserPlaylistsState extends State<UserPlaylists> {
  late User? _user;
  late List<String> playlists;
  String searchText = '';
  final CollectionReference playlistsCollection =
      FirebaseFirestore.instance.collection('playlists');

  @override
  void initState() {
    super.initState();
    _fetchUser();
    playlists = [];
    _fetchPlaylists();
  }

  Future<void> _fetchUser() async {
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _fetchPlaylists() async {
    if (_user != null) {
      QuerySnapshot playlistsSnapshot = await playlistsCollection
          .where('userId', isEqualTo: _user!.uid)
          .get();
      setState(() {
        playlists =
            playlistsSnapshot.docs.map((doc) => doc['name'] as String).toList();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> filteredPlaylists = playlists
        .where((playlist) =>
            playlist.toLowerCase().contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: _buildAppBar(),
      body: Container(
        color: const Color.fromARGB(255, 33, 205, 243),
        child: Column(
          children: [
            _buildSearchBar(),
            Expanded(
              child: ListView.builder(
                itemCount: filteredPlaylists.length,
                itemBuilder: (context, index) {
                  return _buildPlaylistContainer(filteredPlaylists[index]);
                },
              ),
            ),
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
            icon: Image.asset('images/back.png', width: 24, height: 24),
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
            icon: Image.asset('images/edit.png', width: 24, height: 24),
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
      padding: const EdgeInsets.only(
          bottom: 25.0, left: 26.0, right: 13.0, top: 16.0),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Buscar playlists',
          prefixIcon: Image.asset('images/search.png', width: 24, height: 24),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          filled: true,
          fillColor: Color(0xFFFFFFFF),
        ),
        onChanged: (value) {
          setState(() {
            searchText = value;
          });
        },
      ),
    );
  }

  Widget _buildPlaylistContainer(String playlistName) {
    return GestureDetector(
      onTap: () {
        _fetchPlaylistId(playlistName);
      },
      child: Dismissible(
        key: Key(playlistName),
        background: Container(
          color: Colors.red,
          alignment: Alignment.centerRight,
          child: Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: Image.asset('images/delete.png', width: 24, height: 24),
          ),
        ),
        onDismissed: (direction) {
          playlistsCollection
              .where('userId', isEqualTo: _user!.uid)
              .where('name', isEqualTo: playlistName)
              .get()
              .then((QuerySnapshot querySnapshot) {
            querySnapshot.docs.forEach((doc) {
              doc.reference.delete().then((value) {
                setState(() {
                  playlists.remove(playlistName);
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('$playlistName removida')),
                );
              }).catchError((error) {
                print("Failed to delete playlist: $error");
              });
            });
          }).catchError((error) {
            print("Failed to fetch playlist: $error");
          });
        },
        direction: DismissDirection.endToStart,
        child: Container(
          width: double.infinity,
          height: 70,
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.blue,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                blurRadius: 5,
                offset: Offset(0, 3),
              ),
            ],
          ),
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
          _buildBottomNavItem('images/music_info.png', 'Search', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => MusicListPage(),
                ));
          }),
          _buildBottomNavItem('images/Sikh.png', 'Home', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => Home(),
                ));
          }),
          _buildBottomNavItem('images/playlists.png', 'Playlists', () {}),
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
          Image.asset(iconPath, width: 48, height: 48),
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
          title: Text(
            'Nomeie a sua playlist',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          content: TextField(
            onChanged: (value) {
              playlistName = value;
            },
            decoration: InputDecoration(
              border: OutlineInputBorder(),
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
                backgroundColor: Colors.red,
              ),
              child: Text(
                'Cancelar',
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                _createPlaylist(playlistName);
                Navigator.of(context).pop();
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.white,
              ),
              child: Text(
                'Criar',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ],
        );
      },
    );
  }

  void _createPlaylist(String playlistName) {
    playlistsCollection.add({
      'name': playlistName,
      'userId': _user!.uid,
      'musicIds': [],
    });
    _fetchPlaylists();
  }

  void _fetchPlaylistId(String playlistName) {
    playlistsCollection
        .where('userId', isEqualTo: _user!.uid)
        .where('name', isEqualTo: playlistName)
        .get()
        .then((QuerySnapshot querySnapshot) {
      if (querySnapshot.docs.isNotEmpty) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => Playlist(
              playlistId: querySnapshot.docs.first.id,
            ),
          ),
        );
      }
    }).catchError((error) {
      print("Failed to fetch playlist: $error");
    });
  }
}
