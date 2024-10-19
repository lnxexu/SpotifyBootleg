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

    Map<String, String> artistDescription = {
      'Slipknot':
          'Founded in 1995 in Des Moines, Iowa, Slipknot is one of the most incendiary, chaotic and acclaimed heavy metal acts of all time. The Corey Taylor-fronted band has been nominated for numerous Grammy Awards and placed several albums atop the Billboard 200.',
      'System of the Down':
          'System of a Down (commonly referred to as System or abbreviated as SOAD) is an Armenian-American rock band, formed in 1994 in Glendale, California. They have released five albums and have become a staple on mainstream rock radio. Their works have earned them four Grammy Award nominations, of which they won one.',
      'Deftones':
          'Deftones is an American alternative metal band from Sacramento, California. Formed in 1988, the band was founded by Chino Moreno (lead vocals, rhythm guitar), Stephen Carpenter (lead guitar), Abe Cunningham (drums) and Dominic Garcia (bass). The band have released eight albums since their inception.',
      'Paleface Swiss':
          'Paleface Swiss is a deathcore band formed in 2017 in Zurich. It was founded by vocalist Marc Zellweger and drummer Colin Hammond, who met through beatdown hardcore gigs and together out of love for extreme hardcore music decided to form Paleface Swiss.',
      'Killswitch Engage':
          'Killswitch Engage is an American metalcore band from Westfield, Massachusetts, formed in 1999 after the disbanding of Overcast and Aftershock. Killswitch Engage\'s current lineup consists of vocalist Jesse Leach, guitarists Joel Stroetzel and Adam Dutkiewicz, bassist Mike D\'Antonio, and drummer Justin Foley.',
      'Korn':
          'Korn is an American nu metal band from Bakersfield, California, formed in 1993. As of 2012, Korn had sold around 35 million copies worldwide. Twelve of the band\'s official releases have peaked in the top ten of the Billboard 200, eight of which have peaked in the top five.',
      'Linkin Park':
          'Linkin Park is an American rock band formed in Agoura Hills, California, in 1996. The band\'s current lineup consists of vocalist/rhythm guitarist/keyboardist Mike Shinoda, lead guitarist Brad Delson, DJ/turntablist Joe Hahn, bassist Dave Farrell, co-lead vocalist Emily Armstrong, and drummer Colin Brittain.',
      'Limp Bizkit':
          'Limp Bizkit is an American nu metal band from Jacksonville, Florida. Its lineup consists of lead vocalist Fred Durst, drummer John Otto, guitarist Wes Borland, turntablist DJ Lethal and bassist Sam Rivers. The band\'s musical style is marked by Durst\'s angry vocal delivery and Borland\'s sonic experimentation.',
      'Rage Against The Machine':
          'Rage Against the Machine, sometimes known as RATM or Rage, is a rock band from Los Angeles, California. Rage Against the Machine are known for mixing funk, hip-hop, metal and rock music. They are also known for their left-wing political opinions. The band members have been the same since they started in 1991.',
      'Avenged Sevenfold':
          'Avenged Sevenfold are known for their diverse rock sound and dramatic imagery in album covers and merchandise. The band emerged with a metalcore sound on their debut album Sounding the Seventh Trumpet and largely continued this sound through their second album Waking the Fallen.',
      'Thrown':
          'Thrown (stylized in lowercase) is a Swedish hardcore punk and metalcore band formed in 2019, and are signed to Arising Empire. The group consists of vocalist Marcus Lundqvist, guitarists Johan Liljeblad and Andreas Malm, and drummer/producer Buster Odeholm (Humanity\'s Last Breath and Vildhjarta).',
      'Megadeth':
          'Megadeth, American heavy metal band whose signature sound combines complex musical arrangements, sharp instrumental skills, aggressive vocals, and fast tempos, lending its music the name “speed metal.” The group rose to prominence in the 1980s as one of the “Big Four” thrash metal bands along with Metallica, Slayer, and Anthrax.'
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
                                songs: artistSongs[artist] ?? [],
                                artistImage: artistImages[artist] ?? '',
                                artistDescription:
                                    artistDescription[artist] ?? '',
                                // Add artist description here
                              ),
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
  final String artistImage; // Add a field for the artist's image
  final String artistDescription; // Add a field for the artist's description

  const SongsPage(
      {super.key,
      required this.artistName,
      required this.songs,
      required this.artistImage, // Required parameter
      required this.artistDescription // Required parameter
      });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(artistName), centerTitle: true, elevation: 0),
      body: Column(
        children: [
          // Add an image and description at the top
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                Image.asset(artistImage,
                    height: 200, fit: BoxFit.cover), // Display artist image
                const SizedBox(height: 8),
                Text(
                  artistDescription,
                  style: const TextStyle(
                      fontSize: 16, fontWeight: FontWeight.w400),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                          songName: songs[index],
                          artistName: artistName,
                        ),
                      ),
                    );
                  },
                  contentPadding: const EdgeInsets.all(8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
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
              close(context, results[index]);
            },
          );
        });
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
              close(context, suggestions[index]);
            },
          );
        });
  }
}
