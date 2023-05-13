import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

import '../../models/post/post_model.dart';
import '../../repositories/post_repository.dart';

part 'post_event.dart';
part 'post_state.dart';

class PostBloc extends Bloc<PostEvent, PostState> {
  final PostRepository? repository ;

  PostBloc({this.repository}) : super(PostInitial()) {
    on<FetchPostsEvent>(_mapFetchPostsEventToState);
  }

  FutureOr<void> _mapFetchPostsEventToState(FetchPostsEvent event, Emitter<PostState> emit) async{

  }
}
