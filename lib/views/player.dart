import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:corpuz_ui/models/playlist.dart';

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds";
}

class AudioProvider extends ChangeNotifier {
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;
  bool isPlaying = false;
  String? currentSource;
  bool isShuffling = false;
  bool isLooping = false;
  Duration? lastPosition;

  AudioProvider() {
    _initAudioPlayer();
  }

  void _initAudioPlayer() {
    audioPlayer.onPlayerStateChanged.listen((state) {
      isPlaying = state == PlayerState.playing;
      notifyListeners();
    });

    audioPlayer.onPositionChanged.listen((position) {
      currentPosition = position;
      notifyListeners();
    });

    audioPlayer.onDurationChanged.listen((duration) {
      totalDuration = duration;
      notifyListeners();
    });
  }

  Future<void> playPause() async {
    try {
      if (currentSource == null) return;

      if (isPlaying) {
        await audioPlayer.pause();
      } else {
        await audioPlayer.resume();
      }
    } catch (e) {
      print('Error in playPause: $e');
    }
  }

  Future<void> initAudio(String url) async {
    try {
      if (currentSource != url) {
        bool wasPlaying = isPlaying;
        await audioPlayer.stop();
        await audioPlayer.setSourceUrl(url);
        currentSource = url;

        if (wasPlaying) {
          await audioPlayer.resume();
        }
      }
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  void seekTo(Duration position) async {
    try {
      if (currentSource != null) {
        await audioPlayer.seek(position);
        if (!isPlaying) {
          currentPosition = position;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Error seeking: $e');
    }
  }

  void toggleShuffle() {
    isShuffling = !isShuffling;
    notifyListeners();
  }

  void toggleLoop() {
    isLooping = !isLooping;
    audioPlayer
        .setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.release);
    notifyListeners();
  }

  List<String> playlist = [];
  int currentIndex = 0;

  Future<void> skipToNext() async {
    if (playlist.isEmpty || currentIndex >= playlist.length - 1) return;
    currentIndex++;
    await initAudio(playlist[currentIndex]);
  }

  Future<void> skipToPrevious() async {
    if (playlist.isEmpty || currentIndex <= 0) return;
    currentIndex--;
    await initAudio(playlist[currentIndex]);
  }

  void addToPlaylist(String url) {
    playlist.add(url);
    notifyListeners();
  }

  void clearPlaylist() {
    playlist.clear();
    currentIndex = 0;
    notifyListeners();
  }

  Future<void> disposeAudio() async {
    await audioPlayer.stop();
  }

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }
}

class Player extends StatefulWidget {
  final String songName;
  final String artistName;
  final String artistImage;
  final String localFilePath;

  const Player({
    super.key,
    required this.songName,
    required this.artistName,
    required this.artistImage,
    required this.localFilePath,
  });

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  late AnimationController _playPauseController;
  late AudioProvider audioProvider;
  bool isMinimized = false;

  @override
  void initState() {
    super.initState();
    _playPauseController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final provider = context.read<AudioProvider>();
      provider.addToPlaylist(widget.localFilePath);
      provider.initAudio(widget.localFilePath);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    audioProvider = Provider.of<AudioProvider>(context);
  }

  @override
  void dispose() {
    _playPauseController.dispose();
    audioProvider.disposeAudio();
    super.dispose();
  }

  void toggleMinimize() {
    setState(() {
      isMinimized = !isMinimized;
    });
    Navigator.pop(context, true); // Pass true to indicate minimization
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<AudioProvider>(
      builder: (context, audioProvider, child) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            leading: IconButton(
              icon: const Icon(Icons.keyboard_arrow_down),
              onPressed: toggleMinimize,
            ),
          ),
          body: isMinimized
              ? buildMiniPlayer(audioProvider)
              : buildFullPlayer(audioProvider),
        );
      },
    );
  }

  Widget buildFullPlayer(AudioProvider audioProvider) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.grey[900]!,
            Colors.black,
          ],
        ),
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Center(
                child: RichText(
                  textAlign: TextAlign.center,
                  text: TextSpan(
                    children: [
                      TextSpan(
                        text: 'PLAYING FROM ARTIST\n',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[400],
                          letterSpacing: 1.5,
                        ),
                      ),
                      TextSpan(
                        text: widget.artistName,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 30),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.3),
                        spreadRadius: 2,
                        blurRadius: 15,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.artistImage,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.songName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: Text(
                  widget.artistName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
                  ),
                ),
              ),
              const SizedBox(height: 32),
              SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape:
                      const RoundSliderThumbShape(enabledThumbRadius: 6),
                  overlayShape:
                      const RoundSliderOverlayShape(overlayRadius: 14),
                  activeTrackColor: Colors.white,
                  inactiveTrackColor: Colors.grey[800],
                  thumbColor: Colors.white,
                  overlayColor: Colors.white.withOpacity(0.2),
                ),
                child: Slider(
                  value: audioProvider.currentPosition.inSeconds.toDouble(),
                  max: audioProvider.totalDuration.inSeconds.toDouble(),
                  onChanged: (value) =>
                      audioProvider.seekTo(Duration(seconds: value.toInt())),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      formatDuration(audioProvider.currentPosition),
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                    Text(
                      formatDuration(audioProvider.totalDuration),
                      style: TextStyle(color: Colors.grey[400]),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      audioProvider.isShuffling ? Icons.shuffle : Icons.shuffle,
                      color: audioProvider.isShuffling
                          ? Colors.green
                          : Colors.white,
                    ),
                    onPressed: audioProvider.toggleShuffle,
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_previous, size: 40),
                    onPressed: audioProvider.skipToPrevious,
                    color: Colors.white,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                    child: IconButton(
                      iconSize: 40,
                      icon: Icon(
                        audioProvider.isPlaying
                            ? Icons.pause
                            : Icons.play_arrow,
                        color: Colors.black,
                      ),
                      onPressed: () {
                        audioProvider.playPause();
                      },
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, size: 40),
                    onPressed: audioProvider.skipToNext,
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: Icon(
                      audioProvider.isLooping ? Icons.repeat_one : Icons.repeat,
                      color:
                          audioProvider.isLooping ? Colors.green : Colors.white,
                    ),
                    onPressed: audioProvider.toggleLoop,
                  ),
                ],
              ),
              const Spacer(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: const Icon(Icons.devices),
                    onPressed: () {
                      // Show available devices dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Available Devices'),
                          content: Text('No other devices found'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(Icons.playlist_add),
                    onPressed: () {
                      // Show playlist dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text('Playlist'),
                          content: Text('Current playlist management disabled'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text('Close'),
                            ),
                          ],
                        ),
                      );
                    },
                    color: Colors.white,
                  ),
                  IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () {
                      // Share song info
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                              'Sharing "${widget.songName}" by ${widget.artistName}'),
                        ),
                      );
                    },
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildMiniPlayer(AudioProvider audioProvider) {
    return Container(
      color: Colors.black,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            leading: Image.network(widget.artistImage),
            title: Text(widget.songName, style: TextStyle(color: Colors.white)),
            subtitle:
                Text(widget.artistName, style: TextStyle(color: Colors.white)),
            trailing: IconButton(
              icon: Icon(
                audioProvider.isPlaying ? Icons.pause : Icons.play_arrow,
                color: Colors.black,
              ),
              onPressed: () async {
                await audioProvider.playPause();
              },
            ),
          ),
          Slider(
            value: audioProvider.currentPosition.inSeconds.toDouble(),
            max: audioProvider.totalDuration.inSeconds.toDouble(),
            onChanged: (value) =>
                audioProvider.seekTo(Duration(seconds: value.toInt())),
          ),
        ],
      ),
    );
  }
}
