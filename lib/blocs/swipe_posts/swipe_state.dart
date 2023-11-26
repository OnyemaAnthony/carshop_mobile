part of 'swipe_bloc.dart';

abstract class SwipePostState extends Equatable {
  const SwipePostState(
      this.posts, this.deliveryPosts, this.selectedPost, this.swiperController,
      {this.selectedDeliveryPost});

  final List<NormalPost> posts;
  final List<PublicDeliveryPostDesc> deliveryPosts;
  final int selectedPost;
  final AppinioSwiperController swiperController;
  final PublicDeliveryPostDesc? selectedDeliveryPost;

  @override
  List<Object> get props =>
      [selectedPost, posts, selectedDeliveryPost?.isLiked ?? false];
}

class SwipePostLoadingState extends SwipePostState {
  const SwipePostLoadingState(super.posts, super.deliveryPosts,
      super.selectedPost, super.swiperController,
      {super.selectedDeliveryPost});
}

class SwipePostErrorState extends SwipePostState {
  final String errorMessage;

  const SwipePostErrorState(this.errorMessage, super.posts, super.deliveryPosts,
      super.selectedPost, super.swiperController,
      {super.selectedDeliveryPost});
}

class SwipePostLoadedState extends SwipePostState {
  const SwipePostLoadedState(super.posts, super.deliveryPosts,
      super.selectedPost, super.swiperController,
      {super.selectedDeliveryPost});
}

class ActionOnGoingState extends SwipePostState {
  const ActionOnGoingState(super.posts, super.deliveryPosts, super.selectedPost,
      super.swiperController,
      {super.selectedDeliveryPost});
}

class ActionDoneState extends SwipePostState {
  const ActionDoneState(super.posts, super.deliveryPosts, super.selectedPost,
      super.swiperController,
      {super.selectedDeliveryPost});
}

class ActionFailedState extends SwipePostState {
  final String errorMessage;

  const ActionFailedState(super.posts, super.deliveryPosts, super.selectedPost,
      super.swiperController, this.errorMessage,
      {super.selectedDeliveryPost});
}
