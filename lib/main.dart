import 'package:flutter/material.dart';
import 'views/home.dart';

void main() {
  runApp(const SpotifyBootleg());
}

class SpotifyBootleg extends StatefulWidget {
  const SpotifyBootleg({super.key});

  @override
  // ignore: library_private_types_in_public_api
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

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Handle app lifecycle changes here if needed
    print('App state changed to: $state');
  }

  var myTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: Colors.green,
    textTheme: ThemeData.dark().textTheme.apply(
          bodyColor: Colors.white,
          fontFamily: 'IntegralCF', // Ensure no spaces here
          displayColor: Colors.white,
        ),
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spotify Bootleg',
      theme: myTheme,
      home: const HomeScreen(),
    );
  }
}
