import 'package:flutter/material.dart';

class IntensityIndicator extends StatelessWidget {
  const IntensityIndicator({
    required this.intensity,
    required this.label,
    super.key,
  });
  final double intensity;
  final String label;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'IMPACT',
            style: TextStyle(fontWeight: FontWeight.bold, letterSpacing: 1.4),
          ),
          Text(
            label,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Color(0xFFEB5E28),
            ),
          ),
        ],
      ),
      const SizedBox(height: 10),
      ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: LinearProgressIndicator(
          value: intensity,
          minHeight: 16,
          backgroundColor: const Color(0xFFEADFD2),
          color: const Color(0xFFEB5E28),
        ),
      ),
    ],
  );
}
