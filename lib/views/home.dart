// ignore_for_file: library_private_types_in_public_api
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'artist_page.dart';
import 'search.dart';
import '../data/get_recentlyplayed.dart';
import '/data/get_images.dart';
import 'playlist.dart';
import '/views/settings.dart';
import '/views/profile.dart';
import '/views/search.dart';

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
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade800,
              ),
              child: const Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.account_circle),
              title: const Text('Account'),
              onTap: () {
                // Handle account tap
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ProfileEditor()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Handle settings tap
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const SettingsPage()));
              },
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {
                // Handle logout
                Navigator.pop(context);
              },
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
            // Additional content...
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

  CustomBottomNavigationBar({required this.currentIndex, required this.onTap});

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
    _controller = VideoPlayerController.asset('assets/spotify_ad.mp4');
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
