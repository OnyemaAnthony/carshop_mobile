import 'dart:async';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:carshop_mobile/repositories/carhsop_sdk.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:logger/logger.dart';

import '../../utilities/local_storage.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  PostBloc() : super(const InitialState()) {
    on<FetchPostsEvent>(_mapFetchPostsEventToState);
    on<DeletePostEvent>(_mapDeletePostEventToState);
    on<LikePostEvent>(_mapLikePostEventToState);
    on<UnlikePostEvent>(_mapUnlikePostEventToState);
    on<SavePostEvent>(_mapSavePostEventToState);
    on<UpdatePostEvent>(_mapUpdatePostEventToState);
    on<SaveDeliveryPostEvent>(_mapSaveDeliveryPostEventToState);
    on<GetMyDeliveryPostEvent>(_mapGetMyDeliveryPostEventToState);
    on<GetSingleDeliveryPostEvent>(_mapGetSingleDeliveryPostEventToState);
    on<UpdateDeliveryPostEvent>(_mapUpdateDeliveryPostEventToState);
    on<FetchMyPostsEvent>(_mapFetchMyPostsEventToState);
  }

  FutureOr<void> swipeLeft() async {}

  FutureOr<void> _mapFetchPostsEventToState(
      FetchPostsEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));

    //TODO: pass location to the body
    // GetManyPostsDto body = GetManyPostsDto();

    // var client = CarshopSDK().client;
    // final response = await client.normalPostsIdGet(id: body);
    // var result = response.body;
    // if (result != null) {
    //   emit(PostLoadedState(result));
    // } else {
    //   emit(PostErrorState(response.error.toString()));
    // }
  }

  FutureOr<void> _mapDeletePostEventToState(
      DeletePostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    // final response = await client.normalPostsIdDelete(id: event.postId);

    // if (response.statusCode == 200) {
    //   emit(PostDeletedState());
    // } else {
    //   emit(PostErrorState(response.error.toString()));
    // }
  }

  FutureOr<void> _mapLikePostEventToState(
      LikePostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    // final response = await client.likesAggTotalTypeGet(
    //     type: LikesAggTotalTypeGetType.post, contentIds: event.postId);

    // if (response.statusCode == 200) {
    //   emit(PostedState());
    // } else {
    //   emit(PostErrorState(response.error.toString()));
    // }
  }

  FutureOr<void> _mapUnlikePostEventToState(
      UnlikePostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    // final response = await client.likesTypeContentIdDelete(
    //     contentId: event.postId, type: LikesTypeContentIdDeleteType.post);

    // if (response.statusCode == 200) {
    //   emit(PostedState());
    // } else {
    //   emit(PostErrorState(response.error.toString()));
    // }
  }

  FutureOr<void> _mapSavePostEventToState(
      SavePostEvent event, Emitter<PostState> emit) async {
    final logger = Logger();
    emit(DataLoadingState(state.deliveryPosts, state.posts));

    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.normalPostsPost(
      body: event.createDto,
    );
    if (response.statusCode == 201) {
      emit(CreatedState(state.deliveryPosts, state.posts));
    } else {
      emit(PostErrorState(
          response.error.toString(), state.deliveryPosts, state.posts));
    }
  }

  FutureOr<void> _mapUpdatePostEventToState(
      UpdatePostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    // final response = await client.normalPostsIdPatch(
    //     id: event.id, body: event.updatePostDto);
    // if (response.statusCode == 200) {
    //   emit(PostedState());
    // } else {
    //   emit(PostErrorState(response.error.toString()));
    // }
  }

  FutureOr<void> _mapSaveDeliveryPostEventToState(
      SaveDeliveryPostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.deliveryPostsPost(body: event.createDPDto);
    if (response.statusCode == 201) {
      emit(CreatedState(state.deliveryPosts, state.posts));
    } else {
      emit(PostErrorState(
          response.error.toString(), state.deliveryPosts, state.posts));
    }
  }

  FutureOr<void> _mapGetMyDeliveryPostEventToState(
      GetMyDeliveryPostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));

    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.deliveryPostsMyGet();
    if (response.statusCode == 200) {
      emit(DataReadyState(response.body!, state.posts));
    } else {
      emit(PostErrorState(
          response.error.toString(), state.deliveryPosts, state.posts));
    }
  }

  FutureOr<void> _mapGetSingleDeliveryPostEventToState(
      GetSingleDeliveryPostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    final response = await client.deliveryPostsIdGet(id: event.deliveryPostId);

    // if (response.statusCode == 200) {
    //   emit(PostDeliveredState(response.body!));
    // } else {
    //   emit(PostErrorState(response.error.toString()));
    // }
  }

  FutureOr<void> _mapUpdateDeliveryPostEventToState(
      UpdateDeliveryPostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    //CarshopClientSdk client = CarshopSDK().client;
    //final response =
    //     await client.deliverypo(id: event.id, body: event.updateDPDto);
    // if (response.statusCode == 200) {
    //   emit(DeliveryPostLoadState(response.body!));
    // } else {
    //   emit(PostErrorState(response.error.toString()));
    // }
  }

  FutureOr<void> _mapDeleteDeliveryPostEventToState(
      DeleteDeliveryPostEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    final response =
        await client.deliveryPostsIdDelete(id: event.deliveryPostId);
    if (response.statusCode == 200) {
      emit(CreatedState(state.deliveryPosts, state.posts));
    } else {
      emit(PostErrorState(
          response.error.toString(), state.deliveryPosts, state.posts));
    }
  }

  FutureOr<void> _mapFetchMyPostsEventToState(
      FetchMyPostsEvent event, Emitter<PostState> emit) async {
    emit(DataLoadingState(state.deliveryPosts, state.posts));
    CarshopClientSdk client = CarshopSDK().client;
    String accessToken = await LocalStorage.getString('access_token');
    Map<String, dynamic> userTokenMap = Jwt.parseJwt(accessToken);
    String userId = userTokenMap['data']['userId'];

    ///Todo: change the way we get userId
    //   GetManyPostsDto getManyPostsDto = GetManyPostsDto(ownerIds: [userId]);
    //   final response = await client.normalPostsGet(body: getManyPostsDto);

    //   if (response.statusCode == 200) {
    //     emit(PostLoadedState(response.body!));
    //   } else {
    //     emit(PostErrorState(response.error.toString()));
    //   }
  }
}
