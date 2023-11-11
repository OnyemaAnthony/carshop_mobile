import 'package:flutter/material.dart';

class CustomListItem extends StatelessWidget {
  final String info;
  final String title;
  final IconData icon;

  const CustomListItem({
    super.key,
    required this.info,
    required this.title,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: Theme.of(context).textTheme.titleSmall),
          Icon(icon),
        ],
      ),
      title: Text(info),
    );
  }
}
