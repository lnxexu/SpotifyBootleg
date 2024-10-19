import 'package:flutter/material.dart';
import '/data/get_songs.dart'; // Import your get_songs functions
import '/data/get_descriptions.dart'; // Import your get_descriptions functions
import '/data/get_images.dart'; // Import your get_images functions

class ArtistPage extends StatelessWidget {
  final String artistName;

  const ArtistPage({super.key, required this.artistName});

  @override
  Widget build(BuildContext context) {
    // Get songs for the selected artist
    final List<String> songs = getSongsByArtist(artistName);
    // Get description for the selected artist
    final String description =
        artistDescription[artistName] ?? "No description available.";
    // Get image for the selected artist
    final String imagePath = artistImages[artistName] ?? '';

    return Scaffold(
      appBar: AppBar(title: Text(artistName)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Display artist image if available
            if (imagePath.isNotEmpty)
              Image.asset(imagePath, height: 200, fit: BoxFit.cover),
            const SizedBox(height: 16),
            const Text('Description:',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(description),
            const SizedBox(height: 20),
            Text('Songs by $artistName:',
                style:
                    const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Expanded(
              child: ListView.builder(
                itemCount: songs.length,
                itemBuilder: (context, index) {
                  return ListTile(title: Text(songs[index]));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
