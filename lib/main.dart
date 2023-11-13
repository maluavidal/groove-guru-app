import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Groove Guru',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'GrooveGuru Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  double sliderValue1 = 0.0;
  double sliderValue2 = 0.0;
  double sliderValue3 = 0.0;
  double sliderValue4 = 0.0;

  List<String> items = ["Playlist 1", "Playlist 2", "Playlist 3", "Playlist 4", "Playlist 5"];

  List<String> imagePaths = [
    'images/playlists.png',
    'images/playlists.png',
    'images/playlists.png',
    'images/playlists.png',
    'images/playlists.png',
  ];

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
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.1,
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
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
                        onSubmitted: (value) {
                          // handle search input submission
                        },
                      ),
                    ),
                    const Icon(
                      Icons.account_circle,
                      size: 50,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      height: MediaQuery.of(context).size.height * 0.15,
                      margin: const EdgeInsets.only(bottom: 30.0),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: items.length,
                        itemBuilder: (context, index) {
                          return Container(
                            width: 200,
                            height: 30,
                            margin: const EdgeInsets.only(right: 32.0),
                            decoration: const BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(10)),
                              color: Color.fromARGB(255, 12, 102, 175),
                            ),
                            padding: const EdgeInsets.all(3.0),
                            child: Center(
                              child: Text(items[index]),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
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
                                'Para você:',
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
                              itemCount: imagePaths.length,
                              itemBuilder: (context, index) {
                                return Container(
                                  width: 70,
                                  height: 70,
                                  margin: const EdgeInsets.only(right: 16.0),
                                  child: Image.asset(
                                    imagePaths[index],
                                    fit: BoxFit.contain,
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      )
                    ),
                    Container(
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
                            child: const Text('Explore!',
                              style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                    fontFamily: 'Poppins',
                                  ),
                                ),
                              ),
                          _buildSlider("Característica 1:", sliderValue1, (value) {
                            setState(() {
                              sliderValue1 = value;
                            });
                          }),
                          _buildSlider("Característica 2:", sliderValue2, (value) {
                            setState(() {
                              sliderValue2 = value;
                            });
                          }),
                          _buildSlider("Característica 3:", sliderValue3, (value) {
                            setState(() {
                              sliderValue3 = value;
                            });
                          }),
                          _buildSlider("Característica 4:", sliderValue4, (value) {
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
                                backgroundColor: MaterialStateProperty.all<Color>(const Color.fromARGB(255, 9, 61, 104)),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10.0)
                                  ),
                                ),
                              ),
                            child: const Text('Buscar',
                            style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontFamily: 'Poppins',
                                ),
                              ),
                            ),
                          )
                          ],
                        ),
                      ),
                    ]
                  ),
                ),
              ),
              ]),
            ],
          ),
        bottomNavigationBar: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.11,
          padding: const EdgeInsets.all(8.2),
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 33, 205, 243),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              TextButton(
                onPressed: () {
                  // handle button action
                },
                child: Column(
                  children: <Widget>[
                    Image.asset('images/music_info.png'),
                    const Text(
                      'Info',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                        ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {
                  // handle button action
                },
                child: Column(
                  children: <Widget>[
                    Image.asset('images/Sikh.png'),
                    const Text(
                      'Home',
                      style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.white,
                      fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
                  
              ),
              TextButton(
                onPressed: () {
                  // handle button action
                },
                child: Column(
                  children: <Widget>[
                    Image.asset('images/playlists.png'),
                    const Text(
                      'Playlists',
                      style: TextStyle(
                        fontSize: 12.0,
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                        ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
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