# Hammerbonia

Hammerbonia is a minimal Flutter app that turns phone hammering motions into `hard-pop.wav` sounds.

## Audio asset

Replace `assets/audio/hard-pop.wav` with a real, short WAV file. The checked-in file is a placeholder so the asset path is registered in a fresh checkout. The app catches missing or corrupt audio safely, but it cannot produce sound until a valid WAV is present.

## Run on a device

1. Install Flutter and verify a physical Android or iOS device with `flutter devices`.
2. Put the real WAV at `assets/audio/hard-pop.wav`.
3. Run `flutter pub get`.
4. Run `flutter run -d <device-id>`.

Use a physical device for motion testing. Simulators generally do not provide useful accelerometer data. Android requires no runtime permission for these sensors. iOS also needs no motion permission for this accelerometer use.

## How it works

`MotionService` listens to the user accelerometer, calculates acceleration magnitude, and emits one motion after the cooldown. Normalized magnitude drives volume from `0.4` to `1.0` and playback rate from `0.9x` to `1.6x`. The audio service stops and restarts the asset for each bonk.

Bonks less than 500 ms apart form a rapid combo. Each additional rapid bonk adds a small playback-rate boost, capped at `1.8x`, with a small volume boost. The combo resets after one second. Muting only disables playback; the counter and indicators still update.

Motion listening stops when the app is backgrounded and resumes when it returns to the foreground.

## Tuning

All controls are in `lib/config/hammer_config.dart`:

- `minimumMotionThreshold`: raise it if the app triggers too easily; lower it if it misses gentle hammers.
- `maximumMotionThreshold`: lower it if hard hits are not noticeably louder or faster than light hits.
- `minimumVolume`, `maximumVolume`: adjust the volume mapping.
- `minimumPlaybackRate`, `maximumPlaybackRate`: adjust the intensity speed mapping.
- `motionCooldown`, `rapidMotionCooldown`: increase either when repeated hits feel noisy; decrease them for more responsiveness.
- `rapidWindow`, `rapidResetWindow`, `rapidMaximumPlaybackRate`: control combo timing and energy.
- `sensorSamplingPeriod`: use a shorter interval for more responsiveness, at the cost of more sensor work.

Run `flutter analyze` and `flutter test` after tuning.
# Hammerbonia
