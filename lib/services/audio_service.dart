import 'package:audioplayers/audioplayers.dart';

import '../config/hammer_config.dart';

class AudioService {
  final AudioPlayer _player = AudioPlayer();
  bool _ready = false;

  Future<void> preload() async {
    try {
      await _player.setReleaseMode(ReleaseMode.stop);
      await _player.setSourceAsset('audio/hard-pop.wav');
      _ready = true;
    } catch (_) {
      _ready = false;
    }
  }

  Future<void> play({
    required double intensity,
    required int rapidCount,
  }) async {
    if (!_ready) return;
    final volume =
        HammerConfig.minimumVolume +
        intensity * (HammerConfig.maximumVolume - HammerConfig.minimumVolume);
    final baseRate =
        HammerConfig.minimumPlaybackRate +
        intensity *
            (HammerConfig.maximumPlaybackRate -
                HammerConfig.minimumPlaybackRate);
    final rapidBoost = rapidCount > 1 ? (rapidCount - 1) * 0.05 : 0.0;
    final rate = HammerConfig.clamp(
      baseRate + rapidBoost,
      HammerConfig.minimumPlaybackRate,
      HammerConfig.rapidMaximumPlaybackRate,
    );
    try {
      await _player.stop();
      await _player.setPlaybackRate(rate);
      await _player.play(
        AssetSource('audio/hard-pop.wav'),
        volume: HammerConfig.clamp(volume + rapidBoost * 0.08, 0, 1),
      );
    } catch (_) {}
  }

  Future<void> dispose() => _player.dispose();
}
