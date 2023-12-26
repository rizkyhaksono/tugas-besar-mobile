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
            value: 'option1',
            child: Text('Option 1'),
          ),
          const PopupMenuItem(
            value: 'option2',
            child: Text('Option 2'),
          ),
        ];
      },
      onSelected: (value) {
        // Handle the selected option
        print('Selected: $value');
      },
    );
  }
}
