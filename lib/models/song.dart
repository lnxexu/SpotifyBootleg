import 'package:flutter/material.dart';

// Song Model
class Song {
  final String title;
  final String genre;
  final String audio;

  Song({
    required this.title,
    required this.genre,
    required this.audio,
  });
}

// Artist Model
class Artist {
  final String name;
  final String description;
  final String image;
  final List<Song> songs;

  Artist({
    required this.name,
    required this.description,
    required this.image,
    required this.songs,
  });
}

// Artist Provider
class ArtistProvider with ChangeNotifier {
  final List<Artist> _artists = [
    Artist(
      name: 'Slipknot',
      description:
          'Founded in 1995 in Des Moines, Iowa, Slipknot is one of the most incendiary, chaotic, and acclaimed heavy metal acts of all time. The Corey Taylor-fronted band has been nominated for numerous Grammy Awards and placed several albums atop the Billboard 200, including their iconic album "Iowa."',
      image: 'assets/images/slipknot.jpg',
      songs: [
        Song(
            title: '(sic)', genre: 'Nu Metal', audio: 'assets/songs/(sic).mp3'),
        Song(
            title: 'Surfacing',
            genre: 'Nu Metal',
            audio: 'assets/songs/Surfacing.mp3'),
        Song(
            title: 'Psychosocial',
            genre: 'Nu Metal',
            audio: 'assets/songs/Psychosocial.mp3'),
        Song(
            title: 'Duality',
            genre: 'Nu Metal',
            audio: 'assets/songs/Duality.mp3'),
        Song(
            title: 'Wait and Bleed',
            genre: 'Nu Metal',
            audio: 'assets/songs/Wait and Bleed.mp3'),
      ],
    ),
    Artist(
      name: 'System of the Down',
      description:
          'System of a Down (commonly referred to as System or abbreviated as SOAD) is an Armenian-American rock band formed in 1994 in Glendale, California. They have released five albums and have become a staple on mainstream rock radio. Their works have earned them four Grammy Award nominations, of which they won one, including their acclaimed album "Toxicity."',
      image: 'assets/images/soad.jpg',
      songs: [
        Song(
            title: 'Chop Suey!',
            genre: 'Alternative Metal',
            audio: 'assets/songs/Chop Suey!.mp3'),
        Song(
            title: 'Toxicity',
            genre: 'Alternative Metal',
            audio: 'assets/songs/Toxicity.mp3'),
        Song(
            title: 'B.Y.O.B.',
            genre: 'Alternative Metal',
            audio: 'assets/songs/B.Y.O.B..mp3'),
        Song(
            title: 'Sugar',
            genre: 'Alternative Metal',
            audio: 'assets/songs/Sugar.mp3'),
        Song(
            title: 'Suite-Pee',
            genre: 'Alternative Metal',
            audio: 'assets/songs/Suite-Pee.mp3'),
      ],
    ),
    Artist(
      name: 'Deftones',
      description:
          'Deftones is an American alternative metal band from Sacramento, California. Formed in 1988, the band was founded by Chino Moreno (lead vocals, rhythm guitar), Stephen Carpenter (lead guitar), Abe Cunningham (drums), and Dominic Garcia (bass). The band has released eight albums since their inception, with "White Pony" being particularly influential.',
      image: 'assets/images/deftones.jpg',
      songs: [
        Song(
          title: 'Kimdracula',
          genre: 'Alternative Metal',
          audio: 'assets/songs/Kimdracula.mp3',
        ),
        Song(
          title: 'My Own Summer (Shove It)',
          genre: 'Alternative Metal',
          audio: 'assets/songs/My Own Summer (Shove It).mp3',
        ),
        Song(
          title: 'Sextape',
          genre: 'Alternative Metal',
          audio: 'assets/songs/Sextape.mp3',
        ),
        Song(
          title: 'Please, Please, Please Let Me Get What I Want (Remastered)',
          genre: 'Alternative Metal',
          audio:
              'assets/songs/Please, Please, Please Let Me Get What I Want (Remastered).mp3',
        ),
        Song(
          title: 'Lhabia',
          genre: 'Alternative Metal',
          audio: 'assets/songs/Lhabia.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Paleface Swiss',
      description:
          'Paleface Swiss is a deathcore band formed in 2017 in Zurich. It was founded by vocalist Marc Zellweger and drummer Colin Hammond, who met through beatdown hardcore gigs. They formed Paleface Swiss out of love for extreme hardcore music.',
      image: 'assets/images/paleface.jpg',
      songs: [
        Song(
          title: 'Please End Me',
          genre: 'Deathcore',
          audio: 'assets/songs/Please End Me.mp3',
        ),
        Song(
          title: 'Hatred',
          genre: 'Deathcore',
          audio: 'assets/songs/Hatred.mp3',
        ),
        Song(
          title: 'Curse Us',
          genre: 'Deathcore',
          audio: 'assets/songs/Curse Us.mp3',
        ),
        Song(
          title: 'Lost in the Dark',
          genre: 'Deathcore',
          audio: 'assets/songs/Lost in the Dark.mp3',
        ),
        Song(
          title: 'Pain',
          genre: 'Deathcore',
          audio: 'assets/songs/Pain.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Killswitch Engage',
      description:
          'Killswitch Engage is an American metalcore band from Westfield, Massachusetts, formed in 1999 after the disbanding of Overcast and Aftershock. Their current lineup includes vocalist Jesse Leach and guitarists Joel Stroetzel and Adam Dutkiewicz. They are known for their album "Alive or Just Breathing," which helped define the metalcore genre.',
      image: 'assets/images/KillswitchEngage.jpg',
      songs: [
        Song(
          title: 'The End of Heartache',
          genre: 'Metalcore',
          audio: 'assets/songs/The End of Heartache.mp3',
        ),
        Song(
          title: 'My Curse',
          genre: 'Metalcore',
          audio: 'assets/songs/My Curse.mp3',
        ),
        Song(
          title: 'In Due Time',
          genre: 'Metalcore',
          audio: 'assets/songs/In Due Time.mp3',
        ),
        Song(
          title: 'Rose of Sharyn',
          genre: 'Metalcore',
          audio: 'assets/songs/Rose of Sharyn.mp3',
        ),
        Song(
          title: 'Holy Diver',
          genre: 'Metalcore',
          audio: 'assets/songs/Holy Diver.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Korn',
      description:
          'Korn is an American nu metal band from Bakersfield, California, formed in 1993. As of 2012, Korn had sold around 35 million copies worldwide. Twelve of the band\'s official releases have peaked in the top ten of the Billboard 200, eight of which have peaked in the top five. Their self-titled debut album is considered groundbreaking.',
      image: 'assets/images/korn.jpg',
      songs: [
        Song(
          title: 'Freak on a Leash',
          genre: 'Nu Metal',
          audio: 'assets/songs/Freak on a Leash.mp3',
        ),
        Song(
          title: 'Blind',
          genre: 'Nu Metal',
          audio: 'assets/songs/Blind.mp3',
        ),
        Song(
          title: 'Good God',
          genre: 'Nu Metal',
          audio: 'assets/songs/Good God.mp3',
        ),
        Song(
          title: 'Coming Undone',
          genre: 'Nu Metal',
          audio: 'assets/songs/Coming Undone.mp3',
        ),
        Song(
          title: 'Right Now',
          genre: 'Nu Metal',
          audio: 'assets/songs/Right Now.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Linkin Park',
      description:
          'Linkin Park is an American rock band formed in Agoura Hills, California, in 1996. The band\'s current lineup consists of vocalist/rhythm guitarist/keyboardist Mike Shinoda and lead guitarist Brad Delson. Their debut album "Hybrid Theory" became one of the best-selling albums of the early 2000s.',
      image: 'assets/images/lp.jpg',
      songs: [
        Song(
          title: 'Numb',
          genre: 'Nu Metal',
          audio: 'assets/songs/Numb.mp3',
        ),
        Song(
          title: 'In the End',
          genre: 'Nu Metal',
          audio: 'assets/songs/In the End.mp3',
        ),
        Song(
          title: 'Crawling',
          genre: 'Nu Metal',
          audio: 'assets/songs/Crawling.mp3',
        ),
        Song(
          title: 'Don\'t Stay',
          genre: 'Nu Metal',
          audio: 'assets/songs/Don\'t Stay.mp3',
        ),
        Song(
          title: 'Given Up',
          genre: 'Nu Metal',
          audio: 'assets/songs/Given Up.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Limp Bizkit',
      description:
          'Limp Bizkit is an American nu metal band from Jacksonville, Florida. Its lineup consists of lead vocalist Fred Durst and guitarist Wes Borland. The band\'s musical style is marked by Durst\'s angry vocal delivery and Borland\'s sonic experimentation. Their album "Chocolate Starfish and the Hot Dog Flavored Water" was a commercial success.',
      image: 'assets/images/limp.jpg',
      songs: [
        Song(
          title: 'Break Stuff',
          genre: 'Nu Metal',
          audio: 'assets/songs/Break Stuff.mp3',
        ),
        Song(
          title: 'Rollin\' (Air Raid Vehicle)',
          genre: 'Nu Metal',
          audio: 'assets/songs/Rollin\' (Air Raid Vehicle).mp3',
        ),
        Song(
          title: 'My Way',
          genre: 'Nu Metal',
          audio: 'assets/songs/My Way.mp3',
        ),
        Song(
          title: 'Faith',
          genre: 'Nu Metal',
          audio: 'assets/songs/Faith.mp3',
        ),
        Song(
          title: 'Take A Look Around',
          genre: 'Nu Metal',
          audio: 'assets/songs/Take A Look Around.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Rage Against The Machine',
      description:
          'Rage Against the Machine, sometimes known as RATM or Rage, is a rock band from Los Angeles, California. They are known for mixing funk, hip-hop, metal, and rock music while expressing left-wing political opinions. Their self-titled debut album remains influential.',
      image: 'assets/images/ratm.jpg',
      songs: [
        Song(
          title: 'Killing In The Name',
          genre: 'Rap Metal',
          audio: 'assets/songs/Killing In The Name.mp3',
        ),
        Song(
          title: 'Bulls On Parade',
          genre: 'Rap Metal',
          audio: 'assets/songs/Bulls On Parade.mp3',
        ),
        Song(
          title: 'Guerrilla Radio',
          genre: 'Rap Metal',
          audio: 'assets/songs/Guerrilla Radio.mp3',
        ),
        Song(
          title: 'Bombtrack',
          genre: 'Rap Metal',
          audio: 'assets/songs/Bombtrack.mp3',
        ),
        Song(
          title: 'Know Your Enemy',
          genre: 'Rap Metal',
          audio: 'assets/songs/Know Your Enemy.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Avenged Sevenfold',
      description:
          'Avenged Sevenfold is known for their diverse rock sound and dramatic imagery in album covers and merchandise. They emerged with a metalcore sound on their debut album "Sounding the Seventh Trumpet" and continued this sound through their second album "Waking the Fallen."',
      image: 'assets/images/a7fold.jpg',
      songs: [
        Song(
          title: 'Bat Country',
          genre: 'Heavy Metal',
          audio: 'assets/songs/Bat Country.mp3',
        ),
        Song(
          title: 'Hail to the King',
          genre: 'Heavy Metal',
          audio: 'assets/songs/Hail to the King.mp3',
        ),
        Song(
          title: 'Natural Born Killer',
          genre: 'Heavy Metal',
          audio: 'assets/songs/Natural Born Killer.mp3',
        ),
        Song(
          title: 'Nightmare',
          genre: 'Heavy Metal',
          audio: 'assets/songs/Nightmare.mp3',
        ),
        Song(
          title: 'Gunslinger',
          genre: 'Heavy Metal',
          audio: 'assets/songs/Gunslinger.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Megadeth',
      description:
          'Megadeth is an American heavy metal band whose signature sound combines complex musical arrangements with aggressive vocals and fast tempos. They rose to prominence in the 1980s as one of the “Big Four” thrash metal bands along with Metallica, Slayer, and Anthrax. Their album "Rust in Peace" is considered a classic.',
      image: 'assets/images/Megadeth.jpg',
      songs: [
        Song(
          title: 'Symphony of Destruction - Remastered 2012',
          genre: 'Thrash Metal',
          audio: 'assets/songs/Symphony of Destruction - Remastered 2012.mp3',
        ),
        Song(
          title: 'Holy Wars...The Punishment Due',
          genre: 'Thrash Metal',
          audio: 'assets/songs/Holy Wars...The Punishment Due.mp3',
        ),
        Song(
          title: 'Tornado of Souls',
          genre: 'Thrash Metal',
          audio: 'assets/songs/Tornado of Souls.mp3',
        ),
        Song(
          title: 'Peace Sells',
          genre: 'Thrash Metal',
          audio: 'assets/songs/Peace Sells.mp3',
        ),
        Song(
          title: 'A Tout Le Monde',
          genre: 'Thrash Metal',
          audio: 'assets/songs/A Tout Le Monde.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Bullet For My Valentine',
      description:
          'Bullet for My Valentine formed in Bridgend, Wales in 1998. The current lineup includes Matt Tuck (lead vocals), Michael Paget (lead guitar), Jamie Mathias (bass), and Jason Bowld (drums). Their early work includes the acclaimed album "The Poison," which helped define modern metalcore.',
      image: 'assets/images/bfmv.jpg',
      songs: [
        Song(
          title: 'Tears Don\'t Fall',
          genre: 'Metalcore',
          audio: 'assets/songs/Tears Don\'t Fall.mp3',
        ),
        Song(
          title: 'The Last Fight',
          genre: 'Metalcore',
          audio: 'assets/songs/The Last Fight.mp3',
        ),
        Song(
          title: 'Hand of Blood',
          genre: 'Metalcore',
          audio: 'assets/songs/Hand of Blood.mp3',
        ),
        Song(
          title: 'All These Things I Hate (Revolve Around Me)',
          genre: 'Metalcore',
          audio: 'assets/songs/All These Things I Hate (Revolve Around Me).mp3',
        ),
        Song(
          title: '4 words (To Choke Upon)',
          genre: 'Metalcore',
          audio: 'assets/songs/4 words (To Choke Upon).mp3',
        ),
      ],
    ),
    Artist(
      name: 'I Prevail',
      description:
          'I Prevail blends post-hardcore with elements from various genres including pop punk and rap metal. Their album "Lifelines" features a mix of melodic hooks and heavy breakdowns that appeal to a broad audience.',
      image: 'assets/images/iPrevail.jpg',
      songs: [
        Song(
          title: 'Bow Down',
          genre: 'Metalcore',
          audio: 'assets/songs/Bow Down.mp3',
        ),
        Song(
          title: 'Gasoline',
          genre: 'Metalcore',
          audio: 'assets/songs/Gasoline.mp3',
        ),
        Song(
          title: 'Hurricane',
          genre: 'Metalcore',
          audio: 'assets/songs/Hurricane.mp3',
        ),
        Song(
          title: 'Self-Destruction',
          genre: 'Metalcore',
          audio: 'assets/songs/Self-Destruction.mp3',
        ),
        Song(
          title: 'Scars',
          genre: 'Metalcore',
          audio: 'assets/songs/Scars.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Knocked Loose',
      description:
          'Knocked Loose has been described as metalcore, hardcore punk, and beatdown hardcore. Their debut album "Laugh Tracks" was praised for its heavy sound reminiscent of "Comeback Kid" mixed with Slayer riffs.',
      image: 'assets/images/kl.jpg',
      songs: [
        Song(
          title: 'Suffocate(ft. Poppy)',
          genre: 'Hardcore Punk',
          audio: 'assets/songs/Suffocate(ft. Poppy).mp3',
        ),
        Song(
          title: 'Slaughterhouse(ft. Brain Garis)',
          genre: 'Hardcore Punk',
          audio: 'assets/songs/Slaughterhouse(ft. Brain Garis).mp3',
        ),
        Song(
          title: 'Blinding Faith',
          genre: 'Hardcore Punk',
          audio: 'assets/songs/Blinding Faith.mp3',
        ),
        Song(
          title: 'Slaughterhouse 2(ft. Motionless in White)',
          genre: 'Hardcore Punk',
          audio: 'assets/songs/Slaughterhouse 2(ft. Motionless in White).mp3',
        ),
        Song(
          title: 'Counting Worms',
          genre: 'Hardcore Punk',
          audio: 'assets/songs/Counting Worms.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Spiritbox',
      description:
          'Spiritbox is a Canadian heavy metal band originally from Victoria, British Columbia. Established by guitarist Mike Stringer and vocalist Courtney LaPlante in October 2017, they gained popularity with their debut album "Eternal Blue," which showcases their unique blend of genres.',
      image: 'assets/images/Spiritbox.jpg',
      songs: [
        Song(
          title: 'Soft Spine',
          genre: 'Metalcore',
          audio: 'assets/songs/Soft Spine.mp3',
        ),
        Song(
          title: 'Holy Roller',
          genre: 'Metalcore',
          audio: 'assets/songs/Holy Roller.mp3',
        ),
        Song(
          title: 'Angel Eyes',
          genre: 'Metalcore',
          audio: 'assets/songs/Angel Eyes.mp3',
        ),
        Song(
          title: 'Cellar Door',
          genre: 'Metalcore',
          audio: 'assets/songs/Cellar Door.mp3',
        ),
        Song(
          title: 'Jaded',
          genre: 'Metalcore',
          audio: 'assets/songs/Jaded.mp3',
        ),
      ],
    ),
    Artist(
      name: '156/Silence',
      description:
          '156/Silence creates soundtracks for the pushed aside and marginalized. Their music resonates with outsiders through frenetic energy and ambition. They are known for their powerful performances that challenge societal norms.',
      image: 'assets/images/156-Silence.jpg',
      songs: [
        Song(
          title: 'Target Acquired',
          genre: 'Metalcore',
          audio: '',
        ),
        Song(
          title: 'Character Development',
          genre: 'Metalcore',
          audio: '',
        ),
        Song(
          title: 'Better Written Villain',
          genre: 'Metalcore',
          audio: '',
        ),
        Song(
          title: 'Wants I Need',
          genre: 'Metalcore',
          audio: '',
        ),
        Song(
          title: 'Product Placement',
          genre: 'Metalcore',
          audio: '',
        ),
      ],
    ),
    Artist(
      name: 'Bring Me The Horizon',
      description:
          'Bring Me the Horizon is a British rock band from Sheffield, Yorkshire, England. The band was formed in 2004 from members of other bands within their local area. They play a style of music that combines rock and metalcore, but they have taken on a more rock style with their latest album.',
      image: 'assets/images/bmth.jpg',
      songs: [
        Song(
          title: 'Kingslayer (ft. BABYMETAL)',
          genre: 'Metalcore',
          audio: 'assets/songs/Kingslayer (ft. BABYMETAL).mp3',
        ),
        Song(
          title: 'Can You feel My Heart',
          genre: 'Metalcore',
          audio: 'assets/songs/Can You feel My Heart.mp3',
        ),
        Song(
          title: 'Throne',
          genre: 'Metalcore',
          audio: 'assets/songs/Throne.mp3',
        ),
        Song(
          title: 'DArkSide',
          genre: 'Metalcore',
          audio: 'assets/songs/DArkSide.mp3',
        ),
        Song(
          title: 'Kool-Aid',
          genre: 'Metalcore',
          audio: 'assets/songs/Kool-Aid.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Nirvana',
      description:
          'Nirvana was an American rock band formed in Aberdeen, Washington, in 1987. Founded by lead singer and guitarist Kurt Cobain and bassist Krist Novoselic, the band went through a succession of drummers, most notably Chad Channing, before recruiting Dave Grohl in 1990.',
      image: 'assets/images/nirvana.jpg',
      songs: [
        Song(
          title: 'Very Ape',
          genre: 'Grunge',
          audio: 'assets/songs/Very Ape.mp3',
        ),
        Song(
          title: 'Lithium',
          genre: 'Grunge',
          audio: 'assets/songs/Lithium.mp3',
        ),
        Song(
          title: 'Smells Like Teen Spirit',
          genre: 'Grunge',
          audio: 'assets/songs/Smells Like Teen Spirit.mp3',
        ),
        Song(
          title: 'About A Girl',
          genre: 'Grunge',
          audio: 'assets/songs/About A Girl.mp3',
        ),
        Song(
          title: 'In Bloom',
          genre: 'Grunge',
          audio: 'assets/songs/In Bloom.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Nickelback',
      description:
          'Nickelback is a Canadian rock band from Hanna, Alberta, formed in 1995 by Chad Kroeger, Mike Kroeger, Ryan Peake and then-drummer Brandon Kroeger. While largely a rock band, the group has also experimented with various other musical styles such as pop and country, aside from their hard rock and post-grunge base.',
      image: 'assets/images/nickelback.jpg',
      songs: [
        Song(
          title: 'Far Away',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Far Away.mp3',
        ),
        Song(
          title: 'How You Remind Me',
          genre: 'Post-Grunge',
          audio: 'assets/songs/How You Remind Me.mp3',
        ),
        Song(
          title: 'Burn It to the Ground',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Burn It to the Ground.mp3',
        ),
        Song(
          title: 'Photograph',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Photograph.mp3',
        ),
        Song(
          title: 'Rockstar',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Rockstar.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Creed',
      description:
          'Creed has been described as post-grunge, hard rock, alternative rock, and alternative metal, and also as Christian rock, grunge, nu metal, and heavy metal. Stapp\'s influences include Otis Redding, Donny Hathaway, Def Leppard, U2, The Doors, and Led Zeppelin.',
      image: 'assets/images/creed.jpg',
      songs: [
        Song(
          title: 'Higher',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Higher.mp3',
        ),
        Song(
          title: 'One Last Breath',
          genre: 'Post-Grunge',
          audio: 'assets/songs/One Last Breath.mp3',
        ),
        Song(
          title: 'With Arms Wide Open',
          genre: 'Post-Grunge',
          audio: 'assets/songs/With Arms Wide Open.mp3',
        ),
        Song(
          title: 'My Own Prison',
          genre: 'Post-Grunge',
          audio: 'assets/songs/My Own Prison.mp3',
        ),
        Song(
          title: 'My Sacrifice',
          genre: 'Post-Grunge',
          audio: 'assets/songs/My Sacrifice.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Drowning Pool',
      description:
          'Drowning Pool is an American rock band formed in Dallas, Texas, in 1996. The band was named after the 1975 film The Drowning Pool. Since its formation, the band has consisted of guitarist C.J. Pierce, drummer Mike Luce and bassist Stevie Benton, as well as a revolving cast of vocalists.',
      image: 'assets/images/dp.jpg',
      songs: [
        Song(
          title: 'Bodies',
          genre: 'Nu Metal',
          audio: 'assets/songs/Bodies.mp3',
        ),
        Song(
          title: 'Tear Away',
          genre: 'Nu Metal',
          audio: 'assets/songs/Tear Away.mp3',
        ),
        Song(
          title: 'Step Up',
          genre: 'Nu Metal',
          audio: 'assets/songs/Step Up.mp3',
        ),
        Song(
          title: 'Mute',
          genre: 'Nu Metal',
          audio: 'assets/songs/Mute.mp3',
        ),
        Song(
          title: 'Sinner',
          genre: 'Nu Metal',
          audio: 'assets/songs/Sinner.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Foo Fighters',
      description:
          'Foo Fighters, American alternative rock band, one of the world\'s most popular rock bands of the 21st century. Foo Fighters appeal to a wide audience, owing to their likable blend of heavy guitars and arena-ready anthems, which make for exciting live performances.',
      image: 'assets/images/ff.jpg',
      songs: [
        Song(
          title: 'My Hero',
          genre: 'Alternative Rock',
          audio: 'assets/songs/My Hero.mp3',
        ),
        Song(
          title: 'Learn To Fly',
          genre: 'Alternative Rock',
          audio: 'assets/songs/Learn To Fly.mp3',
        ),
        Song(
          title: 'Everlong',
          genre: 'Alternative Rock',
          audio: 'assets/songs/Everlong.mp3',
        ),
        Song(
          title: 'Best of You',
          genre: 'Alternative Rock',
          audio: 'assets/songs/Best of You.mp3',
        ),
        Song(
          title: 'All My Life',
          genre: 'Alternative Rock',
          audio: 'assets/songs/All My Life.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Breaking Benjamin',
      description:
          'Breaking Benjamin is an American rock band from Wilkes-Barre, Pennsylvania, consisting of Benjamin Burnley, Aaron Fink, Mark Klepaski and Chad Szeliga. The band has released four albums to date. Their music is most often classified as alternative rock, and post-grunge.',
      image: 'assets/images/bb.jpg',
      songs: [
        Song(
          title: 'Blood',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Blood.mp3',
        ),
        Song(
          title: 'The Diary of Jane',
          genre: 'Post-Grunge',
          audio: 'assets/songs/The Diary of Jane.mp3',
        ),
        Song(
          title: 'Dance With The Devil',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Dance With The Devil.mp3',
        ),
        Song(
          title: 'Breath',
          genre: 'Post-Grunge',
          audio: 'assets/songs/Breath.mp3',
        ),
        Song(
          title: 'So Cold - Remix',
          genre: 'Post-Grunge',
          audio: 'assets/songs/So Cold - Remix.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Disturbed',
      description:
          'Disturbed is an American hard rock band from Chicago, Illinois, formed in 1994. The band includes vocalist David Draiman, bassist John Moyer, guitarist/keyboardist Dan Donegan, and drummer Mike Wengren. Former band members are vocalist Erich Awalt and bassist Steve Kmak.',
      image: 'assets/images/disturbed.jpg',
      songs: [
        Song(
          title: 'Indestructable',
          genre: 'Nu Metal',
          audio: 'assets/songs/Indestructable.mp3',
        ),
        Song(
          title: 'Down With The Sickness',
          genre: 'Nu Metal',
          audio: 'assets/songs/Down With The Sickness.mp3',
        ),
        Song(
          title: 'Stricken',
          genre: 'Nu Metal',
          audio: 'assets/songs/Stricken.mp3',
        ),
        Song(
          title: 'Ten Thousand Fists',
          genre: 'Nu Metal',
          audio: 'assets/songs/Ten Thousand Fists.mp3',
        ),
        Song(
          title: 'Decadence',
          genre: 'Nu Metal',
          audio: 'assets/songs/Decadence.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Gorillaz',
      description:
          'Gorillaz are an animated British rock band. The band was invented by Damon Albarn, a member of the band Blur, and Jamie Hewlett, who has worked on the comic book series Tank Girl. Even though the band members are fictional, they have released a large number of albums and music videos.',
      image: 'assets/images/gorillaz.jpg',
      songs: [
        Song(
          title: 'Feel Good Inc.',
          genre: 'Alternative Rock',
          audio: 'assets/songs/Feel Good Inc..mp3',
        ),
        Song(
          title: 'Clint Eastwood',
          genre: 'Alternative Rock',
          audio: 'assets/songs/Clint Eastwood.mp3',
        ),
        Song(
          title: 'DARE',
          genre: 'Alternative Rock',
          audio: 'assets/songs/DARE.mp3',
        ),
        Song(
          title: 'On Melancholy Hill',
          genre: 'Alternative Rock',
          audio: 'assets/songs/On Melancholy Hill.mp3',
        ),
        Song(
          title: '19-2000',
          genre: 'Alternative Rock',
          audio: 'assets/songs/19-2000.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Sticky Fingers',
      description:
          'Sticky Fingers is a reggae fusion/indie rock band formed in 2008 in Sydney, Australia. The band consists of Dylan Frost (lead vocals/guitar), Paddy Cornwall (bass/vocals), Seamus Coyle (lead guitar), Beaker Best (drums/percussion) and Freddy Crabs (keys/synth).',
      image: 'assets/images/st.jpg',
      songs: [
        Song(
          title: 'How To Fly',
          genre: 'Indie Rock',
          audio: 'assets/songs/How To Fly.mp3',
        ),
        Song(
          title: 'Australia Street',
          genre: 'Indie Rock',
          audio: 'assets/songs/Australia Street.mp3',
        ),
        Song(
          title: 'Gold Snafu',
          genre: 'Reggae',
          audio: 'assets/songs/Gold Snafu.mp3',
        ),
        Song(
          title: 'These Girls',
          genre: 'Indie Rock',
          audio: 'assets/songs/These Girls.mp3',
        ),
        Song(
          title: 'Cool & Calm',
          genre: 'Reggae',
          audio: 'assets/songs/Cool & Calm.mp3',
        ),
      ],
    ),
    Artist(
      name: 'Thrown',
      description:
          'Thrown (stylized in lowercase) is a Swedish hardcore punk and metalcore band formed in 2019. They are signed to Arising Empire and consist of vocalist Marcus Lundqvist and guitarist Johan Liljeblad. They are gaining recognition for their energetic performances.',
      image: 'assets/images/thrown.jpg',
      songs: [
        Song(
          title: 'on the verge',
          genre: 'Metalcore',
          audio: 'assets/songs/on the verge.mp3',
        ),
        Song(
          title: 'bitter friend',
          genre: 'Metalcore',
          audio: 'assets/songs/bitter friend.mp3',
        ),
        Song(
          title: 'bloodsucker',
          genre: 'Metalcore',
          audio: 'assets/songs/bloodsucker.mp3',
        ),
        Song(
          title: 'guilt',
          genre: 'Metalcore',
          audio: 'assets/songs/guilt.mp3',
        ),
        Song(
          title: 'fast forward',
          genre: 'Metalcore',
          audio: 'assets/songs/fast forward.mp3',
        ),
      ],
    ),
  ];

  List<Artist> get artists => _artists;

  Artist getArtistByName(String name) {
    return _artists.firstWhere((artist) => artist.name == name);
  }

  // Other methods and properties

  Artist getArtistBySong(Song song) {
    return artists.firstWhere(
      (artist) => artist.songs.contains(song),
      orElse: () =>
          Artist(name: 'Unknown', description: '', image: '', songs: []),
    );
  }
}
