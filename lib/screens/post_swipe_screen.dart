import 'dart:core';

import 'package:card_swiper/card_swiper.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/swipe_posts/swipe_bloc.dart';
import 'package:carshop_mobile/widgets/swipe_module/public_deliverypost_card.dart';
import 'package:carshop_mobile/widgets/swipe_module/public_normalpost_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/logger.dart';

class PostSwipeScreen extends StatelessWidget {
  final List<PublicNormalPostDescriptor> posts;
  final List<PublicDeliveryPostDesc> deliveryPosts;

  const PostSwipeScreen({
    super.key,
    required this.posts,
    required this.deliveryPosts,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) =>
            SwipeBloc(normalPosts: posts, deliveryPosts: deliveryPosts),
        child:
            BlocBuilder<SwipeBloc, SwipePostState>(builder: (context, state) {
          SwipeBloc swipeBloc = BlocProvider.of<SwipeBloc>(context);
          return CupertinoPageScaffold(
            navigationBar: const CupertinoNavigationBar(
              middle: Text('Swipe'),
            ),
            child: Swiper(
              onIndexChanged: (index) {
                swipeBloc.add(PostSwipedEvent(index: index));
              },
              itemBuilder: (context, index) {
                return PublicNormalPostCard(
                  normalPost: state.selectedNormalPost!,
                );
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              loop: false,
              itemCount: state.normalPosts.length,
            ),
          );
        }));
  }
}
