import 'package:flutter/material.dart';

class Recomendation extends StatefulWidget {
  const Recomendation({Key? key}) : super(key: key);

  @override
  State<Recomendation> createState() => _RecomendationState();
}

class _RecomendationState extends State<Recomendation>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  List<List> playlists = [
    ['Playlist 1', 'Playlist 2', 'Playlist 3', 'Playlist 4'],
    ['Playlist 1', 'Playlist 2', 'Playlist 3', 'Playlist 4'],
    ['Playlist 1', 'Playlist 2', 'Playlist 3', 'Playlist 4']
  ];
  List<List> artistsList = [
    ['Artist 1', 'Artist 2', 'Artist 3', 'Artist 4'],
    ['Artist 1', 'Artist 2', 'Artist 3', 'Artist 4'],
    ['Artist 1', 'Artist 2', 'Artist 3', 'Artist 4']
  ];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            "images/tela-inicial.png",
            fit: BoxFit.cover,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
          ),
          _buildContent(),
        ],
        
        
      ),bottomNavigationBar: _buildBottomNavigationBar(),
    );
  }

  Widget _buildContent() {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: _buildAppBar(),
        body: _buildTabBarView(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0, 
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
            'Recomendações',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontFamily: 'Poppins',
            ),
          ),
          const Spacer(),
        ],
      ),
      bottom: PreferredSize(
        preferredSize: Size.fromHeight(48.0),
        child: _buildMusicArtistNavBar(),
      ),
    );
  }

  Widget _buildTabBarView() {
    return TabBarView(
      controller: _tabController,
      children: [
        _buildMusicScreenRecomendation(),
        _buildMusicScreenArtists(),
      ],
    );
  }

  Widget _buildMusicScreenRecomendation() {
    return Container(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.height * 0.9,
      margin: const EdgeInsets.only(bottom: 50.0),
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: playlists.length,
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(vertical: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: 225,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: playlists[index].length,
                    itemBuilder: (context, playlistIndex) {
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.only(right: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              width: 125,
                              height: 125,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                border: Border.all(
                                  color: Colors.blue,
                                  width: 2.0,
                                ),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "images/tela-inicial.png",
                                  width: 125,
                                  height: 125,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            const SizedBox(height: 10),
                            Text(
                              playlists[index][playlistIndex],
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontSize: 20),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

Widget _buildMusicScreenArtists() {


  return Container(
    width: MediaQuery.of(context).size.width * 0.9,
    height: MediaQuery.of(context).size.height * 0.9,
    margin: const EdgeInsets.only(bottom: 50.0),
    child: ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: artistsList.length,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 225,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: artistsList[index].length,
                  itemBuilder: (context, artistIndex) {
                    return Container(
                      width: 150,
                      margin: const EdgeInsets.only(right: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            width: 125,
                            height: 125,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(
                                color: Colors.blue,
                                width: 2.0,
                              ),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(15),
                              child: Image.asset(
                                "images/ariana_grande.jpeg",
                                width: 125,
                                height: 125,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            artistsList[index][artistIndex],
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    ),
  );
}

  Widget _buildMusicArtistNavBar() {
    return Container(
      color: Colors.transparent,
      child: TabBar(
        controller: _tabController,
        tabs: [
          Tab(
            child: Text("Músicas", style: TextStyle(color: Colors.white,fontSize: 25)),
          ),
          Tab(
            child: Text("Artistas", style: TextStyle(color: Colors.white,fontSize: 25)),
          ),
        ],
        indicator: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: Colors.blue,
              width: 2.0,
            ),
          ),
        ),
        labelPadding: EdgeInsets.only(left: 16, right: 16),
        isScrollable: true,
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
    home: Recomendation(),
  ));
}
