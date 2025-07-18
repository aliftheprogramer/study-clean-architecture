import 'package:dartz/dartz.dart';

abstract class ProfileApiService {
  Future<Either> getUser();
}

class ProfileApiServiceImpl implements ProfileApiService {
  @override
  Future<Either> getUser() {
    // TODO: implement getUser
    throw UnimplementedError();
  }
}
