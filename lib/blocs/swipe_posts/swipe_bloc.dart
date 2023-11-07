import 'dart:async';
import 'dart:math';
import 'package:appinio_swiper/controllers.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipePostEvent, SwipePostState> {
  SwipeBloc(
      {required List<NormalPost> normalPosts,
      required List<PublicDeliveryPostDesc> deliveryPosts})
      : super(SwipePostLoadedState(
            normalPosts, deliveryPosts, 0, AppinioSwiperController())) {
    on<SwipeLeft>(
        (event, state) => _mapSwipeEventToState(event, state, left: true));
    on<SwipeRight>(
        (event, state) => _mapSwipeEventToState(event, state, left: false));

    on<DeleteDeliveryPost>(
        (event, state) => _mapDeleteDeliveryPostEventToState(event, state));
  }

  FutureOr<void> _mapSwipeEventToState(
      SwipePostEvent event, Emitter<SwipePostState> emit,
      {bool left = false}) async {
    int selectedPost = state.selectedPost;
    selectedPost = max(
        0, min(state.posts.length, left ? selectedPost + 1 : selectedPost - 1));
    emit(SwipePostLoadedState(state.posts, state.deliveryPosts,
        state.selectedPost, state.swiperController));
  }

  _mapDeleteDeliveryPostEventToState(
      DeleteDeliveryPost event, Emitter<SwipePostState> emit) async {
    emit(ActionOnGoingState(state.posts, state.deliveryPosts,
        state.selectedPost, state.swiperController));
    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.deliveryPostsIdDelete(id: event.postId);
    if (response.statusCode == 200) {
      emit(ActionDoneState(state.posts, state.deliveryPosts, state.selectedPost,
          state.swiperController));
    } else {
      emit(ActionFailedState(
          state.posts,
          state.deliveryPosts,
          state.selectedPost,
          state.swiperController,
          response.error.toString()));
    }
  }
}
