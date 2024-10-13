import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Spatipy",
      theme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.light,
      ),
      darkTheme: ThemeData(
        primarySwatch: Colors.green,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: Colors.black,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.green,
          titleTextStyle: TextStyle(color: Colors.white),
        ),
        cardColor: Colors.grey[850],
        textTheme: const TextTheme(
          bodyLarge: TextStyle(color: Colors.white),
          bodyMedium: TextStyle(color: Colors.white70),
        ),
      ),
      themeMode: ThemeMode.system,
      home: const ArtistListPage(),
    );
  }
}

class ArtistListPage extends StatelessWidget {
  const ArtistListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // Sample list of artists
    List<String> artists = [
      'Slipknot',
      'System of the Down',
      'Deftones',
      'Paleface Swiss',
      'Killswitch Engage',
      'Korn',
      'Linkin Park',
      'Limp Bizkit',
      'Rage Against The Machine',
      'Thrown',
      'Avenged Sevenfold',
      'Megadeth'
    ];
    //arrange the list of artist
    artists.sort();

    // Sample songs for each artist
    Map<String, List<String>> artistSongs = {
      'Slipknot': [
        '(sic)',
        'Surfacing',
        'Psychosocial',
        'Duality',
        'Wait and Bleed'
      ],
      'System of the Down': [
        'ChopSeuy!',
        'Toxicity',
        'B.Y.O.B.',
        'Sugar',
        'Suite-Pee'
      ],
      'Deftones': [
        'Change (In the House of Flies)',
        'My Own Summer',
        'Sextape',
        'Please, Please, Please Let Me Get What I Want (Remastered)',
        'Lhabia'
      ],
      'Paleface Swiss': [
        'Please End Me',
        'Hatred',
        'Curse Us',
        'Lost in the Dark',
        'Pain'
      ],
      'Killswitch Engage': [
        'The End of Heartache',
        'My Curse',
        'In Due Time',
        'Rose of Sharyn',
        'Holy Diver'
      ],
      'Korn': [
        'Freak on a Leash',
        'Blind',
        'Good God',
        'Coming Undone',
        'Right Now'
      ],
      'Linkin Park': [
        'Numb',
        'In the End',
        'Crawling',
        "Don't Stay",
        "Given Up"
      ],
      'Limp Bizkit': [
        'Break Stuff',
        'Rollin',
        'My Way',
        'Faith',
        'Take A Look Around'
      ],
      'Rage Against The Machine': [
        'Killing In The Name',
        'Bulls On Parade',
        'Guerrilla Radio',
        'Bomb Track',
        'Know Your Enemy'
      ],
      'Avenged Sevenfold': [
        'Bat Country',
        'Hail to the King',
        'Natural Born Killer',
        'Nightmare',
        'Gunslinger'
      ],
      'Thrown': [
        'On the verge',
        'Bitter friend',
        'Bloodsucker',
        'Guilt',
        'Backfire'
      ],
      'Megadeth': [
        'Symphony of Destruction - Remastered 2012',
        'Holy Wars...The Punishment Due',
        'Tornado of Souls',
        'Peace Sells',
        'A Tout Le Monde',
      ]
    };

    Map<String, String> artistImages = {
      'Slipknot': 'assets/slipknot.jpg',
      'System of the Down': 'assets/soad.jpg',
      'Deftones': 'assets/deftones.jpg',
      'Paleface Swiss': 'assets/paleface.jpg',
      'Killswitch Engage': 'assets/KillswitchEngage.jpg',
      'Korn': 'assets/korn.jpg',
      'Linkin Park': 'assets/lp.jpg',
      'Limp Bizkit': 'assets/limp.jpg',
      'Rage Against The Machine': 'assets/ratm.jpg',
      'Avenged Sevenfold': 'assets/a7fold.jpg',
      'Thrown': 'assets/thrown.jpg',
      'Megadeth': 'assets/megadeth.jpg',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text("Metal Spatipy"),
        centerTitle: true,
        elevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Implement search functionality here
              showSearch(
                  context: context, delegate: ArtistSearchDelegate(artists));
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.green),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.playlist_play),
              title: const Text('Playlists'),
              onTap: () {
                // Navigate to playlists page
              },
            ),
            // Add more items as needed
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text("Recently Played",
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3, childAspectRatio: 0.8),
                itemCount: artists.length,
                itemBuilder: (context, index) {
                  String artist = artists[index];
                  return Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 8),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(artistImages[artist] ?? ''),
                          fit: BoxFit.cover),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Card(
                      color: Colors.transparent,
                      child: ListTile(
                        title: Text(artist,
                            style: const TextStyle(color: Colors.white)),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SongsPage(
                                  artistName: artist,
                                  songs: artistSongs[artist] ?? []),
                            ),
                          );
                        },
                        contentPadding: const EdgeInsets.all(8),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SongsPage extends StatelessWidget {
  final String artistName;
  final List<String> songs;

  const SongsPage({super.key, required this.artistName, required this.songs});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            AppBar(title: Text(artistName), centerTitle: true, elevation: 0),
        body: ListView.builder(
            itemCount: songs.length,
            itemBuilder: (context, index) => Card(
                  child: ListTile(
                    title: Text(songs[index]),
                    leading: const Icon(Icons.music_note),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PlayingSongPage(
                              songName: songs[index], artistName: artistName),
                        ),
                      );
                    },
                    contentPadding: const EdgeInsets.all(8),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                  ),
                )));
  }
}

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Now Playing:', style: TextStyle(fontSize: 24)),
              const SizedBox(
                height: 20,
              ),
              Text('$songName by $artistName',
                  style: const TextStyle(fontSize: 20)),
            ],
          ),
        ));
  }
}

class ArtistSearchDelegate extends SearchDelegate<String> {
  final List<String> artists;

  ArtistSearchDelegate(this.artists);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
          }),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          close(context, '');
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    final results = artists
        .where((artist) => artist.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(results[index]),
          onTap: () {
            // Navigate to the selected artist's page or do something else
            close(context, results[index]);
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    final suggestions = artists
        .where((artist) => artist.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return ListView.builder(
      itemCount: suggestions.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text(suggestions[index]),
          onTap: () {
            // Navigate to the selected artist's page or do something else
            close(context, suggestions[index]);
          },
        );
      },
    );
  }
}
