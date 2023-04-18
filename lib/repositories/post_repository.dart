import 'package:carshop_mobile/api_request.dart';
import 'package:carshop_mobile/models/post_model.dart';
import '../request_error.dart';
import 'package:dartz/dartz.dart';

class PostRepository{
  final ApiRequest request;

  PostRepository(this.request);
  Future<Either<RequestError,List<PostModel>>> fetchPosts()async{
    List<PostModel> posts = [];
      try {
        final response = await request.getList('url');
        posts = response.map((post) =>PostModel.fromJson(post) ).toList();

        return Right(posts);
      } catch (e) {
        return Left(RequestError(e));
      }

  }
}