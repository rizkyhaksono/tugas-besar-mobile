import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:push_puzzle/constants/resources.dart';

class TripleDotPopupMenu extends StatelessWidget {
  const TripleDotPopupMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      icon: const Icon(
        Icons.more_vert,
        color: Colors.white,
      ),
      itemBuilder: (BuildContext context) {
        return [
          PopupMenuItem(
            value: 'credit',
            child: Text(
              'Credit',
              style: TextStyle(fontFamily: Resources.font.primaryFont),
            ),
          ),
          PopupMenuItem(
            value: 'about',
            child: Text(
              'About',
              style: TextStyle(fontFamily: Resources.font.primaryFont),
            ),
          ),
        ];
      },
      onSelected: (value) {
        if (value == 'credit') {
          Get.toNamed("/credit");
        } else if (value == 'about') {
          Get.toNamed("/about");
        }
      },
    );
  }
}
