import 'package:flutter/material.dart';

class MuteButton extends StatelessWidget {
  const MuteButton({required this.muted, required this.onPressed, super.key});
  final bool muted;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) => IconButton.filled(
    tooltip: muted ? 'Unmute' : 'Mute',
    onPressed: onPressed,
    icon: Icon(muted ? Icons.volume_off_rounded : Icons.volume_up_rounded),
    style: IconButton.styleFrom(
      backgroundColor: const Color(0xFF2D2926),
      foregroundColor: Colors.white,
    ),
  );
}
