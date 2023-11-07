import 'package:flutter/material.dart';

class ChangeBottomSheet extends StatelessWidget {
  final Function(BuildContext sheetContext)? onEdit;
  final Function(BuildContext sheetContext)? onDelete;

  const ChangeBottomSheet({Key? key, this.onEdit, this.onDelete})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showModalBottomSheet<void>(
            context: context,
            builder: (BuildContext context) {
              return SizedBox(
                height: 100,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    if (onEdit != null)
                      ChangeItem(
                        text: "Edit",
                        onPressed: onEdit!,
                      ),
                    if (onDelete != null)
                      ChangeItem(
                        text: "Delete",
                        onPressed: onDelete!,
                      )
                  ],
                ),
              );
            },
          );
        },
        icon: const Icon(
          Icons.more_horiz_outlined,
        ));
  }
}

class ChangeItem extends StatelessWidget {
  const ChangeItem({super.key, required this.onPressed, required this.text});

  final Function(BuildContext) onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => onPressed(context),
        child: ListTile(
          title: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          leading: Container(
            decoration: BoxDecoration(
                color: Colors.black.withOpacity(.1), shape: BoxShape.circle),
            padding: const EdgeInsets.all(10),
            child: const ImageIcon(AssetImage('assets/icons/delete.png')),
          ),
        ));
  }
}
