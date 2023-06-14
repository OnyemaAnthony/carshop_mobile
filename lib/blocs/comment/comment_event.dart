part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const CommentEvent();
}

class GetAllPostEvent extends CommentEvent{
  final CommentResponse comment;

  const GetAllPostEvent(this.comment);

}

class GetCommentHistoryEvent extends CommentEvent{
  final CommentResponse comment;

 const GetCommentHistoryEvent(this.comment);
}

class DeleteCommentEvent extends CommentEvent{
  final String commentId;

  const DeleteCommentEvent(this.commentId);

}

class UpdateCommentEvent extends CommentEvent{
  final CommentRequest comment;

  const UpdateCommentEvent(this.comment);
}
class SaveComment extends CommentEvent{
  final CommentRequest comment;

  const SaveComment(this.comment);
}