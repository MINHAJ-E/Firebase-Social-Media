// like.dart
// ignore_for_file: use_key_in_widget_constructors

import 'package:flutter/material.dart';

class Follow extends StatelessWidget {
  final bool isFollow;
  final void Function()? onTap;

  const Follow({Key? key, required this.isFollow, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            height: 25,
            width: 60,
            decoration: BoxDecoration(
                color: Colors.amber, borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: const EdgeInsets.only(top: 5, left: 5),
              child: Text(
                isFollow ? "unfollow" : "follow",
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
            ),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}
