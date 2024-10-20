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
  'Linkin Park': ['Numb', 'In the End', 'Crawling', "Don't Stay", "Given Up"],
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
  ],
  'Bullet For My Valentine': [
    'Tears Don\'t Fall',
    'Your Betrayal',
    'Hand of Blood',
    'All These Things I Hate (Revolve Around Me)',
    'Waking the Demon',
  ],
  'I Prevail': [
    'Bow Down',
    'Gasoline',
    'The Hurricane',
    'Self-Destruction',
    'Scars',
  ],
  'Knocked Loose': [
    'Suffocate(ft. Poppy)',
    'Slaughterhouse(ft. Brain Garis)',
    'Blinding Faith',
    'Slaughterhouse 2(ft. Motionless in White)',
    'Counting Worms',
  ],
  'Spiritbox': [
    'Soft Spine',
    'Holly Roller',
    'Circle with Me',
    'Jaded',
    'Blessed Be'
  ],
  '156/Silence': [
    'Target Acquired',
    'Character Development',
    'Better Written Villain',
    'Wants I Need',
    'Product Placement'
  ]
};

List<String> getAllArtists() {
  return artistSongs.keys.toList();
}

List<String> getSongsByArtist(String artist) {
  return artistSongs[artist] ?? [];
}
