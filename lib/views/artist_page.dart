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
      body: SingleChildScrollView(
        // Make the whole page scrollable
        child: Column(
          children: [
            if (imagePath.isNotEmpty)
              Stack(
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.vertical(
                        bottom: Radius.circular(20)),
                    child: Image.asset(
                      imagePath,
                      height: 500,
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          const Color.fromRGBO(20, 18, 24, 1).withOpacity(1),
                        ],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
                ],
              ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 8), // Reduced space before artist name
                  Text(
                    artistName,
                    style: const TextStyle(
                        fontSize: 70,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 8), // Reduced space after artist name

                  // Create a Row for two columns
                  Row(
                    mainAxisAlignment:
                        MainAxisAlignment.spaceBetween, // Space between columns
                    crossAxisAlignment:
                        CrossAxisAlignment.center, // Center vertically
                    children: [
                      // Left Column for Songs
                      Expanded(
                        flex: 2, // Adjust flex to control width
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center vertically in column
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                                height:
                                    20), // Add space at the top of Recently Played section
                            const Text('Recently played',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              shrinkWrap:
                                  true, // Use shrinkWrap to avoid infinite height
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 1,
                                childAspectRatio:
                                    10, // Aspect ratio for rectangular cards
                              ),
                              itemCount: songs.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  color: Colors.grey[850],
                                  margin: const EdgeInsets.all(8.0),
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Center(
                                      child: Text(
                                        songs[index],
                                        style: const TextStyle(
                                            color: Colors.white,
                                            fontFamily: String.fromEnvironment(
                                                'Raleway')),
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 16), // Space between columns
                      // Right Column for Description
                      Expanded(
                        flex: 1, // Adjust flex to control width
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment
                              .center, // Center vertically in column
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(description,
                                style: const TextStyle(
                                    color: Colors.white,
                                    fontFamily:
                                        String.fromEnvironment("Raleway"))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
