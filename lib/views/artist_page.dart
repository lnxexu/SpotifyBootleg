import 'package:flutter/material.dart';
import '/data/get_songs.dart'; // Import your get_songs functions
import '/data/get_descriptions.dart'; // Import your get_descriptions functions
import '/data/get_images.dart'; // Import your get_images functions
import 'package:share/share.dart';
import 'package:corpuz_ui/views/home.dart';
import 'package:corpuz_ui/views/playlist.dart';
import 'package:corpuz_ui/views/search.dart';

class ArtistPage extends StatefulWidget {
  final String artistName;

  const ArtistPage({super.key, required this.artistName});

  @override
  // ignore: library_private_types_in_public_api
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  String nowPlayingSong = "Sample Song"; // Replace with actual now playing song
  bool isPlaying = false;
  bool isPlayingSong = false; // Add this variable to manage play/pause state

  void _shareContent(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      'Check out this artist: ${widget.artistName}',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    // Get songs for the selected artist
    final List<String> songs = getSongsByArtist(widget.artistName);
    // Get description for the selected artist
    final String description =
        artistDescription[widget.artistName] ?? "No description available.";
    // Get image for the selected artist
    final String imagePath = artistImages[widget.artistName] ?? '';

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.artistName),
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String value) {
              switch (value) {
                case 'follow':
                  // show a snackbar or toast message
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Followed artist'),
                    ),
                  );
                  break;
                case 'share':
                  _shareContent(context);
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
      body: SafeArea(
        child: SingleChildScrollView(
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
                            0.349, // Responsive height
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
                          widget.artistName,
                          style: const TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontFamily: 'IntegralCF',
                            shadows: [
                              Shadow(
                                  color: Colors.black54,
                                  offset: Offset(1, 1),
                                  blurRadius:
                                      5), // Shadow for better readability
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
                            color: Colors.white,
                            fontFamily: 'IntegralCF')),
                    const SizedBox(height: 20),
                    GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            1, // Adjusted to fit more items in a row
                        childAspectRatio:
                            7, // Adjusted aspect ratio for smaller tiles
                      ),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[850],
                          margin: const EdgeInsets.all(8.0),
                          elevation: 4, // Added elevation for modern look
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                nowPlayingSong = songs[index];
                                isPlaying = true;
                                isPlayingSong = true; // Set to playing state
                              });
                            },
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
      ),
      bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isPlaying)
            BottomAppBar(
              color: Colors.grey[900],
              height: 96, // Increased height
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 12.0, vertical: 6.0), // Increased padding
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Now Playing',
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 12, // Increased font size
                            ),
                          ),
                          Text(
                            nowPlayingSong,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16, // Increased font size
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            widget.artistName,
                            style: TextStyle(
                              color: Colors.grey[400],
                              fontSize: 14, // Increased font size
                            ),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                      icon: Icon(
                        isPlayingSong ? Icons.pause : Icons.play_arrow,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        setState(() {
                          isPlayingSong =
                              !isPlayingSong; // Toggle play/pause state
                        });
                      },
                    ),
                  ],
                ),
              ),
            ),
          CustomBottomNavigationBar(
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
        ],
      ),
    );
  }
}
