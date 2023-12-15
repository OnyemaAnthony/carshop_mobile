import 'dart:async';

import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'swipe_event.dart';
part 'swipe_state.dart';

class SwipeBloc extends Bloc<SwipePostEvent, SwipePostState> {
  SwipeBloc({
    required List<PublicNormalPostDescriptor> normalPosts,
    required List<PublicDeliveryPostDesc> deliveryPosts,
  }) : super(SwipePostLoadedState(normalPosts, deliveryPosts, 0,
            selectedDeliveryPost:
                deliveryPosts.isNotEmpty ? deliveryPosts[0] : null,
            selectedNormalPost:
                normalPosts.isNotEmpty ? normalPosts[0] : null)) {
    on<DeleteDeliveryPost>(_mapDeleteDeliveryPostEventToState);
    on<AcceptDeliveryPostEvent>(_mapAcceptDeliveryPostEventToState);
    on<LikeDeliveryPostEvent>(_mapLikeDeliveryPostEventToState);
    on<PostSwipedEvent>(_mapPostSwipedEventToState);
  }

  _mapDeleteDeliveryPostEventToState(
      DeleteDeliveryPost event, Emitter<SwipePostState> emit) async {
    emit(ActionOnGoingState(
        state.normalPosts, state.deliveryPosts, state.selectedPost));
    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.deliveryPostsIdDelete(id: event.postId);
    if (response.statusCode == 200) {
      emit(ActionDoneState(
          state.normalPosts, state.deliveryPosts, state.selectedPost,
          selectedDeliveryPost: state.selectedDeliveryPost));
    } else {
      emit(ActionFailedState(state.normalPosts, state.deliveryPosts,
          state.selectedPost, response.error.toString(),
          selectedDeliveryPost: state.selectedDeliveryPost));
    }
  }

  FutureOr<void> _mapAcceptDeliveryPostEventToState(
      AcceptDeliveryPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;
    Response<Delivery?> response =
        await client.deliveryPostsAcceptDeliveryPostIdPost(
            deliveryPostId: event.deliveryPostId);

    if (response.statusCode == 200) {
      emit(ActionDoneState(
          state.normalPosts, state.deliveryPosts, state.selectedPost,
          selectedDeliveryPost: state.selectedDeliveryPost));
    } else {
      emit(ActionFailedState(state.normalPosts, state.deliveryPosts,
          state.selectedPost, response.error.toString(),
          selectedDeliveryPost: state.selectedDeliveryPost));
    }
  }

  FutureOr<void> _mapLikeDeliveryPostEventToState(
      LikeDeliveryPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;

    Response<Object> response;
    PublicDeliveryPostDesc? newDPost;

    if (state.selectedDeliveryPost != null) {
      newDPost = state.selectedDeliveryPost!.copyWith(
          isLiked: !event.isLiked,
          likesCount: event.isLiked
              ? state.selectedDeliveryPost!.likesCount - 1
              : state.selectedDeliveryPost!.likesCount + 1);
    }

    if (event.isLiked) {
      response = await client.likesTypeContentIdDelete(
          contentId: event.deliveryPostId, contentType: "DELIVERY_POST");
    } else {
      response = await client.likesTypeContentIdPost(
          contentId: event.deliveryPostId, contentType: "DELIVERY_POST");
    }
    if (response.statusCode == 200) {
      emit(SwipePostLoadedState(
          state.normalPosts, state.deliveryPosts, state.selectedPost,
          selectedDeliveryPost: newDPost));
    } else {
      emit(ActionFailedState(state.normalPosts, state.deliveryPosts,
          state.selectedPost, response.error.toString(),
          selectedDeliveryPost: state.selectedDeliveryPost));
    }
  }

  FutureOr<void> _mapPostSwipedEventToState(
      PostSwipedEvent event, Emitter<SwipePostState> emit) {
    emit(SwipePostLoadedState(
        state.normalPosts, state.deliveryPosts, event.index,
        selectedNormalPost: state.normalPosts[event.index]));
  }
}
