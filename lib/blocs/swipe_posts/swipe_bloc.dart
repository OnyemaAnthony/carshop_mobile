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
  }) : super(SwipePostState(
            pageStatus: PageStatus.initial,
            normalPosts: normalPosts,
            deliveryPosts: deliveryPosts,
            selectedPost: 0,
            selectedDeliveryPost:
                deliveryPosts.isNotEmpty ? deliveryPosts[0] : null,
            selectedNormalPost:
                normalPosts.isNotEmpty ? normalPosts[0] : null)) {
    on<DeleteDeliveryPost>(_mapDeleteDeliveryPostEventToState);
    on<AcceptDeliveryPostEvent>(_mapAcceptDeliveryPostEventToState);
    on<LikeDeliveryPostEvent>(_mapLikeDeliveryPostEventToState);
    on<LikeNormalPostEvent>(_mapLikeNormalPostEventToState);
    on<PostSwipedEvent>(_mapPostSwipedEventToState);
    on<PageIsReadyEvent>(_mapPageIsReadyEventToState);
    on<InitializePageEvent>(_mapInitializePageEventToState);
  }

  _mapDeleteDeliveryPostEventToState(
      DeleteDeliveryPost event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;
    await client.deliveryPostsIdDelete(id: event.postId);
  }

  FutureOr<void> _mapAcceptDeliveryPostEventToState(
      AcceptDeliveryPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;
    Response<Delivery?> response =
        await client.deliveryPostsAcceptDeliveryPostIdPost(
            deliveryPostId: event.deliveryPostId);

    if (response.statusCode == 200) {
      emit(state.copyWith(successfulAction: event));
    } else {
      emit(state.copyWith(
          successfulAction: null,
          errorMessage: response.error.toString(),
          pageStatus: PageStatus.error));
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
          contentId: event.deliveryPostId, type: "DELIVERY_POST");
    } else {
      response = await client.likesTypeContentIdPost(
          contentId: event.deliveryPostId, type: "DELIVERY_POST");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(
          successfulAction: event, selectedDeliveryPost: newDPost));
    } else {
      emit(state.copyWith(
          successfulAction: null,
          errorMessage: response.error.toString(),
          pageStatus: PageStatus.error));
    }
  }

  FutureOr<void> _mapPostSwipedEventToState(
      PostSwipedEvent event, Emitter<SwipePostState> emit) {
    emit(state.copyWith(
        selectedPost: event.index,
        selectedNormalPost: state.normalPosts[event.index]));
  }

  FutureOr<void> _mapLikeNormalPostEventToState(
      LikeNormalPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;

    Response<Object> response;
    PublicNormalPostDescriptor? newNPost;

    if (state.selectedNormalPost != null) {
      newNPost = state.selectedNormalPost!.copyWith(
          isLiked: !event.isLiked,
          likesCount: event.isLiked
              ? state.selectedNormalPost!.likesCount - 1
              : state.selectedNormalPost!.likesCount + 1);
    }

    if (event.isLiked) {
      response = await client.likesTypeContentIdDelete(
          contentId: event.normalPost, type: "NORMAL_POST");
    } else {
      response = await client.likesTypeContentIdPost(
          contentId: event.normalPost, type: "NORMAL_POST");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(
          successfulAction: event, selectedNormalPost: newNPost));
    } else {
      emit(state.copyWith(
          successfulAction: null,
          errorMessage: response.error.toString(),
          pageStatus: PageStatus.error));
    }
  }

  FutureOr<void> _mapPageIsReadyEventToState(
      PageIsReadyEvent event, Emitter<SwipePostState> emit) {
    emit(state.copyWith(pageStatus: PageStatus.ready));
  }

  FutureOr<void> _mapInitializePageEventToState(
      InitializePageEvent event, Emitter<SwipePostState> emit) {
    emit(state.copyWith(pageStatus: PageStatus.initializing));
  }
}
