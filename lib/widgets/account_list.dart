import 'package:flutter/material.dart';

import '../utilities/constants.dart';
import 'icon_tile.dart';
import 'image_to_icon.dart';

class AccountList extends StatelessWidget {
  final String? title;
  final String? iconPath;
  final Color? color;
  final BuildContext? context;
  final Function()? onTap;

  const AccountList(this.title, this.iconPath, this.color, this.context,
      {super.key, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          ListTile(
            leading: IconTile(
              iconPath: iconPath!,
            ),
            title: Text(
              title!,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(fontWeight: FontWeight.w400, color: Colors.black),
            ),
            trailing: Visibility(
              visible: !title!.contains('Log'),
              child: const ImageToIcon(
                width: 40,
                height: 40,
                imagePath: Constants.greaterThanArrowIconPath,
              ),
            ),
          ),
          Visibility(
            visible: !title!.contains('Log'),
            child: Container(
                margin: const EdgeInsets.only(left: 20, right: 20),
                child: const Divider()),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }
}
