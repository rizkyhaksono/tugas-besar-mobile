import 'package:flutter/material.dart';

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
          const PopupMenuItem(
            value: 'credit',
            child: Text('Credit'),
          ),
          const PopupMenuItem(
            value: 'events',
            child: Text('Events'),
          ),
        ];
      },
      onSelected: (value) {
        print('Selected: $value');
      },
    );
  }
}
