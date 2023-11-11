part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const CommentEvent();
}

class GetAllCommentsEvent extends CommentEvent {
  final String parentId;

  const GetAllCommentsEvent(this.parentId);
}

class GetCommentHistoryEvent extends CommentEvent {
  final CommentDescriptor comment;

  const GetCommentHistoryEvent(this.comment);
}

class DeleteCommentEvent extends CommentEvent {
  final CommentsDescriptor comments;
  final String commentId;

  const DeleteCommentEvent(this.commentId, this.comments);
}

class UpdateCommentEvent extends CommentEvent {
  final CommentDescriptor comment;

  const UpdateCommentEvent(this.comment);
}

class CreateCommentEvent extends CommentEvent {
  final CreateCommentDto comment;

  const CreateCommentEvent(this.comment);
}
