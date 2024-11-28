import 'package:corpuz_ui/views/home.dart';
import 'package:flutter/material.dart';
import 'package:flutter_web_plugins/flutter_web_plugins.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(const Duration(milliseconds: 100));
  setUrlStrategy(PathUrlStrategy());
  runApp(const SpotifyBootleg());
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

  @override
  Widget build(BuildContext context) {
    final myTheme = ThemeData(
      brightness: Brightness.dark,
      primaryColor: Colors.green,
      textTheme: ThemeData.dark().textTheme.apply(
            bodyColor: Colors.white,
            fontFamily: 'Raleway',
            displayColor: Colors.white,
          ),
    );

    return MaterialApp(
      title: 'Spotify Bootleg',
      theme: myTheme,
      home: const HomeScreen(),
    );
  }
}
