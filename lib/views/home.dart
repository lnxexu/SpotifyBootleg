// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'artist_page.dart';
import 'search.dart';
import '../data/get_recentlyplayed.dart';
import '/data/get_images.dart';
import 'playlist_page.dart';
import '/views/settings.dart';
import '/views/profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Bootleg',
            style: TextStyle(fontSize: 20, fontFamily: 'IntegralCF')),
        backgroundColor: Colors.black,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.green.shade800,
                image: const DecorationImage(
                  image: AssetImage('assets/images/kobe.jpg'),
                  fit: BoxFit.cover,
                  alignment: Alignment.center, // Centers the image
                  colorFilter: ColorFilter.mode(
                      Color.fromRGBO(0, 0, 0, 0.5), BlendMode.darken),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 70,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 2),
                    ),
                    child: const CircleAvatar(
                      radius: 35,
                      backgroundImage: AssetImage('assets/images/kobe.jpg'),
                    ),
                  ),
                  const Text(
                    'Kobe Corpuz',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Text(
                    'cartiMananap@example.com',
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: EdgeInsets.zero,
                children: [
                  const SizedBox(height: 10),
                  ListTile(
                    leading: Icon(
                      Icons.account_circle,
                      color: Colors.green.shade800,
                    ),
                    title: const Text(
                      'Account',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ProfilePage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.settings,
                      color: Colors.green.shade800,
                    ),
                    title: const Text(
                      'Settings',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SettingsPage()),
                      );
                    },
                  ),
                  const Divider(),
                  ListTile(
                    leading: Icon(
                      Icons.logout,
                      color: Colors.green.shade800,
                    ),
                    title: const Text(
                      'Logout',
                      style: TextStyle(fontSize: 16),
                    ),
                    onTap: () {
                      // confirmation
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: const Text('Are you sure?'),
                            content: const Text('Do you want to logout?'),
                            actions: [
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text('No'),
                              ),
                              TextButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  Navigator.pushReplacementNamed(context, '/');
                                },
                                child: const Text('Yes'),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            const Divider(),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10),
              child: const Text(
                'Version 1.0.0',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            // Advertisement section with video
            const AdSection(),
            const Padding(
              padding: EdgeInsets.only(
                  left: 16.0,
                  top: 30,
                  bottom: 30), // Adjusted padding for left alignment
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('RECENTLY LISTENED',
                    style: TextStyle(
                        fontSize: 27,
                        fontFamily: 'IntegralCF',
                        fontWeight:
                            FontWeight.bold)), // Increased font size and weight
              ),
            ),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    1, // Change to one column for rectangular layout
                childAspectRatio:
                    5, // Adjust aspect ratio for rectangular cards
              ),
              itemCount: recentlyPlayedArtists.length > 10
                  ? 10
                  : recentlyPlayedArtists.length,
              itemBuilder: (context, index) {
                final artistName = recentlyPlayedArtists[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ArtistPage(artistName: artistName),
                      ),
                    );
                  },
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(
                        32), // Adjust the radius as needed
                    child: RecentlyListenedCard(artistName: artistName),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          setState(() {
            if (index == 1) {
              showSearch(
                context: context,
                delegate: ArtistSearch(),
              );
            } else if (index == 2) {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, animation, secondaryAnimation) =>
                      const YourPlaylist(),
                  transitionsBuilder:
                      (context, animation, secondaryAnimation, child) {
                    return FadeTransition(
                      opacity: animation,
                      child: child,
                    );
                  },
                ),
              );
            }
          });
        },
      ),
    );
  }
}

class CustomBottomNavigationBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNavigationBar(
      {super.key, required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.search),
          label: 'Search',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.library_music),
          label: 'Your Playlist',
        ),
      ],
      currentIndex: currentIndex,
      selectedItemColor: Colors.green,
      onTap: onTap,
    );
  }
}

class AdSection extends StatefulWidget {
  const AdSection({super.key});

  @override
  _AdSectionState createState() => _AdSectionState();
}

class _AdSectionState extends State<AdSection> {
  late VideoPlayerController _controller;
  late Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.asset('assets/images/spotify_ad.mp4');
    _initializeVideoPlayerFuture = _controller.initialize().then((_) {
      setState(() {
        _controller.setLooping(true); // Loop the video
        _controller.setVolume(0); // Mute the video
        _controller.play(); // Start playing the video automatically
      });
    }).catchError((error) {
      // ignore: avoid_print
      print("Error initializing video player: $error");
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200, // Adjust height as needed
      child: FutureBuilder<void>(
        future: _initializeVideoPlayerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return Stack(
              children: [
                Positioned.fill(
                    child: VideoPlayer(
                        _controller)), // Display the video player here
                Container(
                    color: Colors.black
                        .withOpacity(0.5)), // Transparent black overlay
                const Center(
                  child: Text(
                    'music for everyone',
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'IntegralCF'),
                  ),
                ),
              ],
            );
          } else {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading spinner while initializing
          }
        },
      ),
    );
  }
}

class RecentlyListenedCard extends StatelessWidget {
  final String artistName;

  const RecentlyListenedCard({super.key, required this.artistName});

  @override
  Widget build(BuildContext context) {
    final String imagePath = getArtistImage(artistName);

    return Container(
      margin: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: Colors.grey[850],
        borderRadius: BorderRadius.circular(0), // Hard corners
        boxShadow: const [
          BoxShadow(color: Colors.black54, blurRadius: 5), // Shadow effect
        ],
      ),
      child: Row(children: [
        ClipRRect(
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(0), bottomLeft: Radius.circular(0)),
            child: Image.asset(imagePath,
                width:
                    MediaQuery.of(context).size.width * .25, // Image takes up
                height: double.infinity,
                fit: BoxFit.cover)), // Crop to fill area

        Expanded(
          child: Container(
              padding: const EdgeInsets.all(16.0),
              alignment: Alignment.centerLeft,
              color: Colors.grey[850], // Same background color as card
              child: Text(artistName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                  overflow: TextOverflow.ellipsis)),
        )
      ]),
    );
  }

  String getArtistImage(String artistName) {
    return artistImages[artistName] ?? '';
  }
}
