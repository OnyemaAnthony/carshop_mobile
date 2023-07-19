import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/widgets/delivery_post.dart';
import 'package:carshop_mobile/widgets/swipe_module/swipe_item.dart';
import 'package:flutter/material.dart';

extension NormalPostSwipeExtension on NormalPost {
  Widget getSwipeItem() {
    return PostSwiperItem(post: this);
  }
}

extension DeliveryPostSwipeExtension on DeliveryPost {
  Widget getSwipeItem() {
    return DeliveryPostPage(post: this);
  }
}
