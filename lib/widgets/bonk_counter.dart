import 'package:flutter/material.dart';

class BonkCounter extends StatelessWidget {
  const BonkCounter({required this.count, super.key});
  final int count;

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Text(
        '$count',
        style: Theme.of(context).textTheme.displayLarge?.copyWith(
          fontWeight: FontWeight.w900,
          color: const Color(0xFF2D2926),
        ),
      ),
      const Text(
        'BONKS',
        style: TextStyle(
          letterSpacing: 3,
          fontWeight: FontWeight.bold,
          color: Color(0xFFEB5E28),
        ),
      ),
    ],
  );
}
