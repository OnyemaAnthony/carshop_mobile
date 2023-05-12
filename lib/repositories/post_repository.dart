import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/models/post_model.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import '../utilities/request_error.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttertoast/fluttertoast.dart';

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


  Future<Either<RequestError,PostModel>> savePost(PostModel postModel)async{
    try {
      final response = await request.post('url',body: postModel.toJson());
      return Right(PostModel.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }

  }

  Future<Either<RequestError,void>> deletePost(String  postId)async {
    try {
      await request.patch('url$postId');
      UiUtilities.showToast(message: "Post deleted", toast: Toast.LENGTH_SHORT);
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }

}