import 'package:flutter/material.dart';
import '/data/get_artists.dart'; // Ensure this path is correct
import '/data/get_songs.dart'; // Ensure this path is correct
import 'artist_page.dart';
import 'package:corpuz_ui/views/playlist.dart';
import 'package:corpuz_ui/views/home.dart';

class ArtistSearch extends SearchDelegate<String> {
  ArtistSearch()
      : super(
          searchFieldLabel: "Search",
          searchFieldStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color.fromARGB(255, 202, 202, 202),
              fontFamily: 'Raleway'),
          keyboardType: TextInputType.text,
          textInputAction: TextInputAction.search,
        );

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = _getFilteredResults();

    return Scaffold(
      body: _buildResultsList(context, results),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const YourPlaylist()),
            );
          }
        },
      ),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return Scaffold(
        body: const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Play what you love",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color.fromARGB(255, 221, 220, 220),
                  fontFamily: 'Raleway',
                ),
              ),
              SizedBox(height: 10),
              Text(
                "Search for artist and songs",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: Color.fromARGB(255, 221, 220, 220),
                  fontFamily: 'Raleway',
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavigationBar(
          currentIndex: 1,
          onTap: (index) {
            if (index == 0) {
              Navigator.popUntil(context, ModalRoute.withName('/'));
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
          },
        ),
      );
    }

    final suggestions = _getFilteredResults();
    return Scaffold(
      body: _buildResultsList(context, suggestions),
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: 1,
        onTap: (index) {
          if (index == 0) {
            Navigator.popUntil(context, ModalRoute.withName('/'));
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const YourPlaylist()),
            );
          }
        },
      ),
    );
  }

  List<Map<String, String>> _getFilteredResults() {
    List<Map<String, String>> results = [];

    // Filter artists
    for (var artist in artists) {
      if (artist.toLowerCase().contains(query.toLowerCase())) {
        results.add({
          'type': 'artist',
          'name': artist,
        });
      }
    }

    // Filter songs
    artistSongs.forEach((artistName, songList) {
      for (var songMap in songList['songs']!) {
        var song = songMap['title'] as String;
        if (song.toLowerCase().contains(query.toLowerCase())) {
          results.add({
            'type': 'song',
            'artist': artistName,
            'title': song,
          });
        }
      }
    });

    return results;
  }

  Widget _buildResultsList(
      BuildContext context, List<Map<String, String>> results) {
    if (results.isEmpty) {
      return const Center(
          child: Text("No results found. Try different keywords."));
    }

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        final result = results[index];
        if (result['type'] == 'artist') {
          return ListTile(
            title: Text(
              result['name']!,
              style: const TextStyle(fontFamily: 'Raleway'),
            ),
            onTap: () {
              // Navigate to the artist's page when an artist is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ArtistPage(artistName: result['name']!),
                ),
              );
            },
          );
        } else if (result['type'] == 'song') {
          return ListTile(
            title: Text(
              result['title']!,
              //size of the text
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
            subtitle: Text(
              '${result['artist']}',
              style: const TextStyle(
                fontSize: 12,
                letterSpacing: 0.5,
              ),
            ),
            onTap: () {
              // Navigate to the artist's page when a song is clicked
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      ArtistPage(artistName: result['artist']!),
                ),
              );
            },
          );
        }
        return Container(); // Fallback in case of unexpected data
      },
    );
  }
}
