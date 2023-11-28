part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const CommentEvent();
}

class GetAllNormalPostsEvent extends CommentEvent {
  final String? normalPostId;
  final String? deliveryPostId;
  final String? parentCommentId;
  final String? commentId;

  const GetAllNormalPostsEvent(
      {this.parentCommentId,
      this.deliveryPostId,
      this.normalPostId,
      this.commentId});
}

class GetAllDeliveryPostsEvent extends CommentEvent {
  final String? normalPostId;
  final String? deliveryPostId;
  final String? parentCommentId;
  final String? commentId;

  const GetAllDeliveryPostsEvent(
      {this.parentCommentId,
      this.deliveryPostId,
      this.normalPostId,
      this.commentId});
}

class GetCommentHistoryEvent extends CommentEvent {
  final PublicCommentsDescriptor comment;

  const GetCommentHistoryEvent(this.comment);
}

class DeleteCommentEvent extends CommentEvent {
  final PublicCommentsDescriptor comments;
  final String commentId;

  const DeleteCommentEvent(this.commentId, this.comments);
}

class UpdateCommentEvent extends CommentEvent {
  final PublicCommentsDescriptor comment;

  const UpdateCommentEvent(this.comment);
}

class CreateCommentEvent extends CommentEvent {
  final CreateCommentDto comment;

  const CreateCommentEvent(this.comment);
}
