import 'package:audioplayers/audioplayers.dart';

class DuaPlayer {
  static final DuaPlayer _singletonInstance = DuaPlayer._internal();

  factory DuaPlayer() => _singletonInstance;

  DuaPlayer._internal();
  final AudioPlayer _audioPlayer = AudioPlayer();

  // Initialize the audio player if needed
  void init() {
    // Any initialization code if necessary
  }

  // Play an audio file from a URL
  Future<void> play(String url) async {
    await _audioPlayer.play(AssetSource(url));
  }

  // Pause the currently playing audio
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  // Resume playing the audio
  Future<void> resume() async {
    await _audioPlayer.resume();
  }

  // Stop the currently playing audio
  Future<void> stop() async {
    await _audioPlayer.stop();
  }

  // Dispose the audio player to release resources
  void dispose() {
    _audioPlayer.dispose();
  }

  // Example of checking if the audio is playing
  bool isPlaying() {
    return _audioPlayer.state == PlayerState.playing;
  }

  bool isPause() {
    return _audioPlayer.state == PlayerState.paused;
  }

  Stream<void> listenToAudioCompletion() {
    return _audioPlayer.onPlayerComplete;
  }

  String? currentUrl() {
    final source = _audioPlayer.source;

    if (source is AssetSource) {
      return source.path;
    }

    return null;
  }
}
