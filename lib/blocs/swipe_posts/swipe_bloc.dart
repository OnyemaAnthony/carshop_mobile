import 'dart:async';
import 'dart:math';
import 'package:appinio_swiper/controllers.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipePostEvent, SwipePostState> {
  SwipeBloc({required List<dynamic> normalPosts})
      : super(SwipePostLoadedState(normalPosts, 0, AppinioSwiperController())) {
    on<SwipeLeft>(
        (event, state) => _mapSwipeEventToState(event, state, left: true));
    on<SwipeRight>(
        (event, state) => _mapSwipeEventToState(event, state, left: false));
  }

  FutureOr<void> _mapSwipeEventToState(
      SwipePostEvent event, Emitter<SwipePostState> emit,
      {bool left = false}) async {
    int selectedPost = state.selectedPost;

    selectedPost = max(
        0, min(state.posts.length, left ? selectedPost + 1 : selectedPost - 1));

    emit(SwipePostLoadedState(
        state.posts, state.selectedPost, state.swiperController));
  }
}
