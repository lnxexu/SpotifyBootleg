import 'package:corpuz_ui/views/home.dart';
import 'package:corpuz_ui/views/search.dart';
import 'package:flutter/material.dart';
import 'artist_page.dart'; // Import the artist page
import '/data/get_songs.dart'; // Import the songs data
import '/data/get_playlist.dart' as playlist; // Import the playlists data

class YourPlaylist extends StatefulWidget {
  const YourPlaylist({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _YourPlaylistState createState() => _YourPlaylistState();
}

class _YourPlaylistState extends State<YourPlaylist> {
  List<Map<String, dynamic>> playlistsData = []; // Initialize playlistsData
  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    _loadPlaylists(); // Load playlists on initialization
  }

  void _loadPlaylists() {
    setState(() {
      playlistsData = playlist.playlistsData; // Get playlists from data source
    });
  }

  void _onTap(int index) {
    setState(() {
      _currentIndex = index;
    });
    if (index == 1) {
      showSearch(
        context: context,
        delegate: ArtistSearch(),
      );
    } else if (index == 0) {
      Navigator.popUntil(context, ModalRoute.withName('/'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Playlists'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: _addNewPlaylist, // Add new playlist
          ),
        ],
      ),
      body:
          _buildPlaylistScreen(), // Reference the _buildPlaylistScreen method here
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Widget _buildPlaylistScreen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Playlists',
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'IntegralCF'),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: playlistsData.length,
            itemBuilder: (context, index) {
              final playlist = playlistsData[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                child: ListTile(
                  title: Text(playlist['name'],
                      style: const TextStyle(fontFamily: "Raleway")),
                  onTap: () => _showPlaylistSongs(context, playlist),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit),
                        onPressed: () => _editPlaylistName(index),
                        tooltip: 'Edit',
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete), // Trash can icon
                        onPressed: () => _confirmDeletePlaylist(index),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  void _confirmDeletePlaylist(int index) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Delete Playlist'),
          content: const Text('Are you sure you want to delete this playlist?'),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop(), // Close the dialog
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  final deletedPlaylist = playlistsData.removeAt(index);
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Playlist "${deletedPlaylist['name']}" has been deleted!',
                        style: const TextStyle(
                          fontFamily: 'Raleway',
                          color: Colors.black,
                        ),
                      ),
                      backgroundColor: Colors.white,
                      elevation: 0.0,
                    ),
                  );
                });
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }

  void _showPlaylistSongs(BuildContext context, Map<String, dynamic> playlist) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setModalState) {
            final GlobalKey<AnimatedListState> listKey =
                GlobalKey<AnimatedListState>();
            return Container(
              padding: const EdgeInsets.all(16.0),
              height: 400,
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
                    child: AnimatedList(
                      key: listKey,
                      initialItemCount: playlist['songs'].length,
                      itemBuilder: (context, songIndex, animation) {
                        final song = playlist['songs'][songIndex];
                        return _buildSongTile(context, song, songIndex,
                            playlist, animation, setModalState, listKey);
                      },
                    ),
                  ),
                  OutlinedButton(
                    onPressed: () => _showSongSearch(
                        context, playlist, setModalState, listKey),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: const Color.fromARGB(255, 212, 212, 212),
                      side: const BorderSide(
                          color:
                              Color.fromARGB(255, 233, 233, 233)), // Text color
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(20), // Rounded corners
                      ),
                    ),
                    child: const Text(
                      'Add Song',
                      style: TextStyle(
                        fontFamily: 'Raleway',
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSongTile(
      BuildContext context,
      Map<String, String> song,
      int songIndex,
      Map<String, dynamic> playlist,
      Animation<double> animation,
      StateSetter setModalState,
      GlobalKey<AnimatedListState> listKey) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text(song['title'] ?? 'Unknown Artist',
            style: const TextStyle(fontFamily: 'Raleway', fontSize: 18)),
        subtitle: Text(song['artist'] ?? 'Unknown Artist',
            style: const TextStyle(fontFamily: 'Raleway', fontSize: 14)),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            setModalState(() {
              _removeSongFromPlaylist(
                  playlist, songIndex, setModalState, listKey, context);
            });
          },
        ),
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  ArtistPage(artistName: song['artist'] ?? 'Unknown Artist')),
        ),
      ),
    );
  }

  void _showSongSearch(BuildContext context, Map<String, dynamic> playlist,
      StateSetter setModalState, GlobalKey<AnimatedListState> listKey) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the modal to be full screen
      builder: (BuildContext context) {
        return SongSearchScreen(
          onSongSelected: (songDetail) {
            // Check if the song is already in the playlist
            bool isDuplicate = playlist['songs'].any((song) =>
                song['title'] == songDetail['title'] &&
                song['artist'] == songDetail['artist']);

            if (isDuplicate) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Duplicate Song'),
                    content: Text(
                        '${songDetail['title']} is already in the playlist. Do you want to add it again?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(), // Close the dialog
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            playlist['songs'].add(songDetail);
                          });
                          setModalState(() {
                            listKey.currentState
                                ?.insertItem(playlist['songs'].length - 1);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${songDetail['title']} added!',
                                style: const TextStyle(
                                  fontFamily: 'Raleway',
                                  color: Colors.black,
                                ),
                              ),
                              backgroundColor: Colors.white,
                            ),
                          );
                          Navigator.of(context).pop(); // Close the dialog
                        },
                        child: const Text('Add'),
                      ),
                    ],
                  );
                },
              );
            } else {
              setState(() {
                playlist['songs'].add(songDetail);
              });
              setModalState(() {
                listKey.currentState?.insertItem(playlist['songs'].length - 1);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${songDetail['title']} added!',
                    style: const TextStyle(
                      fontFamily: 'Raleway',
                      color: Colors.black,
                    ),
                  ),
                  backgroundColor: Colors.white,
                ),
              );
            }
          },
        );
      },
    );
  }

  void _addNewPlaylist() async {
    String? newPlaylistName = await _showInputDialog('Enter playlist name');

    if (newPlaylistName != null && newPlaylistName.isNotEmpty) {
      setState(() {
        playlistsData.add({'name': newPlaylistName, 'songs': []});
      });
    }
  }

  void _editPlaylistName(int index) async {
    String? updatedName = await _showInputDialog('Update playlist name',
        initialValue: playlistsData[index]['name']);

    if (updatedName != null && updatedName.isNotEmpty) {
      setState(() {
        playlistsData[index]['name'] = updatedName;
      });
    }
  }

  Future<String?> _showInputDialog(String title, {String? initialValue}) async {
    String? inputText;

    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        final controller = TextEditingController(text: initialValue);

        return AlertDialog(
          title: Text(title),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Enter text"),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel')),
            TextButton(
                onPressed: () {
                  inputText = controller.text;
                  Navigator.pop(context);
                },
                child: const Text('OK')),
          ],
        );
      },
    );

    return inputText;
  }

  void _removeSongFromPlaylist(
      Map<String, dynamic> playlist,
      int songIndex,
      StateSetter setModalState,
      GlobalKey<AnimatedListState> listKey,
      BuildContext context) {
    final removedSong = playlist['songs'][songIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Song'),
          content: Text(
              'Are you sure you want to remove "${removedSong['title']}" from the playlist?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
            TextButton(
              child: const Text('Yes'),
              onPressed: () {
                setState(() {
                  playlist['songs'].removeAt(songIndex); // Remove the song
                });
                setModalState(() {
                  listKey.currentState?.removeItem(
                    songIndex,
                    (context, animation) => _buildSongTile(
                      context,
                      removedSong,
                      songIndex,
                      playlist,
                      animation,
                      setModalState,
                      listKey,
                    ),
                  );
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(
                      '${removedSong['title']} has been removed!',
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        color: Colors.black,
                      ),
                    ),
                    backgroundColor: Colors.white,
                    elevation: 0.0,
                  ),
                );
                Navigator.of(context).pop(); // Close the dialog
              },
            ),
          ],
        );
      },
    );
  }
}

