import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DaynoShareButton extends StatelessWidget {
  final Function()? onPressed;
  const DaynoShareButton({super.key, this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? CupertinoButton(
            onPressed: onPressed,
            child: const Icon(CupertinoIcons.share),
          )
        : IconButton(
            onPressed: onPressed,
            icon: const Icon(Icons.share_outlined),
          );
  }
}
