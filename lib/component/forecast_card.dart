// reusable card
import 'package:flutter/material.dart';

class ForeCastCard extends StatelessWidget {
  final String time;
  final Widget theIcon;
  final String exactTemp;

  const ForeCastCard({
    super.key,
    required this.time,
    required this.theIcon,
    required this.exactTemp,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 10,
      child: Container(
        width: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Text(
              time,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1, //can only be one line
              overflow: TextOverflow.ellipsis, //tells user to expect more text
            ),
            const SizedBox(
              height: 8,
            ),
            theIcon,
            const SizedBox(
              height: 8,
            ),
            Text(
              exactTemp,
              style: const TextStyle(
                fontSize: 14,
              ),
            )
          ],
        ),
      ),
    );
  }
}
