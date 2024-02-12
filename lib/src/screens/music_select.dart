import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:groove_guru_app/src/screens/music_info.dart';

class MusicListPage extends StatefulWidget {
  const MusicListPage({Key? key}) : super(key: key);

  @override
  State<MusicListPage> createState() => _MusicListPageState();
}

class _MusicListPageState extends State<MusicListPage> {
  final CollectionReference musicsCollection =
      FirebaseFirestore.instance.collection('musics');
  final CollectionReference playlistsCollection =
      FirebaseFirestore.instance.collection('playlists');
  late List<DocumentSnapshot> musicSnapshots = [];
  String searchText = '';
  late User? _user;

  @override
  void initState() {
    super.initState();
    _fetchUser();
    _fetchMusicSnapshots();
  }

  Future<void> _fetchUser() async {
    _user = FirebaseAuth.instance.currentUser;
  }

  Future<void> _fetchMusicSnapshots() async {
    try {
      QuerySnapshot musicSnapshot = await musicsCollection.get();
      if (musicSnapshot.docs.isNotEmpty) {
        setState(() {
          musicSnapshots = musicSnapshot.docs;
        });
      } else {
        print("Nenhuma música encontrada.");
      }
    } catch (e) {
      print("Erro ao buscar músicas: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    List<DocumentSnapshot> filteredMusicSnapshots = musicSnapshots
        .where((snapshot) => snapshot['track_name']
            .toString()
            .toLowerCase()
            .contains(searchText.toLowerCase()))
        .toList();

    return Scaffold(
      appBar: AppBar(
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
              'Lista de Músicas',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          _buildSearchBar(),
          Expanded(
            child: ListView.builder(
              itemCount: filteredMusicSnapshots.length,
              itemBuilder: (context, index) {
                return _buildMusicContainer(filteredMusicSnapshots[index]);
              },
            ),
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
          hintText: 'Buscar músicas',
          prefixIcon: SizedBox(
            width: 12,
            height: 12,
            child: Image.asset('images/search.png', width: 6, height: 6),
          ),
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

  Widget _buildMusicContainer(DocumentSnapshot musicSnapshot) {
    String musicName = musicSnapshot['track_name'].toString();
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(12.0),
      ),
      child: ListTile(
        title: Text(
          musicName,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Poppins',
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Image.asset('images/music_info.png',
                  width: 24, height: 24, color: Colors.cyan),
              onPressed: () {
                _navigateToMusicInfo(context, musicSnapshot);
              },
            ),
            _buildAddToPlaylistButton(musicSnapshot),
          ],
        ),
      ),
    );
  }

  Widget _buildAddToPlaylistButton(DocumentSnapshot musicSnapshot) {
    return ElevatedButton(
      onPressed: () {
        _navigateToPlaylists(context, musicSnapshot);
      },
      style: ElevatedButton.styleFrom(
        primary: Color.fromARGB(255, 43, 177, 240),
        onPrimary: Colors.white,
      ),
      child: Text('Add to Playlist'),
    );
  }

  void _navigateToMusicInfo(
      BuildContext context, DocumentSnapshot musicSnapshot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => MusicInfo(musicSnapshot: musicSnapshot),
      ),
    );
  }

  void _navigateToPlaylists(
      BuildContext context, DocumentSnapshot musicSnapshot) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AddToPlaylistPage(musicSnapshot: musicSnapshot),
      ),
    );
  }
}

class AddToPlaylistPage extends StatelessWidget {
  final DocumentSnapshot musicSnapshot;

  const AddToPlaylistPage({Key? key, required this.musicSnapshot})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adicionar à Playlist'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('playlists')
            .where('userId', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          List<QueryDocumentSnapshot> playlists = snapshot.data!.docs;
          return ListView.builder(
            itemCount: playlists.length,
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(playlists[index]['name']),
                onTap: () {
                  _addToPlaylist(context, playlists[index].id);
                },
              );
            },
          );
        },
      ),
    );
  }

  void _addToPlaylist(BuildContext context, String playlistId) async {
    try {
      String musicId = musicSnapshot.id;

      final playlistDocRef =
          FirebaseFirestore.instance.collection('playlists').doc(playlistId);
      final playlistDocSnapshot = await playlistDocRef.get();

      List<dynamic> musicIds = [];
      if (playlistDocSnapshot.exists &&
          playlistDocSnapshot.data()!.containsKey('musicIds')) {
        musicIds = List.from(playlistDocSnapshot.data()!['musicIds']);
      }
      musicIds.add(musicId);

      await playlistDocRef.update({'musicIds': musicIds});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Música adicionada à playlist'),
          duration: Duration(seconds: 2),
        ),
      );
    } catch (error) {
      print('Erro ao adicionar música à playlist: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'Erro ao adicionar música à playlist. Tente novamente mais tarde.'),
          duration: Duration(seconds: 2),
        ),
      );
    }
  }
}
