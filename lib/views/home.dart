import 'package:flutter/material.dart';
import 'artist_list_page.dart'; // Import your artist list page
import 'footer.dart'; // Import your footer if needed
import '/data/get_recentlyPlayed.dart'; // Import recently played artists data
import '/data/get_images.dart'; // Import images

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify'),
        backgroundColor: Colors.black,
      ),
      body: Column(
        children: [
          // Recently Listened Section Header
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Recently Listened',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
          ),
          // Recently Listened Section
          Expanded(
            child: ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: RecentlyPlayedArtists.length,
              itemBuilder: (context, index) {
                final artistName = RecentlyPlayedArtists[index];
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
          ),
        ],
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
            // Navigate to Your Library screen if implemented
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const YourLibraryScreen()));
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
    final String imagePath =
        getArtistImage(artistName); // Get image path from artistImages map

    return Container(
        width: 10,
        margin: const EdgeInsets.symmetric(horizontal: 118.0),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                'Song Title', // You can replace this with actual song title if available
                style: TextStyle(color: Colors.white),
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0),
              child: Text(
                artistName,
                style: const TextStyle(color: Colors.white54, fontSize: 12),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }

  String getArtistImage(String artistName) {
    return artistImages[artistName] ?? '';
  }
}
