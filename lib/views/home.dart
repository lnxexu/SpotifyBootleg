import 'package:flutter/material.dart';
import 'artist_page.dart';
import 'search.dart';
import '../data/get_recentlyplayed.dart';
import '/data/get_images.dart';
import 'playlist.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Spotify',
          style: TextStyle(fontSize: 20),
        ),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'RECENTLY LISTENED',
                style: TextStyle(
                  fontSize: 24,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.04,
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
                  child: RecentlyListenedCard(artistName: artistName),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
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
        currentIndex: 0,
        selectedItemColor: Colors.green,
        onTap: (index) {
          if (index == 1) {
            showSearch(context: context, delegate: ArtistSearch());
          } else if (index == 2) {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const YourPlaylist()));
          }
        },
      ),
    );
  }
}

class RecentlyListenedCard extends StatefulWidget {
  final String artistName;

  const RecentlyListenedCard({super.key, required this.artistName});

  @override
  _RecentlyListenedCardState createState() => _RecentlyListenedCardState();
}

class _RecentlyListenedCardState extends State<RecentlyListenedCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final String imagePath = getArtistImage(widget.artistName);

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300), // Animation duration
        transform: Matrix4.translationValues(
            0, _isHovered ? -10 : 0, 0), // Move up by 10 pixels
        child: Container(
          width: 200,
          height: 200,
          margin: const EdgeInsets.all(8.0),
          decoration: BoxDecoration(
            color: Colors.grey[850],
            borderRadius: BorderRadius.circular(10),
            boxShadow: _isHovered
                ? [
                    const BoxShadow(
                        color: Color.fromARGB(255, 0, 0, 0), blurRadius: 10)
                  ]
                : [],
          ),
          child: Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  imagePath,
                  width: double.infinity,
                  height: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              // Brightness overlay
              Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(_isHovered
                      ? 0.2
                      : 0.5), // Adjust opacity based on hover state
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              Center(
                child: Text(
                  widget.artistName,
                  style: TextStyle(
                      color: _isHovered ? Colors.white : Colors.white54,
                      fontSize: 20,
                      fontWeight:
                          _isHovered ? FontWeight.bold : FontWeight.normal),
                  textAlign: TextAlign.center,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  String getArtistImage(String artistName) {
    return artistImages[artistName] ?? '';
  }
}
