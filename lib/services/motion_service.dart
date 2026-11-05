import 'dart:async';
import 'dart:math' as math;

import 'package:sensors_plus/sensors_plus.dart';

import '../config/hammer_config.dart';

class HammerMotion {
  const HammerMotion({required this.intensity, required this.timestamp});

  final double intensity;
  final DateTime timestamp;
}

class MotionService {
  StreamSubscription<UserAccelerometerEvent>? _subscription;
  void Function(HammerMotion motion)? onHammer;
  DateTime? _lastHammer;
  bool _isRunning = false;

  void start() {
    if (_isRunning) return;
    _isRunning = true;
    _subscription = userAccelerometerEventStream(
      samplingPeriod: HammerConfig.sensorSamplingPeriod,
    ).listen(_handleEvent, onError: (_) {});
  }

  void stop() {
    _isRunning = false;
    _subscription?.cancel();
    _subscription = null;
  }

  void dispose() => stop();

  void _handleEvent(UserAccelerometerEvent event) {
    final magnitude = math.sqrt(
      event.x * event.x + event.y * event.y + event.z * event.z,
    );
    if (magnitude < HammerConfig.minimumMotionThreshold) return;

    final now = DateTime.now();
    final elapsed = _lastHammer == null ? null : now.difference(_lastHammer!);
    final cooldown = elapsed != null && elapsed < HammerConfig.rapidWindow
        ? HammerConfig.rapidMotionCooldown
        : HammerConfig.motionCooldown;
    if (elapsed != null && elapsed < cooldown) return;

    _lastHammer = now;
    final intensity = HammerConfig.clamp(
      (magnitude - HammerConfig.minimumMotionThreshold) /
          (HammerConfig.maximumMotionThreshold -
              HammerConfig.minimumMotionThreshold),
      0,
      1,
    );
    onHammer?.call(HammerMotion(intensity: intensity, timestamp: now));
  }
}
