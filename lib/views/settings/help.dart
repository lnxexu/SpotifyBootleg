import 'package:flutter/material.dart';

class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FAQs'),
      ),
      body: ListView(
        children: [
          _buildFaqItem(
            'What is Spotify?',
            'Spotify is a music streaming service that allows users to listen to millions of songs and podcasts from various artists and genres worldwide.',
          ),
          _buildFaqItem(
            'How does Spotify work?',
            'Spotify lets users stream music over the internet. You can create playlists, follow artists, and discover new music based on your listening habits.',
          ),
          _buildFaqItem(
            'Is Spotify free?',
            'Spotify offers a free tier with ads and limited features. Users can also subscribe to Spotify Premium for an ad-free experience and additional features, such as offline listening.',
          ),
          _buildFaqItem(
            'What are the benefits of Spotify Premium?',
            'Premium features include:\n- Ad-free listening\n- Offline downloads\n- Unlimited skips\n- Higher sound quality',
          ),
          _buildFaqItem("Can I use Spotify offline?",
              "Yes, but only with a Spotify Premium subscription. You can download songs, playlists, and podcasts to listen to without an internet connection."),
          _buildFaqItem("How do I create a playlist?",
              "Yes, but only with a Spotify Premium subscription. You can download songs, playlists, and podcasts to listen to without an internet connection."),
          _buildFaqItem("Can I share music or playlists with friends??",
              "Absolutely! You can share songs, albums, or playlists via social media or direct links. You can also collaborate on playlists with friends."),
          _buildFaqItem(
            'How do I create a playlist?',
            'To create a playlist, go to the "Your Library" tab, tap on "Playlists", and then tap on "Create Playlist".',
          ),
          _buildFaqItem(
            'How do I add songs to a playlist?',
            'To add songs to a playlist, find the song you want to add, tap on the three dots next to it, and select "Add to Playlist".',
          ),
          _buildFaqItem(
            'How do I download songs for offline listening?',
            'To download songs for offline listening, go to the playlist or album you want to download, and toggle the "Download" switch.',
          ),
          _buildFaqItem(
            'How do I share a song or playlist?',
            'To share a song or playlist, tap on the three dots next to it, and select "Share". You can then choose how you want to share it.',
          ),
          _buildFaqItem(
            'How do I find new music?',
            'To find new music, go to the "Browse" tab where you can explore new releases, charts, and genres.',
          ),
        ],
      ),
    );
  }

  Widget _buildFaqItem(String question, String answer) {
    return ExpansionTile(
      title: Text(question),
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(answer),
        ),
      ],
    );
  }
}
