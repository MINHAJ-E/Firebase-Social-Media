// like.dart
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Like extends StatelessWidget {
  final bool isliked;
  final void Function()? onTap;

  const Like({Key? key, required this.isliked, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(
            isliked ? Icons.favorite : Icons.favorite_border,
            color: isliked ? Colors.red : Colors.green,
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
