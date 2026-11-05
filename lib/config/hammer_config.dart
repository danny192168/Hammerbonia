import 'package:flutter/foundation.dart';

/// Tune motion sensitivity, timing, and sound response in one place.
abstract final class HammerConfig {
  // Raise this when normal movement triggers bonks; lower it when swings are missed.
  static const minimumMotionThreshold = 10.0;
  // Lower this if hard hits do not sound different enough from light hits.
  static const maximumMotionThreshold = 32.0;
  static const minimumVolume = 0.4;
  static const maximumVolume = 1.0;
  static const minimumPlaybackRate = 0.9;
  static const maximumPlaybackRate = 1.6;
  static const rapidMaximumPlaybackRate = 1.8;
  // Increase this when rapid hammering feels too chaotic; decrease it for more response.
  static const motionCooldown = Duration(milliseconds: 350);
  static const rapidMotionCooldown = Duration(milliseconds: 240);
  static const rapidWindow = Duration(milliseconds: 500);
  static const rapidResetWindow = Duration(seconds: 1);
  static const sensorSamplingPeriod = Duration(milliseconds: 20);

  static double clamp(double value, double minimum, double maximum) =>
      clampDouble(value, minimum, maximum);
}
