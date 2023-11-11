part of 'swipe_bloc.dart';

abstract class SwipePostState extends Equatable {
  const SwipePostState(
      this.posts, this.deliveryPosts, this.selectedPost, this.swiperController);

  final List<NormalPost> posts;
  final List<PublicDeliveryPostDesc> deliveryPosts;
  final int selectedPost;
  final AppinioSwiperController swiperController;

  @override
  List<Object> get props => [selectedPost, posts];
}

class SwipePostLoadingState extends SwipePostState {
  const SwipePostLoadingState(super.posts, super.deliveryPosts,
      super.selectedPost, super.swiperController);
}

class SwipePostErrorState extends SwipePostState {
  final String errorMessage;

  const SwipePostErrorState(this.errorMessage, super.posts, super.deliveryPosts,
      super.selectedPost, super.swiperController);
}

class SwipePostLoadedState extends SwipePostState {
  const SwipePostLoadedState(super.posts, super.deliveryPosts,
      super.selectedPost, super.swiperController);
}

class ActionOnGoingState extends SwipePostState {
  const ActionOnGoingState(super.posts, super.deliveryPosts, super.selectedPost,
      super.swiperController);
}

class ActionDoneState extends SwipePostState {
  const ActionDoneState(super.posts, super.deliveryPosts, super.selectedPost,
      super.swiperController);
}

class ActionFailedState extends SwipePostState {
  final String errorMessage;

  const ActionFailedState(super.posts, super.deliveryPosts, super.selectedPost,
      super.swiperController, this.errorMessage);
}
