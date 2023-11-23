import 'dart:ui';
import 'package:flutter/material.dart';

class MainCard extends StatefulWidget {
  final String temperature;
  final IconData icon;
  final String weather;
  const MainCard(
      {super.key,
      required this.temperature,
      required this.icon,
      required this.weather});

  @override
  State<MainCard> createState() => _MainCardState();
}

class _MainCardState extends State<MainCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4, sigmaY: 4),
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children: [
                Text(widget.temperature,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 6,
                ),
                Icon(
                  widget.icon,
                  size: 60,
                ),
                const SizedBox(
                  height: 6,
                ),
                Text(widget.weather,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
