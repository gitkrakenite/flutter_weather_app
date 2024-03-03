import 'package:flutter/material.dart';

class AdditionalInfoCard extends StatelessWidget {
  final String title;
  final Widget theIcon;
  final double numberData;

  const AdditionalInfoCard({
    super.key,
    required this.title,
    required this.theIcon,
    required this.numberData,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        theIcon,
        const SizedBox(height: 6),
        Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 6),
        Text(
          "$numberData",
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}
