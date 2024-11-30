import 'package:corpuz_ui/views/home.dart';
import 'package:corpuz_ui/views/login.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:corpuz_ui/models/song.dart';
import 'package:corpuz_ui/models/playlist.dart';
import 'package:corpuz_ui/views/artist_page.dart';
import 'package:corpuz_ui/views/playlist_page.dart';
import 'package:corpuz_ui/views/player.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PlaylistProvider()),
        ChangeNotifierProvider(create: (_) => AudioProvider()),
        ChangeNotifierProvider(create: (_) => ArtistProvider()),
      ],
      child: const SpotifyBootleg(),
    ),
  );
}

class SpotifyBootleg extends StatefulWidget {
  const SpotifyBootleg({super.key});

  @override
  _SpotifyBootlegState createState() => _SpotifyBootlegState();
}

class _SpotifyBootlegState extends State<SpotifyBootleg>
    with WidgetsBindingObserver {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  var myTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          fontFamily: 'Raleway',
          displayColor: Colors.white,
        ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Bootleg',
      theme: myTheme,
      home: const LoginPage(),
      routes: {
        '/home': (context) => const HomeScreen(),
        '/artist': (context) => ArtistPage(artistName: 'Artist Name'),
        '/playlist': (context) => YourPlaylist(),
        '/player': (context) => Player(
              songName: '',
              artistName: '',
              artistImage: '',
              localFilePath: '',
            ), // Add Player route
      },
    );
  }
}
