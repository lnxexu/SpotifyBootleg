import 'package:flutter/material.dart';
import 'player.dart';
import '/data/get_images.dart'; // Import the artist images

class SongsPage extends StatelessWidget {
  final String artistName;
  final List<String> songs;

  // Removed artistImage and artistDescription as they will be fetched from the mapping
  const SongsPage({
    super.key,
    required this.artistName,
    required this.songs,
  });

  @override
  Widget build(BuildContext context) {
    // Get the image and description from the imported data
    String artistImage = artistImages[artistName] ?? ''; // Fetch image path
    String artistDescription =
        "Description for $artistName"; // Placeholder description

    return Scaffold(
      appBar: AppBar(title: Text(artistName), centerTitle: true, elevation: 0),
      body: Column(
        children: [
          // Add an image and description at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(artistImage,
                    height: 200, fit: BoxFit.cover), // Display artist image
                const SizedBox(height: 8),
                Text(
                  artistDescription,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: songs.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  title: Text(songs[index]),
                  leading: const Icon(Icons.music_note),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayingSongPage(
                          songName: songs[index],
                          artistName: artistName,
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
