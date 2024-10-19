import 'package:flutter/material.dart';
import '/data/get_artists.dart';
import '/data/get_playlist.dart';
import '/data/get_recentlyPlayed.dart';

class ArtistSearch extends SearchDelegate<String> {
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
    final results = artists
        .where((artist) => artist.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildArtistList(context, results);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = artists
        .where((artist) => artist.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return _buildArtistList(context, suggestions);
  }

  Widget _buildArtistList(BuildContext context, List<String> artistList) {
    return ListView.builder(
      itemCount: artistList.length,
      itemBuilder: (context, index) {
        final artistName = artistList[index];
        return ListTile(
          title: Text(artistName),
          onTap: () {
            close(context,
                artistName); // Close the search and return the selected artist
          },
        );
      },
    );
  }
}

class YourLibraryScreen extends StatelessWidget {
  const YourLibraryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Library'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Recently Played Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Recently Played Artists',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: RecentlyPlayedArtists.length,
              itemBuilder: (context, index) {
                final artistName = RecentlyPlayedArtists[index];
                return ListTile(
                  title: Text(artistName),
                  onTap: () {
                    // Navigate to the artist page if desired
                  },
                );
              },
            ),

            // Playlists Section
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'Playlists',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: playlistsData.length,
              itemBuilder: (context, index) {
                final playlist = playlistsData[index];
                return ListTile(
                  title: Text(playlist['name']),
                  onTap: () {
                    // Navigate to the playlist details page if desired
                  },
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
