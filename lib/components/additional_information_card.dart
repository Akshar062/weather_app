import 'package:flutter/material.dart';

class AdditionalInformationCard extends StatefulWidget {

  final IconData icon;
  final String condition;
  final String value;

  const AdditionalInformationCard({super.key, required this.icon, required this.condition, required this.value});

  @override
  State<AdditionalInformationCard> createState() => _AdditionalInformationCardState();
}

class _AdditionalInformationCardState extends State<AdditionalInformationCard> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(
          widget.icon,
          size: 34,
        ),
        const SizedBox(height: 8),
        Text(
          widget.condition,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          widget.value,
          style: const TextStyle(
            fontSize: 18,
          ),
        ),
      ],
    );
  }
}
