import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:groove_guru_app/src/screens/login.dart';
import 'package:groove_guru_app/src/screens/user_playlists.dart';
import 'music_select.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const Home());
}

class SearchBar extends StatefulWidget {
  final String? userName;

  const SearchBar({Key? key, this.userName}) : super(key: key);

  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  late String _userName;

  @override
  void initState() {
    super.initState();
    _userName = widget.userName ?? 'Usuário';
  }

  @override
  void didUpdateWidget(SearchBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.userName != null && widget.userName != _userName) {
      setState(() {
        _userName = widget.userName!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height * 0.1,
      padding: const EdgeInsets.only(left: 20.0, right: 20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Olá, $_userName',
            style: const TextStyle(fontSize: 16.0, color: Colors.white),
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.75,
            height: MediaQuery.of(context).size.height * 0.05,
            margin: const EdgeInsets.only(top: 20.0, bottom: 20.0),
            child: TextField(
              style: const TextStyle(fontSize: 12.0, color: Colors.black),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.white,
                hintText: 'Buscar',
                contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
              ),
              onSubmitted: (value) {},
            ),
          ),
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Login(),
                ),
              );
            },
            icon: Image.asset(
              'images/home.png',
              width: 24,
              height: 24,
            ),
            iconSize: 24,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String _userName = '';
  late List<String> _userPlaylists = [];

  @override
  void initState() {
    super.initState();
    getCurrentUserName().then((userName) {
      setState(() {
        _userName = userName ?? 'Usuário';
      });
    });
    getUserPlaylists().then((playlists) {
      setState(() {
        _userPlaylists = playlists;
      });
    });
  }

  Future<String?> getCurrentUserName() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      return snapshot['userName'];
    }
    return null;
  }

  Future<List<String>> getUserPlaylists() async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user = auth.currentUser;
    if (user != null) {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('playlists')
          .where('userId', isEqualTo: user.uid)
          .get();
      return querySnapshot.docs.map((doc) => doc['name'] as String).toList();
    }
    return [];
  }

  double sliderValue1 = 0.0;
  double sliderValue2 = 0.0;
  double sliderValue3 = 0.0;
  double sliderValue4 = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/tela-inicial.png"),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Column(
            children: [
              SearchBar(userName: _userName.isNotEmpty ? _userName : null),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      _buildHorizontalPlaylists(),
                      _buildFeaturedSection(),
                      _buildExploreSection(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildHorizontalPlaylists() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.15,
      margin: const EdgeInsets.only(bottom: 30.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _userPlaylists.length < 3 ? 3 : _userPlaylists.length + 1,
        itemBuilder: (context, index) {
          if (index < _userPlaylists.length) {
            return Container(
              width: 200,
              height: 30,
              margin: const EdgeInsets.only(right: 32.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFF0C66AF),
              ),
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  _userPlaylists[index],
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          } else {
            return Container(
              width: 200,
              height: 30,
              margin: const EdgeInsets.only(right: 32.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(10)),
                color: Color(0xFF0C66AF),
              ),
              padding: const EdgeInsets.all(3.0),
              child: Center(
                child: Text(
                  'Crie sua playlist agora',
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildFeaturedSection() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const MusicListPage(),
          ),
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.15,
        margin: const EdgeInsets.only(bottom: 30.0),
        padding: const EdgeInsets.all(15.0),
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color.fromARGB(108, 12, 102, 175),
            ),
          ],
        ),
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Para você mesmo escolher e procurar suas músicas:',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
            Expanded(
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 8,
                itemBuilder: (context, index) {
                  return Container(
                    width: 70,
                    height: 70,
                    margin: const EdgeInsets.only(right: 16.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color.fromARGB(108, 12, 102, 175),
                        ),
                      ],
                    ),
                    child: Image.asset(
                      'images/song${index + 1}.png',
                      fit: BoxFit.contain,
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildExploreSection() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.51,
      margin: const EdgeInsets.only(bottom: 16.0),
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(108, 12, 102, 175),
          ),
        ],
      ),
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(bottom: 10.0),
            child: const Text(
              'Explore!',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          _buildSlider("Dançabilidade:", sliderValue1, (value) {
            setState(() {
              sliderValue1 = value;
            });
          }),
          _buildSlider("BPM:", sliderValue2, (value) {
            setState(() {
              sliderValue2 = value;
            });
          }),
          _buildSlider("Animação:", sliderValue3, (value) {
            setState(() {
              sliderValue3 = value;
            });
          }),
          _buildSlider("Instrumentalidade:", sliderValue4, (value) {
            setState(() {
              sliderValue4 = value;
            });
          }),
          Container(
            margin: const EdgeInsets.only(top: 12, bottom: 12),
            child: ElevatedButton(
              onPressed: () {
                // handle button action
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(
                    const Color.fromARGB(255, 9, 61, 104)),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              ),
              child: const Text(
                'Buscar',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontFamily: 'Poppins',
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSlider(String title, double value, Function(double) onChanged) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
        Slider(
          value: value,
          onChanged: onChanged,
          min: 0.0,
          max: 100.0,
          thumbColor: const Color.fromARGB(255, 255, 255, 255),
          activeColor: const Color.fromARGB(255, 9, 61, 104),
        ),
      ],
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
                  builder: (_) => const MusicListPage(),
                ));
          }),
          _buildBottomNavItem('images/Sikh.png', 'Home', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const Home(),
                ));
          }),
          _buildBottomNavItem('images/playlists.png', 'Playlists', () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const UserPlaylists(),
                ));
          }),
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
