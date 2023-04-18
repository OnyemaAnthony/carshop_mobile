import 'package:carshop_mobile/api_request.dart';
import 'package:carshop_mobile/request_error.dart';
import 'package:dartz/dartz.dart';
import 'package:carshop_mobile/models/user_model.dart';

class UserRepository {
  final ApiRequest request;
  UserRepository(this.request);

  Future<Either<RequestError, UserModel>> signUp(UserModel user) async {
    try {
      final response = await request.post('url',body: user.toJson());

      return Right(UserModel.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }
}
