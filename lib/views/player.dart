import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  String minutes = twoDigits(duration.inMinutes.remainder(60));
  String seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds";
}

class AudioPlayerManager {
  static final AudioPlayerManager _instance = AudioPlayerManager._internal();
  final AudioPlayer audioPlayer = AudioPlayer();
  Duration currentPosition = Duration.zero;
  Duration totalDuration = Duration.zero;

  factory AudioPlayerManager() {
    return _instance;
  }

  AudioPlayerManager._internal();
}

class Player extends StatefulWidget {
  final String songName;
  final String artistName;
  final String artistImage;
  final String localFilePath; // Added this

  const Player({
    Key? key,
    required this.songName,
    required this.artistName,
    required this.artistImage,
    required this.localFilePath, // Added this
  }) : super(key: key);

  @override
  State<Player> createState() => _PlayerState();
}

class _PlayerState extends State<Player> with SingleTickerProviderStateMixin {
  final audioManager = AudioPlayerManager();
  bool isPlaying = false;
  bool isShuffling = false;
  bool isLooping = false;
  late AnimationController _playPauseController;

  // Add getters
  Duration get currentPosition => audioManager.currentPosition;
  Duration get totalDuration => audioManager.totalDuration;

  @override
  void initState() {
    super.initState();
    _playPauseController = AnimationController(
      duration: const Duration(milliseconds: 200),
      vsync: this,
    );

    audioManager.audioPlayer.onDurationChanged.listen((duration) {
      if (mounted) setState(() => audioManager.totalDuration = duration);
    });

    audioManager.audioPlayer.onPositionChanged.listen((position) {
      if (mounted) setState(() => audioManager.currentPosition = position);
    });

    _initAudio();
  }

  Future<void> _initAudio() async {
    try {
      await audioManager.audioPlayer.setSourceUrl(widget.localFilePath);
      setState(() {
        isPlaying = true;
      });
      audioManager.audioPlayer.resume();
    } catch (e) {
      print('Error initializing audio: $e');
    }
  }

  void _seekTo(Duration position) {
    audioManager.audioPlayer.seek(position);
  }

  void _togglePlayPause() async {
    if (isPlaying) {
      await audioManager.audioPlayer.pause();
      _playPauseController.reverse();
    } else {
      await audioManager.audioPlayer.resume();
      _playPauseController.forward();
    }
    setState(() {
      isPlaying = !isPlaying;
    });
  }

  // Add toggle methods
  void _toggleShuffle() {
    setState(() {
      isShuffling = !isShuffling;
    });
  }

  void _toggleLoop() async {
    setState(() {
      isLooping = !isLooping;
    });
    await audioManager.audioPlayer
        .setReleaseMode(isLooping ? ReleaseMode.loop : ReleaseMode.release);
  }

  @override
  void dispose() {
    _playPauseController.dispose();
    super.dispose();
  }

  // Rest of the existing build method remains unchanged...

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.keyboard_arrow_down),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Container(
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
                Text(
                  widget.songName,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  widget.artistName,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[400],
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
                    value: audioManager.currentPosition.inSeconds.toDouble(),
                    max: audioManager.totalDuration.inSeconds.toDouble(),
                    onChanged: (value) =>
                        _seekTo(Duration(seconds: value.toInt())),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        formatDuration(currentPosition),
                        style: TextStyle(color: Colors.grey[400]),
                      ),
                      Text(
                        formatDuration(totalDuration),
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
                        isShuffling ? Icons.shuffle : Icons.shuffle,
                        color: isShuffling ? Colors.green : Colors.white,
                      ),
                      onPressed: _toggleShuffle,
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_previous, size: 40),
                      onPressed: () {},
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
                          isPlaying ? Icons.pause : Icons.play_arrow,
                          color: Colors.black,
                        ),
                        onPressed: _togglePlayPause,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.skip_next, size: 40),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: Icon(
                        isLooping ? Icons.repeat_one : Icons.repeat,
                        color: isLooping ? Colors.green : Colors.white,
                      ),
                      onPressed: _toggleLoop,
                    ),
                  ],
                ),
                const Spacer(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.devices),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.playlist_add),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                    IconButton(
                      icon: const Icon(Icons.share),
                      onPressed: () {},
                      color: Colors.white,
                    ),
                  ],
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
