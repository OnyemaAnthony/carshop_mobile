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
          normalPostId: 0,
          deliveryPostId: 0,
          errorMessage: null,
          message: null,
        )) {
    on<DeleteDeliveryPost>(_mapDeleteDeliveryPostEventToState);
    on<AcceptDeliveryPostEvent>(_mapAcceptDeliveryPostEventToState);
    on<LikeDeliveryPostEvent>(_mapLikeDeliveryPostEventToState);
    on<LikeNormalPostEvent>(_mapLikeNormalPostEventToState);
    on<PostSwipedEvent>(_mapPostSwipedEventToState);
    on<PageIsReadyEvent>(_mapPageIsReadyEventToState);
    on<InitializePageEvent>(_mapInitializePageEventToState);
    on<GetNormalPostEvent>(_mapGetNormalPostEventToState);
    on<RefreshNormalPostEvent>(_mapRefreshNormalPostEventToState);
  }

  _mapDeleteDeliveryPostEventToState(
      DeleteDeliveryPost event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;
    await client.deliveryPostsIdDelete(id: event.postId);
  }

  FutureOr<void> _mapGetNormalPostEventToState(
      GetNormalPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;
    Response<PublicNormalPostDescriptor> response =
        await client.normalPostsIdGet(id: event.id);

    if (response.statusCode == 200 && response.body != null) {
      state.normalPosts[state.normalPostId] = response.body!;

      emit(state.copyWith(
          message: SwipeBlocMessages.postRefreshed,
          updatedSelectedNormalPost: response.body));
    } else {
      emit(state.copyWith(
          errorMessage: response.error.toString(),
          pageStatus: PageStatus.error));
    }
  }

  FutureOr<void> _mapAcceptDeliveryPostEventToState(
      AcceptDeliveryPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;
    Response<Delivery?> response =
        await client.deliveryPostsAcceptDeliveryPostIdPost(
            deliveryPostId: event.deliveryPostId);

    if (response.statusCode == 200) {
      emit(state.copyWith(message: SwipeBlocMessages.deliveryPostAccepted));
    } else {
      emit(state.copyWith(
          message: SwipeBlocMessages.deliveryPostAcceptionFailed,
          errorMessage: response.error.toString(),
          pageStatus: PageStatus.error));
    }
  }

  FutureOr<void> _mapLikeDeliveryPostEventToState(
      LikeDeliveryPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;

    Response<Object> response;
    PublicDeliveryPostDesc? newDPost;
    int selectedDeliveryPostId = state.deliveryPostId;

    PublicDeliveryPostDesc? selectedDeliveryPost = state.selectedDeliveryPost;
    if (selectedDeliveryPost == null) {
      throw Exception("selectedDeliveryPost is null");
    }

    newDPost = selectedDeliveryPost.copyWith(
        isLiked: !selectedDeliveryPost.isLiked,
        likesCount: selectedDeliveryPost.isLiked
            ? selectedDeliveryPost.likesCount - 1
            : selectedDeliveryPost.likesCount + 1);

    emit(state.copyWith(
      toUpdateDeliveryPostId: selectedDeliveryPostId,
      updatedSelectedDeliveryPost: newDPost,
    ));

    if (selectedDeliveryPost.isLiked) {
      response = await client.likesTypeContentIdDelete(
          contentId: selectedDeliveryPost.deliveryPostId,
          type: "DELIVERY_POST");
    } else {
      response = await client.likesTypeContentIdPost(
          contentId: selectedDeliveryPost.deliveryPostId,
          type: "DELIVERY_POST");
    }

    if (response.statusCode == 200) {
      emit(state.copyWith(
          message: newDPost.isLiked
              ? SwipeBlocMessages.postLiked
              : SwipeBlocMessages.postDisliked));
    } else {
      emit(state.copyWith(
          message: newDPost.isLiked
              ? SwipeBlocMessages.failedToLikePost
              : SwipeBlocMessages.failedToDislikePost,
          errorMessage: response.error.toString(),
          pageStatus: PageStatus.error));
    }
  }

  FutureOr<void> _mapPostSwipedEventToState(
      PostSwipedEvent event, Emitter<SwipePostState> emit) {
    emit(state.copyWith(
      normalPostId: event.index,
    ));
  }

  FutureOr<void> _mapLikeNormalPostEventToState(
      LikeNormalPostEvent event, Emitter<SwipePostState> emit) async {
    CarshopClientSdk client = CarshopSDK().client;

    Response<Object> response;
    PublicNormalPostDescriptor? newNPost;
    int selectedNormalPostId = state.normalPostId;

    PublicNormalPostDescriptor? selectedNormalPost = state.selectedNormalPost;
    if (selectedNormalPost == null) {
      throw Exception("selectedNormalPost is null");
    }

    newNPost = selectedNormalPost.copyWith(
        isLiked: !selectedNormalPost.isLiked,
        likesCount: selectedNormalPost.isLiked
            ? selectedNormalPost.likesCount - 1
            : selectedNormalPost.likesCount + 1);

    emit(state.copyWith(
      toUpdateNormalPostId: selectedNormalPostId,
      updatedSelectedNormalPost: newNPost,
    ));

    if (selectedNormalPost.isLiked) {
      response = await client.likesTypeContentIdDelete(
          contentId: selectedNormalPost.normalPostId, type: "NORMAL_POST");
    } else {
      response = await client.likesTypeContentIdPost(
          contentId: selectedNormalPost.normalPostId, type: "NORMAL_POST");
    }
    if (response.statusCode == 200) {
      emit(state.copyWith(
          message: newNPost.isLiked
              ? SwipeBlocMessages.postLiked
              : SwipeBlocMessages.postDisliked));
    } else {
      emit(state.copyWith(
          message: newNPost.isLiked
              ? SwipeBlocMessages.failedToLikePost
              : SwipeBlocMessages.failedToDislikePost,
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

  dynamic getPost(int index) {
    return state.normalPosts[index];
    //return every 4 normalposts a deliverypost
    // if (index % 4 == 0 && index != 0) {
    //   return state.deliveryPosts[index ~/ 4];
    // } else {
    //   return state.normalPosts[index];
    // }
  }

  FutureOr<void> _mapRefreshNormalPostEventToState(
      RefreshNormalPostEvent event, Emitter<SwipePostState> emit) async {
    int selectedNormalPostIndex = state.normalPostId;
    String? selectedNormalPostId = state.selectedNormalPost?.normalPostId;

    if (selectedNormalPostId == null) {
      throw Exception("selectedNormalPostId is null");
    }

    emit(state.copyWith(
      pageStatus: PageStatus.loading,
    ));

    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.normalPostsIdGet(id: selectedNormalPostId);

    if (response.statusCode == 200 && response.body != null) {
      emit(state.copyWith(
        message: SwipeBlocMessages.postRefreshed,
        toUpdateNormalPostId: selectedNormalPostIndex,
        updatedSelectedNormalPost: response.body,
      ));
    } else {
      emit(state.copyWith(
          errorMessage: response.error.toString(),
          message: SwipeBlocMessages.failedToRefreshPost,
          pageStatus: PageStatus.error));
    }
  }
}
