import 'dart:async';

import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:carshop_mobile/utilities/logger.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<CreateCommentEvent>(_mapCreateCommentEventToState);
    on<GetAllNormalPostsEvent>(_mapGetNormalPostsEventToState);
    on<GetAllDeliveryPostsEvent>(_mapGetAllDeliveryPostsEventToState);
    on<DeleteCommentEvent>(_mapDeleteCommentEventToState);
  }

  FutureOr<void> _mapCreateCommentEventToState(
      CreateCommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoadingState());
    var client = CarshopSDK().client;
    Log.d('resssss ${event.comment.toJson()}');

    final response = await client.commentsPost(body: event.comment);
    Log.d('the comment ${response.body}');
    if (response.statusCode == 201) {
      if (event.comment.normalPostId != null) {
        final res = await client.commentsNormalPostCommentsNormalPostIdGet(
          normalPostId: event.comment.normalPostId,
          pageNumber: 1,
          pageSize: 30,
        );
        if (res.statusCode == 200) {
          emit(CommentLoadedState(res.body!));
        }
      } else {
        final res = await client.commentsDeliveryPostCommentsDeliveryPostIdGet(
          deliveryPostId: event.comment.deliveryPostId,
          pageNumber: 1,
          pageSize: 30,
        );
        if (res.statusCode == 200) {
          emit(CommentLoadedState(res.body!));
        }
      }
    } else {
      emit(CommentErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapGetNormalPostsEventToState(
      GetAllNormalPostsEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoadingState());
    var client = CarshopSDK().client;

    final response = event.commentId == null
        ? await client.commentsNormalPostCommentsNormalPostIdGet(
            normalPostId: event.normalPostId,
            pageNumber: 1,
            pageSize: 30,
          )
        : await client.commentsCommentRepliesCommentIdGet(
            commentId: event.commentId,
            pageNumber: 1,
            pageSize: 30,
          );
    if (response.statusCode == 200) {
      emit(
        CommentLoadedState(response.body!),
      );
    } else {
      emit(CommentErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapDeleteCommentEventToState(
      DeleteCommentEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoadingState());
    var client = CarshopSDK().client;
    final response = await client.commentsIdDelete(id: event.commentId);
    if (response.statusCode == 200) {
      event.comments.comments
          .removeWhere((element) => element.commentId == event.commentId);
      emit(CommentLoadedState(event.comments));
    } else {
      emit(CommentErrorState(response.error.toString()));
    }
  }

  FutureOr<void> _mapGetAllDeliveryPostsEventToState(
      GetAllDeliveryPostsEvent event, Emitter<CommentState> emit) async {
    emit(CommentLoadingState());
    var client = CarshopSDK().client;
    Log.d('icomiong ${event.commentId}');

    final response = event.commentId == null
        ? await client.commentsDeliveryPostCommentsDeliveryPostIdGet(
            deliveryPostId: event.deliveryPostId,
            pageNumber: 1,
            pageSize: 30,
          )
        : await client.commentsCommentRepliesCommentIdGet(
            commentId: event.commentId,
            pageNumber: 1,
            pageSize: 30,
          );
    print('the bodu ${response.body}');
    if (response.statusCode == 200) {
      emit(
        CommentLoadedState(response.body!),
      );
    } else {
      emit(CommentErrorState(response.error.toString()));
    }
  }
}
