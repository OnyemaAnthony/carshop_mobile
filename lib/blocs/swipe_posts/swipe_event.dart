part of 'swipe_bloc.dart';

abstract class SwipePostEvent extends Equatable {
  const SwipePostEvent();
  @override
  List<Object?> get props => [];
}

class LikePostEvent extends SwipePostEvent {
  final String postId;
  const LikePostEvent(this.postId);
}

class UnlikePostEvent extends SwipePostEvent {
  final String postId;
  const UnlikePostEvent(this.postId);
}

class SavePostEvent extends SwipePostEvent {
  final String postId;
  const SavePostEvent(this.postId);
}

class OpenPostEvent extends SwipePostEvent {
  final String postId;
  const OpenPostEvent(this.postId);
}

class BackToSwipeEvent extends SwipePostEvent {
  const BackToSwipeEvent();
}

class OpenCommentsEvent extends SwipePostEvent {
  final String postId;
  const OpenCommentsEvent(this.postId);
}

class DeleteDeliveryPost extends SwipePostEvent {
  final String postId;
  const DeleteDeliveryPost(this.postId);
}

class AcceptDeliveryPostEvent extends SwipePostEvent {
  final String deliveryPostId;
  const AcceptDeliveryPostEvent(this.deliveryPostId);
}

class LikeDeliveryPostEvent extends SwipePostEvent {
  final String deliveryPostId;
  final bool isLiked;

  const LikeDeliveryPostEvent(this.deliveryPostId, this.isLiked);
}

class PostSwipedEvent extends SwipePostEvent {
  final int index;
  const PostSwipedEvent({required this.index});
}
