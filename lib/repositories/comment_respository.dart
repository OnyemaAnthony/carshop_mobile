import 'package:carshop_mobile/models/comment/comment_request.dart';
import 'package:carshop_mobile/models/comment/comment_response.dart';
import '../utilities/api_keys.dart';
import '../utilities/api_request.dart';
import '../utilities/request_error.dart';
import 'package:dartz/dartz.dart';

class CommentRepository{
  final ApiRequest request;

  CommentRepository(this.request);

  Future<Either<RequestError,CommentResponse>> saveComment(CommentRequest commentRequest)async{
    try {
      final response = await request.post('${ApiKeys.baseUrl}/comments',body: commentRequest.toJson());
      return Right(CommentResponse.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }


  Future<Either<RequestError,List<CommentResponse>>> getAllComment(CommentResponse comment)async{
    List<CommentResponse> comments = [];

    try {
      final response = await request.getList('${ApiKeys.baseUrl}/comments',query: comment.toQuery());
      comments = response.map((comment) => CommentResponse.fromJson(comment)).toList();
      return Right(comments);
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<Either<RequestError,List<CommentResponse>>> getCommentHistory(CommentResponse comment)async{
    List<CommentResponse> comments = [];

    try {
      final response = await request.getList('${ApiKeys.baseUrl}/comments/history/${comment.commentId}',query: comment.toQuery());
      comments = response.map((comment) => CommentResponse.fromHistory(comment)).toList();
      return Right(comments);
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<Either<RequestError,CommentResponse>> updateComment(CommentRequest commentRequest)async{
    try {
      final response = await request.patch('${ApiKeys.baseUrl}/comments/${commentRequest.commentId}',body: commentRequest.toJson());
      return Right(CommentResponse.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<Either<RequestError,dynamic>> deleteComment(String commentId)async{
    try {
      final response = await request.delete('${ApiKeys.baseUrl}/comments/$commentId');
      return Right(response);
    } catch (e) {
      return Left(RequestError(e));
    }
  }

}