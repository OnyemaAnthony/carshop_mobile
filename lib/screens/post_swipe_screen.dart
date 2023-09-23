import 'dart:core';
import 'package:appinio_swiper/appinio_swiper.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/swipe_posts/swipe_bloc.dart';
import 'package:carshop_mobile/widgets/swipe_module/models_extender.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostSwipeScreen extends StatelessWidget {
  final List<NormalPost> posts;

  const PostSwipeScreen({
    super.key,
    required this.posts,
  });

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (BuildContext context) => SwipeBloc(normalPosts: posts),
        child:
            BlocBuilder<SwipeBloc, SwipePostState>(builder: (context, state) {
          return CupertinoPageScaffold(
            navigationBar: CupertinoNavigationBar(
              middle: Text('Swipe'),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: 120,
                  child: Swiper(
                    itemBuilder: (context, index) {
                      if (state.posts[index] is DeliveryPost) {
                        return (state.posts[index] as DeliveryPost)
                            .getSwipeItem();
                      }
                      return (state.posts[index] as NormalPost).getSwipeItem();
                    },
                    indicatorLayout: PageIndicatorLayout.COLOR,
                    loop: false,
                    itemCount: state.posts.length,
                  ),
                ),
              ],
            ),
          );
        }));
  }

  void _swipe(
      int index, AppinioSwiperDirection direction, BuildContext context) {
    if (direction == AppinioSwiperDirection.left) {
      BlocProvider.of<SwipeBloc>(context).add(const SwipeLeft());
    } else {
      BlocProvider.of<SwipeBloc>(context).add(const SwipeRight());
    }
  }

  void _unswipe(bool unswiped) {
    if (unswiped) {
    } else {}
  }

  void _onEnd() {}
}
