import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; // Add this import
import 'package:share/share.dart';
import 'package:corpuz_ui/views/home.dart';
import 'package:corpuz_ui/views/playlist_page.dart';
import 'package:corpuz_ui/views/search.dart';
import 'package:corpuz_ui/views/player.dart';
import '/models/song.dart'; // Add this import

class ArtistPage extends StatefulWidget {
  final String artistName;

  const ArtistPage({super.key, required this.artistName});

  @override
  // ignore: library_private_types_in_public_api
  _ArtistPageState createState() => _ArtistPageState();
}

class _ArtistPageState extends State<ArtistPage> {
  void _shareContent(BuildContext context) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    Share.share(
      'Check out this artist: ${widget.artistName}',
      sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size,
    );
  }

  @override
  Widget build(BuildContext context) {
    final artistProvider = Provider.of<ArtistProvider>(context);
    final artist = artistProvider.getArtistByName(widget.artistName);
    final List<Song> songs = artist.songs;
    final String description = artist.description;
    final String imagePath = artist.image;

    return Scaffold(
      appBar: AppBar(
        actions: [
          PopupMenuButton<String>(
            icon: const Icon(Icons.more_vert),
            onSelected: (String value) {
              switch (value) {
                case 'follow':
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
                        height: MediaQuery.of(context).size.height * 0.35,
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
                      bottom: 40,
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
                                  blurRadius: 5),
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
                    const SizedBox(height: 16),
                    Text(
                      description,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontFamily: String.fromEnvironment("Raleway"),
                      ),
                    ),
                    const SizedBox(height: 20),
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
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount:
                            MediaQuery.of(context).size.width > 600 ? 2 : 1,
                        childAspectRatio: 7,
                      ),
                      itemCount: songs.length,
                      itemBuilder: (context, index) {
                        return Card(
                          color: Colors.grey[850],
                          margin: const EdgeInsets.all(8.0),
                          elevation: 4,
                          child: InkWell(
                            onTap: () {
                              print(
                                  'Selected song: ${songs[index].title} at index: $index');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => Player(
                                    songName: songs[index].title,
                                    artistName: widget.artistName,
                                    artistImage: imagePath,
                                    localFilePath: songs[index].audio,
                                  ),
                                ),
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  songs[index].title,
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
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 0,
        onTap: (index) {
          if (mounted) {
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
          }
        },
      ),
    );
  }
}
