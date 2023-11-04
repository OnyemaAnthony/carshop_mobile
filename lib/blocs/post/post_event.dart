part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props => [];
}

class DeletePostEvent extends PostEvent {
  final String postId;

  const DeletePostEvent(this.postId);
}

class LikePostEvent extends PostEvent {
  final String postId;

  const LikePostEvent(this.postId);
}

class UnlikePostEvent extends PostEvent {
  final String postId;

  const UnlikePostEvent(this.postId);
}

class SavePostEvent extends PostEvent {
  final CreatePostDto createDto;

  const SavePostEvent(this.createDto);
}

class UpdatePostEvent extends PostEvent {
  final String id;
  // final UpdatePostDto updatePostDto;

  const UpdatePostEvent(this.id);
}

class FetchPostsEvent extends PostEvent {}

class FetchMyPostsEvent extends PostEvent {}

class SaveDeliveryPostEvent extends PostEvent {
  final CreateDeliveryPost createDPDto;

  const SaveDeliveryPostEvent(this.createDPDto);
}

class GetMyDeliveryPostEvent extends PostEvent {
  const GetMyDeliveryPostEvent();
}

class GetSingleDeliveryPostEvent extends PostEvent {
  final String deliveryPostId;

  const GetSingleDeliveryPostEvent(this.deliveryPostId);
}

class UpdateDeliveryPostEvent extends PostEvent {
  //final UpdateDeliveryPostDto updateDPDto;
  final String id;

  const UpdateDeliveryPostEvent(this.id);
}

class DeleteDeliveryPostEvent extends PostEvent {
  final String deliveryPostId;

  const DeleteDeliveryPostEvent(this.deliveryPostId);
}

class AcceptDeliveryPostEvent extends PostEvent {
  final String deliveryPostId;

  const AcceptDeliveryPostEvent(this.deliveryPostId);
}
