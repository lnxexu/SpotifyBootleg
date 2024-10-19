import 'package:flutter/material.dart';
import 'views/home.dart';

void main() {
  runApp(const SpotifyBootleg());
}

class SpotifyBootleg extends StatelessWidget {
  const SpotifyBootleg({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify UI Clone',
      theme: ThemeData.dark(),
      home: const HomeScreen(),
    );
  }
}
