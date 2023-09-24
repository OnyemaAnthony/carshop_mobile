import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:carshop_clientsdk/carshop_clientsdk.dart';
import 'package:equatable/equatable.dart';

import '../../repositories/carhsop_sdk.dart';

part 'comment_event.dart';
part 'comment_state.dart';

class CommentBloc extends Bloc<CommentEvent, CommentState> {
  CommentBloc() : super(CommentInitial()) {
    on<CreateCommentEvent>(_mapCreateCommentEventToState);
  }

  FutureOr<void> _mapCreateCommentEventToState(CreateCommentEvent event, Emitter<CommentState> emit) async{
    var client = CarshopSDK().client;
    
   final response = await client.commentsPost(body: event.commentDto);
   print('the response is ${response.body}');
   if(response.statusCode == 201){
     emit(CommentedState());
   }else{
     emit(CommentErrorState(response.error.toString()));
   }

  }
}
