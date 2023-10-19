import 'package:flutter/material.dart';

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
    return Container(
      //width: MediaQuery.of(context).size.width*0.8,
      child: Row(
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
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(userName!),
                  const Icon(Icons.more_horiz_outlined),

                ],
              ),
              const SizedBox(height: 5,),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.7,
                child: Text(
                  commentText!,
                  maxLines: 8,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Row(
                children: [
                  Icon(Icons.thumb_up),
                  Text('22'),
                  SizedBox(
                    width: 5,
                  ),
                  Icon(Icons.comment),
                ],
              ),
              const SizedBox(
                height: 10,
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
      ),
    );
  }
}
