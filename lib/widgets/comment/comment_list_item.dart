import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CommentListItem extends StatelessWidget {
  String? imageUrl;
  String? userName;
  String? timeAgo;
  String? commentText;
  String? likes;
  String? comments;

  CommentListItem(
      {Key? key,
      this.imageUrl,
      this.comments = '0',
      this.commentText,
      this.likes = '0',
      this.timeAgo,
      this.userName})
      : super(key: key);
  String image =
      'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&q=80&w=3087&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8fA%3D%3D';

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(image),
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
                    '$userName $timeAgo',
                    style: GoogleFonts.inter(
                      color: const Color(
                        0xff808080,
                      ),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  const Spacer(),
                  const Icon(
                    Icons.more_horiz_outlined,
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
                commentText!,
                style: GoogleFonts.inter(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.black),
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            const Row(
              children: [
                ImageIcon(
                  AssetImage('assets/images/like.png'),
                  size: 30,
                ),
                Text('22'),
                SizedBox(
                  width: 5,
                ),
                ImageIcon(
                  AssetImage('assets/images/comment.png'),
                  size: 50,
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              '4 REPLY',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          ],
        ),
      ],
    );
  }
}
