import 'dart:core';
import 'package:card_swiper/card_swiper.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/blocs/swipe_posts/swipe_bloc.dart';
import 'package:carshop_mobile/utilities/extensions.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import 'package:carshop_mobile/widgets/swipe_module/public_deliverypost_card.dart';
import 'package:carshop_mobile/widgets/swipe_module/public_normalpost_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
            SwipeBloc(normalPosts: posts, deliveryPosts: deliveryPosts)
              ..add(const InitializePageEvent()),
        child:
            BlocConsumer<SwipeBloc, SwipePostState>(listener: (context, state) {
          if (state.message == SwipeBlocMessages.postRefreshed) {
            UiUtilities.showToast(
                message: "post_refresh_success".trans(context),
                toast: Toast.LENGTH_SHORT);
          } else if (state.message == SwipeBlocMessages.postLiked) {
            UiUtilities.showToast(
                message: "post_like_success".trans(context),
                toast: Toast.LENGTH_SHORT);
          } else if (state.message == SwipeBlocMessages.postDisliked) {
            UiUtilities.showToast(
                message: "post_dislike_success".trans(context),
                toast: Toast.LENGTH_SHORT);
          } else if (state.message == SwipeBlocMessages.failedToLikePost) {
            UiUtilities.showErrorMessage("post_like_fail".trans(context));
          } else if (state.message == SwipeBlocMessages.failedToDislikePost) {
            UiUtilities.showErrorMessage("post_dislike_fail".trans(context));
          } else if (state.message == SwipeBlocMessages.deliveryPostAccepted) {
            UiUtilities.showToast(
                message: "post_accept_success".trans(context),
                toast: Toast.LENGTH_SHORT);
          } else if (state.message ==
              SwipeBlocMessages.deliveryPostAcceptionFailed) {
            UiUtilities.showErrorMessage("post_accept_fail".trans(context));
          }
        }, builder: (context, state) {
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
                var post = swipeBloc.getPost(index);

                if (post is PublicNormalPostDescriptor) {
                  return PublicNormalPostCard(
                    normalPost: post,
                  );
                } else if (post is PublicDeliveryPostDesc) {
                  return PublicDeliveryPostCard(
                    deliveryPost: post,
                  );
                } else {
                  return Container();
                }
              },
              indicatorLayout: PageIndicatorLayout.COLOR,
              loop: true,
              itemCount: state.normalPosts.length,
            ),
          );
        }));
  }
}
