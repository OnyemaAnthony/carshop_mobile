import 'package:carshop_mobile/models/post/delivery_post.dart';
import 'package:carshop_mobile/utilities/api_keys.dart';
import 'package:carshop_mobile/utilities/api_request.dart';
import 'package:carshop_mobile/models/post/post_model.dart';
import 'package:carshop_mobile/utilities/services.dart';
import 'package:carshop_mobile/utilities/ui_utilities.dart';
import '../utilities/request_error.dart';
import 'package:dartz/dartz.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';

class PostRepository{
  final ApiRequest request;

  PostRepository(this.request);
  Future<Either<RequestError,List<PostModel>>> fetchPosts()async{
    List<PostModel> posts = [];
      try {
        final response = await request.getList('${ApiKeys.baseUrl}/posts');
        posts = response.map((post) =>PostModel.fromJson(post) ).toList();
        return Right(posts);
      } catch (e) {
        return Left(RequestError(e));
      }

  }

  Future<Either<RequestError,PostModel>> updatePost(PostModel post)async{
    try {
      final response = await request.patch('${ApiKeys.baseUrl}/posts/${post.postId}',body: post.toJson());
      return Right(PostModel.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }

  }


  Future<Either<RequestError,PostModel>> savePost(PostModel postModel)async{
    try {
      Services service = Services();
      Position position = await service.getUserCoordinate();
      postModel.lat = position.latitude;
       postModel.long = position.longitude;
      final response = await request.post('${ApiKeys.baseUrl}/posts',body: postModel.toJson());
      return Right(PostModel.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }

  }

  Future<Either<RequestError,void>> likePost(String  postId)async {
    try {
      await request.post('${ApiKeys.baseUrl}/post-likes/like/$postId');
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<Either<RequestError,void>> unlikePost(String  postId)async {
    try {
      await request.post('${ApiKeys.baseUrl}/post-likes/unlike/$postId');
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }


  Future<Either<RequestError,void>> deletePost(String  postId)async {
    try {
      await request.delete('${ApiKeys.baseUrl}/posts/$postId');
      UiUtilities.showToast(message: "Post deleted", toast: Toast.LENGTH_SHORT);
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  ///delevery posts

  Future<Either<RequestError,DeliveryPost>> saveDeliveryPost(DeliveryPost deliveryPost)async{
    try {
      final response = await request.post('${ApiKeys.baseUrl}/delivery-posts',body: deliveryPost.toJson());
      return Right(DeliveryPost.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }


  Future<Either<RequestError,List<DeliveryPost>>> getMyDeliveryPost(String creatorsId)async{
    List<DeliveryPost> myPosts = [];
    try {
      final response = await request.getList('${ApiKeys.baseUrl}/delivery-posts');
      myPosts = response.map((deliveryPost) => DeliveryPost.fromJson(deliveryPost)).toList();
      return Right(myPosts);
    } catch (e) {
      return Left(RequestError(e));
    }
  }
  Future<Either<RequestError,DeliveryPost>> getSingleDeliveryPost(String postId)async{
    try {
      final response = await request.get('${ApiKeys.baseUrl}/delivery-posts/$postId');
      return Right(DeliveryPost.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<Either<RequestError,DeliveryPost>> updateDeliveryPost(DeliveryPost deliveryPost)async{
    try {
      final response = await request.patch('${ApiKeys.baseUrl}/delivery-posts/${deliveryPost.id}',body: deliveryPost.toJson());
      return Right(DeliveryPost.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<Either<RequestError,void>> deleteDeliveryPost(String postId)async{
    try {
      request.delete('${ApiKeys.baseUrl}/delivery-posts/$postId');
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }
}