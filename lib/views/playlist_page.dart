import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corpuz_ui/models/song.dart';
import 'package:corpuz_ui/views/home.dart';
import 'package:corpuz_ui/views/search.dart';
import 'package:corpuz_ui/models/playlist.dart';
import 'package:corpuz_ui/views/player.dart';


class YourPlaylist extends StatefulWidget {
  const YourPlaylist({super.key});

  @override
  _YourPlaylistState createState() => _YourPlaylistState();
}

class _YourPlaylistState extends State<YourPlaylist> {
  int _currentIndex = 2;

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
    final playlistProvider = Provider.of<PlaylistProvider>(context);
    final playlistsData = playlistProvider.playlists;

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
      body: _buildPlaylistScreen(
          playlistsData), // Pass playlistsData to the method
      bottomNavigationBar: CustomBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTap,
      ),
    );
  }

  Widget _buildPlaylistScreen(List<Playlist> playlistsData) {
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
                  title: Text(playlist.name,
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
                  final playlistProvider =
                      Provider.of<PlaylistProvider>(context, listen: false);
                  final deletedPlaylist =
                      playlistProvider.playlists.removeAt(index);
                  Navigator.of(context).pop(); // Close the dialog
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        'Playlist "${deletedPlaylist.name}" has been deleted!',
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

  void _showPlaylistSongs(BuildContext context, Playlist playlist) {
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
                    playlist.name,
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
                      initialItemCount: playlist.songs.length,
                      itemBuilder: (context, songIndex, animation) {
                        final playlistSong = playlist.songs[songIndex];
                        return _buildSongTile(context, playlistSong, songIndex,
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
      PlaylistSong playlistSong,
      int songIndex,
      Playlist playlist,
      Animation<double> animation,
      StateSetter setModalState,
      GlobalKey<AnimatedListState> listKey) {
    return SizeTransition(
      sizeFactor: animation,
      child: ListTile(
        title: Text(playlistSong.song.title,
            style: const TextStyle(fontFamily: 'Raleway', fontSize: 18)),
        subtitle: Text(playlistSong.artist.name,
            style: const TextStyle(fontFamily: 'Raleway', fontSize: 14)),
        trailing: Wrap(
          spacing: 6,
          children: [
            Chip(
              label: Text(playlistSong.song.genre,
                  style: const TextStyle(fontFamily: 'Raleway', fontSize: 12)),
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: () {
                setModalState(() {
                  _removeSongFromPlaylist(
                      playlist, songIndex, setModalState, listKey, context);
                });
              },
            ),
          ],
        ),
        onTap: () {
          Navigator.pop(context); // Close the modal
          _playSongFromPlaylist(context, playlist, songIndex);
        },
      ),
    );
  }

  void _playSongFromPlaylist(
      BuildContext context, Playlist playlist, int songIndex) {
    final audioProvider = Provider.of<AudioProvider>(context, listen: false);
    final song = playlist.songs[songIndex].song;

    audioProvider.initAudio(song.audio).then((_) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Player(
            songName: song.title,
            artistName: playlist.songs[songIndex].artist.name,
            artistImage: playlist.songs[songIndex].artist.image,
            localFilePath: song.audio,
          ),
        ),
      );
    });

    audioProvider.audioPlayer.onPlayerComplete.listen((event) {
      if (songIndex + 1 < playlist.songs.length) {
        _playSongFromPlaylist(context, playlist, songIndex + 1);
      }
    });
  }

  void _showSongSearch(BuildContext context, Playlist playlist,
      StateSetter setModalState, GlobalKey<AnimatedListState> listKey) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Allow the modal to be full screen
      builder: (BuildContext context) {
        return SongSearchScreen(
          onSongSelected: (songDetail) {
            final artistProvider =
                Provider.of<ArtistProvider>(context, listen: false);
            final artist = artistProvider.getArtistBySong(songDetail);

            // Check if the song is already in the playlist
            bool isDuplicate = playlist.songs.any((playlistSong) =>
                playlistSong.song.title == songDetail.title &&
                playlistSong.song.genre == songDetail.genre);

            if (isDuplicate) {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Duplicate Song'),
                    content: Text(
                        '${songDetail.title} is already in the playlist. Do you want to add it again?'),
                    actions: <Widget>[
                      TextButton(
                        onPressed: () =>
                            Navigator.of(context).pop(), // Close the dialog
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            playlist.songs.add(
                                PlaylistSong(song: songDetail, artist: artist));
                          });
                          setModalState(() {
                            listKey.currentState
                                ?.insertItem(playlist.songs.length - 1);
                          });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                '${songDetail.title} added!',
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
                playlist.songs
                    .add(PlaylistSong(song: songDetail, artist: artist));
              });
              setModalState(() {
                listKey.currentState?.insertItem(playlist.songs.length - 1);
              });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    '${songDetail.title} added!',
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
        final playlistProvider =
            Provider.of<PlaylistProvider>(context, listen: false);
        playlistProvider.playlists
            .add(Playlist(name: newPlaylistName, songs: []));
      });
    }
  }

  void _editPlaylistName(int index) async {
    String? updatedName = await _showInputDialog('Update playlist name',
        initialValue: Provider.of<PlaylistProvider>(context, listen: false)
            .playlists[index]
            .name);

    if (updatedName != null && updatedName.isNotEmpty) {
      setState(() {
        Provider.of<PlaylistProvider>(context, listen: false)
            .playlists[index]
            .name = updatedName;
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
      Playlist playlist,
      int songIndex,
      StateSetter setModalState,
      GlobalKey<AnimatedListState> listKey,
      BuildContext context) {
    final removedSong = playlist.songs[songIndex];

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Remove Song'),
          content: Text(
              'Are you sure you want to remove "${removedSong.song.title}" from the playlist?'),
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
                  playlist.songs.removeAt(songIndex); // Remove the song
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
                      '${removedSong.song.title} has been removed!',
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
  final Function(Song) onSongSelected;

  const SongSearchScreen({super.key, required this.onSongSelected});

  @override
  _SongSearchScreenState createState() => _SongSearchScreenState();
}

class _SongSearchScreenState extends State<SongSearchScreen> {
  List<Song> allSongs = [];
  List<Song> filteredSongs = [];
  String searchQuery = '';

  @override
  void initState() {
    super.initState();
    allSongs = getAllSongs(); // Get all songs from your data source
    filteredSongs = allSongs; // Initialize filtered list with all songs
  }

  List<Song> getAllSongs() {
    final artistProvider = Provider.of<ArtistProvider>(context, listen: false);
    List<Song> songs = [];
    for (var artist in artistProvider.artists) {
      songs.addAll(artist.songs);
    }
    return songs;
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
                          .where((song) => song.title
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
          Song songDetail = filteredSongs[index];
          final artistProvider =
              Provider.of<ArtistProvider>(context, listen: false);
          final artist = artistProvider.artists.firstWhere(
            (artist) => artist.songs.contains(songDetail),
            orElse: () =>
                Artist(name: 'Unknown', description: '', image: '', songs: []),
          );

          return ListTile(
            title: Text(
              songDetail.title,
              style: const TextStyle(fontFamily: 'Raleway'),
            ),
            subtitle: Text(
              artist.name,
              style: const TextStyle(fontFamily: 'Raleway'),
            ),
            trailing: Wrap(
              spacing: 6,
              children: [
                Chip(
                  label: Text(songDetail.genre,
                      style:
                          const TextStyle(fontFamily: 'Raleway', fontSize: 12)),
                ),
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: () {
                    widget.onSongSelected(songDetail);
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
