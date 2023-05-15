import 'package:carshop_mobile/models/address/address.dart';
import '../utilities/api_keys.dart';
import '../utilities/api_request.dart';
import '../utilities/request_error.dart';
import 'package:dartz/dartz.dart';

class AddressRepository{
  final ApiRequest request;

  AddressRepository(this.request);

  Future<Either<RequestError,List<Address>>> getAllAddress( )async{
    List<Address> addresses = [];
    try {
      final response = await request.getList('${ApiKeys.baseUrl}/address');
      addresses = response.map((address) => Address.fromJson(address)).toList();
      return Right(addresses);
    } catch (e) {
      return Left(RequestError(e));
    }
  }


  Future<Either<RequestError,Address>> saveAddress(Address address)async{
    try {
      final response = await request.post('${ApiKeys.baseUrl}/address',body: address.toJson());
      return Right(Address.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }


  Future<Either<RequestError,Address>> getSingleAddress(String addressId )async{
    try {
      final response = await request.get('${ApiKeys.baseUrl}/address/$addressId');
      return Right(Address.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }
  Future<Either<RequestError,Address>>updateAddress(Address address )async{
    try {
      final response = await request.patch('${ApiKeys.baseUrl}/address/${address.addressId}',body: address.toJson());
      return Right(Address.fromJson(response));
    } catch (e) {
      return Left(RequestError(e));
    }
  }

  Future<Either<RequestError,void>> deleteAddress(String addressId )async{
    try {
      await request.delete('${ApiKeys.baseUrl}/address/$addressId');
      return const Right(null);
    } catch (e) {
      return Left(RequestError(e));
    }
  }
}