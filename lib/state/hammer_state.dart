import 'dart:async';

import 'package:flutter/foundation.dart';

import '../config/hammer_config.dart';
import '../services/audio_service.dart';
import '../services/motion_service.dart';

class HammerState extends ChangeNotifier {
  HammerState({MotionService? motion, AudioService? audio})
    : _motion = motion ?? MotionService(),
      _audio = audio ?? AudioService() {
    _motion.onHammer = _onHammer;
  }

  final MotionService _motion;
  final AudioService _audio;
  Timer? _rapidReset;
  DateTime? _lastMotion;
  int bonks = 0;
  int rapidCount = 0;
  double intensity = 0;
  bool muted = false;

  String get intensityLabel {
    if (intensity < 0.34) return 'Light';
    if (intensity < 0.67) return 'Medium';
    return 'Hard';
  }

  Future<void> initialize() async {
    await _audio.preload();
    _motion.start();
  }

  void pause() => _motion.stop();
  void resume() => _motion.start();

  void toggleMute() {
    muted = !muted;
    notifyListeners();
  }

  void _onHammer(HammerMotion motion) {
    final previous = _lastMotion;
    final isRapid =
        previous != null &&
        motion.timestamp.difference(previous) < HammerConfig.rapidWindow;
    _lastMotion = motion.timestamp;
    rapidCount = isRapid ? rapidCount + 1 : 1;
    bonks++;
    intensity = motion.intensity;
    _rapidReset?.cancel();
    _rapidReset = Timer(HammerConfig.rapidResetWindow, () {
      rapidCount = 0;
      notifyListeners();
    });
    notifyListeners();
    if (!muted) {
      unawaited(_audio.play(intensity: intensity, rapidCount: rapidCount));
    }
  }

  @override
  void dispose() {
    _rapidReset?.cancel();
    _motion.dispose();
    unawaited(_audio.dispose());
    super.dispose();
  }
}
