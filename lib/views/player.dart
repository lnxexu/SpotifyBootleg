import 'package:flutter/material.dart';

class PlayingSongPage extends StatelessWidget {
  final String songName;
  final String artistName;

  const PlayingSongPage(
      {super.key, required this.songName, required this.artistName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Now Playing'),
          centerTitle: true,
        ),
        body: Center(
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          const Text('Now Playing:', style: TextStyle(fontSize: 24)),
          const SizedBox(
            height: 20,
          ),
          Text('$songName by $artistName',
              style: const TextStyle(fontSize: 20)),
        ])));
  }
}
