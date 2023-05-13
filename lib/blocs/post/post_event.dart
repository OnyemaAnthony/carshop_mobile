part of 'post_bloc.dart';

abstract class PostEvent extends Equatable {
  const PostEvent();
  @override
  List<Object?> get props =>[];

}
class DeletePostEvent extends PostEvent{
  final String postId;

  const DeletePostEvent(this.postId);

}
class LikePostEvent extends PostEvent{
  final String postId;

  const LikePostEvent(this.postId);

}
class UnlikePostEvent extends PostEvent{
  final String postId;

  const UnlikePostEvent(this.postId);

}
class SavePostEvent extends PostEvent{
  final PostModel postModel;

  const SavePostEvent(this.postModel);

}
class UpdatePostEvent extends PostEvent{
  final PostModel postModel;

  const UpdatePostEvent(this.postModel);

}

class FetchPostsEvent extends PostEvent{

}
class PostDeletedState extends PostState{

}

class SaveDeliveryPostEvent extends PostEvent{
  final DeliveryPost deliveryPost;

  const SaveDeliveryPostEvent(this.deliveryPost);

}
class GetMyDeliveryPostEvent extends PostEvent{
  final String creatorId;

 const GetMyDeliveryPostEvent(this.creatorId);

}
class GetSingleDeliveryPostEvent extends PostEvent{
  final String deliveryPostId;

  const GetSingleDeliveryPostEvent(this.deliveryPostId);

}
class UpdateDeliveryPostEvent extends PostEvent{
  final DeliveryPost deliveryPost;

  const UpdateDeliveryPostEvent(this.deliveryPost);

}
class DeleteDeliveryPostEvent extends PostEvent{
  final String deliveryPostId;

  const DeleteDeliveryPostEvent(this.deliveryPostId);

}

