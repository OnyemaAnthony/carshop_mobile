import 'package:carshop_mobile/models/post/delivery_post.dart';
import 'package:carshop_mobile/models/post/post_model.dart';
import 'package:flutter/material.dart';

class PostSwiperItem extends StatelessWidget {
  const PostSwiperItem({super.key, required this.post});
  final PostModel post;
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Card(
            color: Colors.amber,
            child: SizedBox(
                width: 300,
                height: 80,
                child: Column(children: [
                  Text(post.title ?? "No title"),
                  Text(post.content ?? "No content")
                ]))));
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
                child: Column(children: [
                  Text("Title: ${deliveryPost.title ?? "No title"}"),
                  Text("Content: ${deliveryPost.content ?? "No content"}"),
                  Text("product name:${deliveryPost.productName}"),
                  Text("reward:${deliveryPost.reward}"),
                  Text("startDate:${deliveryPost.startDate}"),
                  Text("endDate:${deliveryPost.endDate}"),
                ]))));
  }
}
