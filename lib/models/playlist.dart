import 'package:flutter/material.dart';
import 'song.dart'; // Import the song.dart file to access Song and Artist models

// PlaylistSong Model
class PlaylistSong {
  final Song song;
  final Artist artist;

  PlaylistSong({
    required this.song,
    required this.artist,
  });
}

// Playlist Model
class Playlist {
  String name;
  final List<PlaylistSong> songs;

  Playlist({
    required this.name,
    required this.songs,
  });
}

// PlaylistProvider
class PlaylistProvider with ChangeNotifier {
  final List<Playlist> _playlists = [
    Playlist(
      name: 'My Playlist',
      songs: [
        PlaylistSong(
            song: Song(
              title: 'Duality',
              genre: 'Metal',
              audio: 'assets/songs/Duality.mp3',
            ),
            artist: Artist(
              name: 'Slipknot',
              image: 'assets/images/slipknot.jpg',
              description: 'Artist Description',
              songs: [],
            )),
        PlaylistSong(
            song: Song(
              title: 'Soft Spine',
              genre: 'Metal',
              audio: 'assets/songs/Soft Spine.mp3',
            ),
            artist: Artist(
              name: 'Spiritbox',
              image: 'assets/images/Spiritbox.jpg',
              description: '',
              songs: [],
            )),
        PlaylistSong(
            song: Song(
              title: 'Cellar Door',
              genre: 'Metal',
              audio: 'assets/songs/Cellar Door.mp3',
            ),
            artist: Artist(
              name: 'Spiritbox',
              image: 'assets/images/Spiritbox.jpg',
              description: 'Artist Description',
              songs: [],
            )),
      ],
    ),
  ];

  List<Playlist> get playlists => _playlists;

  void addPlaylist(Playlist playlist) {
    _playlists.add(playlist);
    notifyListeners();
  }

  void removePlaylist(Playlist playlist) {
    _playlists.remove(playlist);
    notifyListeners();
  }

  void addSongToPlaylist(Playlist playlist, PlaylistSong song) {
    playlist.songs.add(song);
    notifyListeners();
  }

  void removeSongFromPlaylist(Playlist playlist, PlaylistSong song) {
    playlist.songs.remove(song);
    notifyListeners();
  }
}
