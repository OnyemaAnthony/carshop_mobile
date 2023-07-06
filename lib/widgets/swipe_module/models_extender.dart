import 'package:carshop_mobile/models/post/delivery_post.dart';
import 'package:carshop_mobile/models/post/post_model.dart';
import 'package:carshop_mobile/widgets/swipe_module/swipe_item.dart';
import 'package:flutter/material.dart';

extension NormalPostSwipeExtension on PostModel {
  Widget getSwipeItem() {
    return PostSwiperItem(post: this);
  }
}

extension DeliveryPostSwipeExtension on DeliveryPost {
  Widget getSwipeItem() {
    return DeliverySwiperItem(deliveryPost: this);
  }
}

