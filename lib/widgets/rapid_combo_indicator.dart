import 'package:flutter/material.dart';

class RapidComboIndicator extends StatelessWidget {
  const RapidComboIndicator({required this.count, super.key});
  final int count;

  @override
  Widget build(BuildContext context) => AnimatedOpacity(
    opacity: count > 1 ? 1 : 0.35,
    duration: const Duration(milliseconds: 200),
    child: Text(
      count > 1 ? 'RAPID x$count' : 'RAPID',
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        color: Color(0xFF2A9D8F),
        letterSpacing: 1.2,
      ),
    ),
  );
}
