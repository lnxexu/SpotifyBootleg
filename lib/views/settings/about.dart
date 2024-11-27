import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About Spotify  Bootleg'),
      ),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              'Spotify Bootleg',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Version 1.0.0',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Spotify Bootleg’s mission is to unlock the potential of human creativity by giving a million creative artists the opportunity to live off their art and billions of fans the opportunity '
              'to enjoy and be inspired by it. Spotify Bootleg’s platform revolutionized music listening forever when we launched in 2008. Our move into podcasting brought innovation and a new generation of'
              'listeners to the medium, and in 2022 we entered the next audio market primed for growth with the addition of audiobooks. \n\nToday, more listeners than ever can discover, manage and enjoy '
              'over 100 million tracks, 6 million podcasts titles, and 350,000 audiobooks a la carte on Spotify Bootleg. We are the world’s most popular audio streaming subscription service with more than 640 '
              'million users, including 252 million subscribers in more than 180 markets.\n',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            //note section
            Text(
              'This app is developed for educational purposes and is not affiliated with Spotify Bootleg in any way.',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            SizedBox(height: 16),
            Text(
              'Features:',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8),
            Text(
              '- Stream your favorite music',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Create and manage playlists',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              '- Discover new artists and albums',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Developed by Kobe J. Corpuz',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
