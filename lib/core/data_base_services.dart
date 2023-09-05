import 'dart:math';
import 'dart:io';
import 'package:device_info/device_info.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:employees_attendance/Features/Authentication/data/models/user_model.dart';
import 'package:employees_attendance/core/constants.dart';

class DataBaseServices {
  final SupabaseClient _supabase = Supabase.instance.client;
  UserModel userModel =
      UserModel(name: '', employeeId: '', id: '', department: '', email: '');
  String uniqueCode = '';
  Future<String> getUniqueCode() async {
    if (await Permission.phone.request().isGranted) {
      DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

      if (Platform.isAndroid) {
        AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
        uniqueCode = androidInfo.androidId;
      } else if (Platform.isIOS) {
        IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
        // String idfa =  iosInfo.identifierForVendor;
        uniqueCode = iosInfo.identifierForVendor;
      }
    } else {
      // Handle permission denial
    }
print('uniqueCode $uniqueCode');
    return uniqueCode;
  }
 static String generateRandomEmployeeId() {
    final random = Random();
    const allChars = "dayspotDAYSPOT0123456789";
    final randomString =
        List.generate(8, (index) => allChars[random.nextInt(allChars.length)])
            .join();
    return randomString;
  }

  Future insertNewUser(String email, var id) async {
    await getUniqueCode();
    await _supabase.from(Constants.employeeTable).insert({
      'id': id,
      'name': null,
      'email': email,
      'department': null,
      'employee_id':uniqueCode,
    });
  }

  Future<UserModel> getUserData() async {
    await getUniqueCode();
    final userData = await _supabase
        .from(Constants.employeeTable)
        .select()
        .eq('id', _supabase.auth.currentUser!.id)
        .single();
    userModel = UserModel.fromJson(userData);
    return userModel;
  }
}
