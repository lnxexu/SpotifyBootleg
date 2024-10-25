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
      appBar: AppBar(
        title: Text(artistName),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String value) {
              switch (value) {
                case 'follow':
                  print('Followed $artistName');
                  break;
                case 'share':
                  print('Shared $artistName');
                  break;
                case 'discography':
                  print('Viewing discography of $artistName');
                  break;
              }
            },
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem<String>(
                  value: 'follow',
                  child: Text('Follow'),
                ),
                const PopupMenuItem<String>(
                  value: 'share',
                  child: Text('Share'),
                ),
                const PopupMenuItem<String>(
                  value: 'discography',
                  child: Text('Discography'),
                ),
              ];
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
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
                      height: MediaQuery.of(context).size.height *
                          0.35, // Responsive height
                      width: double.infinity,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.35,
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
                  Positioned(
                    bottom: 50,
                    left: 16,
                    right: 16,
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        artistName,
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          shadows: [
                            Shadow(
                                color: Colors.black54,
                                offset: Offset(1, 1),
                                blurRadius: 5), // Shadow for better readability
                          ],
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
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
                  const SizedBox(height: 16), // Space before description
                  Text(
                    description,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontFamily: String.fromEnvironment("Raleway"),
                    ),
                  ),
                  const SizedBox(
                      height: 20), // Space before Recently Played section
                  const Text('Recently played',
                      style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                  GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 4.4,
                    ),
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Colors.grey[850],
                        margin: const EdgeInsets.all(8.0),
                        elevation: 4, // Added elevation for modern look
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Center(
                            child: Text(
                              songs[index],
                              style: const TextStyle(color: Colors.white),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      );
                    },
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
