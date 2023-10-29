import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/screens/comment_screen.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:flutter/material.dart';

class PostSwiperItem extends StatelessWidget {
  const PostSwiperItem({super.key, required this.post});

  final NormalPost post;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.amber,
        child: SizedBox(
          width: 300,
          height: 80,
          child: Column(
            children: [
              Text(post.latestContent?.title ?? "No title"),
              Text(post.latestContent?.content ?? "No content"),
              const Spacer(),
              GestureDetector(
                  onTap: () {
                    UiUtilities.push(context, CommentScreen());
                  },
                  child: const Icon(Icons.comment))
            ],
          ),
        ),
      ),
    );
  }
}

class DeliverySwiperItem extends StatelessWidget {
  final DeliveryPost deliveryPost;

  const DeliverySwiperItem({super.key, required this.deliveryPost});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Card(
        color: Colors.amber,
        child: SizedBox(
          width: 300,
          height: 150,
          child: Column(
            children: [
              Text("Title: ${deliveryPost.latestContent?.title ?? "No title"}"),
              Text(
                  "Content: ${deliveryPost.latestContent?.content ?? "No content"}"),
              Text(
                  "product name:${deliveryPost.latestDeliveryPostContent?.productName}"),
              Text("reward:${deliveryPost.latestDeliveryPostContent?.reward}"),
              Text(
                  "startDate:${deliveryPost.latestDeliveryPostContent?.deliveryStartDate}"),
              Text(
                  "endDate:${deliveryPost.latestDeliveryPostContent?.deliveryEndDate}"),
            ],
          ),
        ),
      ),
    );
  }
}
