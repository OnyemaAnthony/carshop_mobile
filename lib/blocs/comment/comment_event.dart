part of 'comment_bloc.dart';

abstract class CommentEvent extends Equatable {
  @override
  List<Object?> get props => [];

  const CommentEvent();
}

class GetAllCommentsEvent extends CommentEvent {
  final String parentId;
//final GetManyCommentsDto getManyCommentsDto;
  const GetAllCommentsEvent(this.parentId);
}

class GetCommentHistoryEvent extends CommentEvent {
  final dynamic comment;

  const GetCommentHistoryEvent(this.comment);
}

class DeleteCommentEvent extends CommentEvent {
  final String commentId;

  const DeleteCommentEvent(this.commentId);
}

class UpdateCommentEvent extends CommentEvent {
  final dynamic comment;

  const UpdateCommentEvent(this.comment);
}

class CreateCommentEvent extends CommentEvent {
  final CreateCommentDto commentDto;

  const CreateCommentEvent(this.commentDto);
}
