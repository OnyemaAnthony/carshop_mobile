part of 'comment_bloc.dart';

abstract class CommentState extends Equatable {
  @override
  List<Object> get props => [];

  const CommentState();
}

class CommentInitial extends CommentState {}

class CommentLoadingState extends CommentState {}

class CommentLoadedState extends CommentState {
  final CommentsDescriptor comments;

  const CommentLoadedState(this.comments);
}

class CommentedState extends CommentState {}

class CommentErrorState extends CommentState {
  final String errorMessage;

  const CommentErrorState(this.errorMessage);
}
