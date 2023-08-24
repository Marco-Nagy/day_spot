import 'package:dartz/dartz.dart';
import 'package:employees_attendance/core/errors.dart';

abstract class AuthRepo{
  Future<Either<Errors,Unit>> signUp();
  Future signIn();

}