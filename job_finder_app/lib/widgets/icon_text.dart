import 'package:flutter/material.dart';

class IconText extends StatelessWidget {
  final IconData icon;
  final String text;
  const IconText(this.icon, this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: Colors.yellow),
        const SizedBox(width: 10),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.grey),
        )
      ],
    );
  }
}
