import 'package:flutter/material.dart';

class ItemListMenu extends StatelessWidget {
  final IconData icon;
  final String text;
  final VoidCallback onTap;

  const ItemListMenu(
      {required this.icon, required this.text, required this.onTap, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Row(
        children: [
          Icon(icon),
          const SizedBox(
            width: 10,
          ),
          Text(text),
        ],
      ),
      onTap: onTap,
    );
  }
}