class SongSearchScreen extends StatefulWidget {
  final Function(Map<String, String>) onSongSelected;

  const SongSearchScreen({super.key, required this.onSongSelected});

  @override
  // ignore: library_private_types_in_public_api
  _SongSearchScreenState createState() => _SongSearchScreenState();
}

class _SongSearchScreenState extends State<SongSearchScreen> {
  List<Map<String, String>> allSongs = [];
  List<Map<String, String>> filteredSongs = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    allSongs = getAllSongs(); // Get all songs from your data source
    filteredSongs = allSongs; // Initialize filtered list with all songs
  }

  List<Map<String, String>> getAllSongs() {
    List<Map<String, String>> songsList = [];
    artistSongs.forEach((artist, songs) {
      for (var song in songs.values.expand((list) => list as List<String>)) {
        songsList.add({
          'title': song,
          'artist': artist,
          'genre': getGenresByArtist(artist).firstWhere(
            (genre) => getSongsByArtist(artist).contains(song),
            orElse: () => 'Unknown Genre',
          ),
        }); // Create a map for each song and artist
      }
    });
    return songsList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Songs'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  searchQuery = value;
                  filteredSongs = searchQuery.isNotEmpty
                      ? allSongs
                          .where((song) => song['title']!
                              .toLowerCase()
                              .contains(searchQuery.toLowerCase()))
                          .toList()
                      : allSongs; // Only filter if there's input
                });
              },
              decoration: const InputDecoration(
                hintText: 'Search for a song',
                border: OutlineInputBorder(),
              ),
            ),
          ),
        ),
      ),
      body: ListView.builder(
        itemCount: filteredSongs.length,
        itemBuilder: (context, index) {
          Map<String, String> songDetail = filteredSongs[index];
          return ListTile(
            title: Text(
              songDetail['title']!,
              style: const TextStyle(fontFamily: 'Raleway'),
            ),
            subtitle: Text(
              songDetail['artist']!,
              style: const TextStyle(fontFamily: 'Raleway'),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.add),
              onPressed: () {
                widget.onSongSelected(songDetail);
              },
            ),
          );
        },
      ),
    );
  }
}
