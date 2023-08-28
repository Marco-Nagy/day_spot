import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'AuthRepo.dart';

class AuthRepositoryImpl implements AuthRepo {
  SupabaseClient supabaseClient = Supabase.instance.client;

  AuthRepositoryImpl(this.supabaseClient);

  @override
  Future<Either<String, Unit>> signIn(String email, String password) async {
    try {
      final response = await supabaseClient.auth
          .signInWithPassword(email: email, password: password);
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> signUp(String email, String password) async {
    try {
      final response =
          await supabaseClient.auth.signUp(email: email, password: password);
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> signOut() async {
    try {
      final response = await supabaseClient.auth.signOut();
      return const Right(unit);
    } catch (e) {
      return Left(e.toString());
    }
  }
}
