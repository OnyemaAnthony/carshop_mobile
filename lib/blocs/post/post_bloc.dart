import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carshop_mobile/models/post/delivery_post.dart';
import 'package:equatable/equatable.dart';

import '../../models/post/post_model.dart';
import '../../repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository? repository ;
  PostBloc({this.repository}) : super(PostInitial()) {
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
    on<DeleteDeliveryPostEvent>(_mapDeleteDeliveryPostEventToState);
  }

  FutureOr<void> _mapFetchPostsEventToState(FetchPostsEvent event, Emitter<PostState> emit) async{
    emit(PostLoadingState());
    final response =await repository!.fetchPosts();
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (addresses) {
      emit(PostLoadedState(addresses));
    });

  }

  FutureOr<void> _mapDeletePostEventToState(DeletePostEvent event, Emitter<PostState> emit)async {
    emit(PostLoadingState());
    final response =await repository!.deletePost(event.postId);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (r) {
      emit(PostDeletedState());
    });
  }

  FutureOr<void> _mapLikePostEventToState(LikePostEvent event, Emitter<PostState> emit)async {
    emit(PostLoadingState());
    final response =await repository!.likePost(event.postId);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (r) {
      emit(PostedState());
    });
  }

  FutureOr<void> _mapUnlikePostEventToState(UnlikePostEvent event, Emitter<PostState> emit) async{
    emit(PostLoadingState());
    final response =await repository!.unlikePost(event.postId);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (r) {
      emit(PostedState());
    });
  }

  FutureOr<void> _mapSavePostEventToState(SavePostEvent event, Emitter<PostState> emit) async{
    emit(PostLoadingState());
    final response =await repository!.savePost(event.postModel);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (post) {
      emit(PostLoadState(post));
    });
  }

  FutureOr<void> _mapUpdatePostEventToState(UpdatePostEvent event, Emitter<PostState> emit) async{
    emit(PostLoadingState());
    final response =await repository!.updatePost(event.postModel);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (post) {
      emit(PostLoadState(post));
    });
  }

  FutureOr<void> _mapSaveDeliveryPostEventToState(SaveDeliveryPostEvent event, Emitter<PostState> emit)async {
    emit(DeliveryPostLoadingState());
    final response =await repository!.saveDeliveryPost(event.deliveryPost);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (deliveryPost) {
      emit(PostDeliveredState(deliveryPost));
    });
  }

  FutureOr<void> _mapGetMyDeliveryPostEventToState(GetMyDeliveryPostEvent event, Emitter<PostState> emit) async{
    emit(DeliveryPostLoadingState());
    final response =await repository!.getMyDeliveryPost(event.creatorId);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (deliveryPosts) {
      emit(DeliveryPostLoadedState(deliveryPosts));
    });
  }

  FutureOr<void> _mapGetSingleDeliveryPostEventToState(GetSingleDeliveryPostEvent event, Emitter<PostState> emit)async {
    emit(DeliveryPostLoadingState());
    final response =await repository!.getSingleDeliveryPost(event.deliveryPostId);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (deliveryPost) {
      emit(PostDeliveredState(deliveryPost));
    });

  }

  FutureOr<void> _mapUpdateDeliveryPostEventToState(UpdateDeliveryPostEvent event, Emitter<PostState> emit) async{
    emit(DeliveryPostLoadingState());
    final response =await repository!.updateDeliveryPost(event.deliveryPost);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (deliveryPost) {
      emit(PostDeliveredState(deliveryPost));
    });


  }

  FutureOr<void> _mapDeleteDeliveryPostEventToState(DeleteDeliveryPostEvent event, Emitter<PostState> emit) async{
    emit(DeliveryPostLoadingState());
    final response =await repository!.deleteDeliveryPost(event.deliveryPostId);
    response.fold((l) {
      emit(PostErrorState(l.message));
    }, (r) {
      emit(PostedState());
    });

  }
}
