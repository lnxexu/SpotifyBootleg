import 'package:flutter/material.dart';
import 'artist_page.dart';
import '/data/get_playlist.dart';

class YourPlaylist extends StatelessWidget {
  const YourPlaylist({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Playlists'),
        backgroundColor: Colors.black,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    title: Text(
                      playlist['name'],
                      style: const TextStyle(fontFamily: "Raleway"),
                    ),
                    onTap: () {
                      _showPlaylistSongs(context, playlist);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showPlaylistSongs(BuildContext context, Map<String, dynamic> playlist) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(16.0),
          height: 400, // Adjust height as needed
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                playlist['name'],
                style: const TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16.0),
              Expanded(
                child: ListView.builder(
                  itemCount: playlist['songs'].length,
                  itemBuilder: (context, songIndex) {
                    final song = playlist['songs'][songIndex];
                    return ListTile(
                      title: Text(
                        song['title'],
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 18,
                        ),
                      ),
                      subtitle: Text(
                        song['artist'],
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 14,
                        ),
                      ),
                      onTap: () {
                        // Redirect to artist's page
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ArtistPage(artistName: song['artist']),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
