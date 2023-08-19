part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  const PostState();
  @override
  List<Object> get props => [];
}

class PostInitial extends PostState {}

class PostLoadingState extends PostState {}

class PostLoadedState extends PostState {
  final List<NormalPost> posts;

  const PostLoadedState(this.posts);
}

class DeliveryPostLoadedState extends PostState {
  final List<DeliveryPost> deliveryPost;

  const DeliveryPostLoadedState(this.deliveryPost);
}

class DeliveryPostLoadingState extends PostState {}

class PostedState extends PostState {}

class PostDeliveredState extends PostState {
  final DeliveryPost deliveryPost;

  const PostDeliveredState(this.deliveryPost);
}

class PostErrorState extends PostState {
  final String errorMessage;

  const PostErrorState(this.errorMessage);
}

class PostLoadState extends PostState {
  final NormalPost postModel;

  const PostLoadState(this.postModel);
}

class DeliveryPostLoadState extends PostState {
  final DeliveryPost deliveryPost;

  const DeliveryPostLoadState(this.deliveryPost);
}
