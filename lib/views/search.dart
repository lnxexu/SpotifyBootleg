import 'package:flutter/material.dart';
import '/data/get_artists.dart'; // Ensure this path is correct
import '/data/get_songs.dart'; // Ensure this path is correct
import 'artist_page.dart';

class ArtistSearch extends SearchDelegate<String> {
  ArtistSearch()
      : super(
          searchFieldLabel: "Search artist or song",
          searchFieldStyle: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.blue,
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

    return _buildResultsList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = _getFilteredResults();

    return _buildResultsList(context, suggestions);
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
    artistSongs.forEach((artistName, songs) {
      for (var song in songs) {
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
              style: const TextStyle(fontFamily: 'Raleway'),
            ),
            subtitle: Text(
              '${result['artist']}'.toUpperCase(),
              style: const TextStyle(
                fontFamily: 'IntegralCF',
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
