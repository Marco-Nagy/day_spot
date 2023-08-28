import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, Unit>> signIn(String email, String password);

  Future<Either<String, Unit>> signUp(String email, String password);

  Future<Either<String, Unit>> signOut();
}
