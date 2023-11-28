import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timeago/timeago.dart' as timeago;

class CommentListItem extends StatelessWidget {
  PublicCommentDescriptor? comment;
  Function()? reply;
  Function()? onAction;
  Function()? onTap;

  CommentListItem(
      {Key? key, this.comment, this.onAction, this.reply, this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            child: Text(comment!.creator.lastName[0]),
          ),
          const SizedBox(
            width: 20,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Text(
                        '${comment!.creator.lastName} ${comment!.creator.firstName} ${timeago.format(comment!.createdAt)}',
                        style: Theme.of(context).textTheme.titleSmall),
                    const Spacer(),
                    GestureDetector(
                      onTap: onAction,
                      child: const Icon(
                        Icons.more_horiz_outlined,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  comment!.content,
                  style: GoogleFonts.inter(
                      fontWeight: FontWeight.w400,
                      fontSize: 14,
                      color: Colors.black),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Row(
                children: [
                  const ImageIcon(
                    AssetImage('assets/images/like.png'),
                    size: 30,
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  const ImageIcon(
                    AssetImage('assets/images/comment.png'),
                    size: 50,
                  ),
                  Text(comment!.noOfReplies.toInt().toString()),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              comment!.noOfReplies.toInt() > 0
                  ? GestureDetector(
                      onTap: reply,
                      child: Text(
                        '${comment!.noOfReplies.toInt().toString()} REPLY',
                        style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                        ),
                      ),
                    )
                  : Container(),
            ],
          ),
        ],
      ),
    );
  }
}
