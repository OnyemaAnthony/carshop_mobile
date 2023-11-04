part of 'post_bloc.dart';

abstract class PostState extends Equatable {
  final List<DeliveryPost> deliveryPosts;
  final List<NormalPost> posts;
  final int normalIndex = 0;
  final int deliveryIndex = 0;

  const PostState(this.deliveryPosts, this.posts);
  @override
  List<Object> get props => [];
}

class InitialState extends PostState {
  const InitialState() : super(const [], const []);
}

class DataLoadingState extends PostState {
  const DataLoadingState(super.deliveryPosts, super.posts);
}

class DataReadyState extends PostState {
  const DataReadyState(super.posts, super.deliveryPosts);
}

class CreatedState extends PostState {
  const CreatedState(super.deliveryPosts, super.posts);
}

class PostErrorState extends PostState {
  final String errorMessage;

  const PostErrorState(this.errorMessage, super.deliveryPosts, super.posts);
}
