part of 'swipe_bloc.dart';

abstract class SwipePostState extends Equatable {
  const SwipePostState(this.normalPosts, this.deliveryPosts, this.selectedPost,
      {this.selectedDeliveryPost, this.selectedNormalPost});

  final List<PublicNormalPostDescriptor> normalPosts;
  final List<PublicDeliveryPostDesc> deliveryPosts;
  final int selectedPost;
  final PublicNormalPostDescriptor? selectedNormalPost;
  final PublicDeliveryPostDesc? selectedDeliveryPost;

  @override
  List<Object> get props =>
      [selectedPost, normalPosts, selectedDeliveryPost?.isLiked ?? false];
}

class SwipePostLoadingState extends SwipePostState {
  const SwipePostLoadingState(
      super.normalPosts, super.deliveryPosts, super.selectedPost,
      {super.selectedDeliveryPost});
}

class SwipePostErrorState extends SwipePostState {
  final String errorMessage;

  const SwipePostErrorState(this.errorMessage, super.normalPosts,
      super.deliveryPosts, super.selectedPost,
      {super.selectedDeliveryPost});
}

class SwipePostLoadedState extends SwipePostState {
  const SwipePostLoadedState(
      super.normalPosts, super.deliveryPosts, super.selectedPost,
      {super.selectedNormalPost, super.selectedDeliveryPost});
}

class ActionOnGoingState extends SwipePostState {
  const ActionOnGoingState(
      super.normalPosts, super.deliveryPosts, super.selectedPost,
      {super.selectedDeliveryPost});
}

class ActionDoneState extends SwipePostState {
  const ActionDoneState(
      super.normalPosts, super.deliveryPosts, super.selectedPost,
      {super.selectedDeliveryPost});
}

class ActionFailedState extends SwipePostState {
  final String errorMessage;

  const ActionFailedState(super.normalPosts, super.deliveryPosts,
      super.selectedPost, this.errorMessage,
      {super.selectedDeliveryPost});
}
