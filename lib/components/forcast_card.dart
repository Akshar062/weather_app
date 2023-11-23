import 'package:flutter/material.dart';

class ForecastCard extends StatefulWidget {
  final String time;
  final IconData icon;
  final String temperature;
  const ForecastCard({super.key, required this.time, required this.icon, required this.temperature});

  @override
  State<ForecastCard> createState() => _ForecastCardState();
}

class _ForecastCardState extends State<ForecastCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 8,
      child: Container(
        width: 100,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Text(
              widget.time,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Icon(
              widget.icon,
              size: 34,
            ),
            const SizedBox(height: 8),
            Text(
              widget.temperature,
              style: const TextStyle(
                fontSize: 18,
              ),
            ),
          ],
        ),
      ),
    );
  }
}