import 'dart:math';

import 'package:employees_attendance/Features/Authentication/data/models/user_model.dart';
import 'package:employees_attendance/core/constants.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DataBaseServices {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel userModel =
      UserModel(name: '', employeeId: '', id: '', department: '', email: '');

 static String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "dayspotDAYSPOT0123456789";
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await _supabase.from(Constants.employeeTable).insert({
      'id': id,
      'name': null,
      'email': email,
      'department': null,
      'employee_id': generateRandomEmployeeId(),
    });
  }

  Future<UserModel> getUserData() async {
    final userData = await _supabase
        .from(Constants.employeeTable)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userData);
    return userModel;
  }
}
