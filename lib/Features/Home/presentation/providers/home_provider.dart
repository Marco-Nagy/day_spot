import 'package:employees_attendance/Features/Home/data/models/attendance_model.dart';
import 'package:employees_attendance/core/constants.dart';
import 'package:employees_attendance/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/data_base_services.dart';
import '../../../Authentication/data/models/user_model.dart';

class HomeProvider extends ChangeNotifier {
  DataBaseServices dataBaseServices = DataBaseServices();
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  int navigationIndex = 1;
  UserModel userModel =
      UserModel(name: '', employeeId: '', id: '', department: '', email: '');
  AttendanceModel attendanceModel = AttendanceModel(
      date: '', createdAt: '', checkIn: '', id: '', checkOut: '');
  String todayDate = DateFormat('dd MMM yyyy').format(DateTime.now());
  bool isVisible = false;
  bool _isLoading = false;

  get isLoading => _isLoading;

  set setLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  setNavigateIndex(int index) {
    navigationIndex = index;
    notifyListeners();
  }

  Future getUserData() async {
    userModel = await dataBaseServices.getUserData();
    notifyListeners();
  }

  Future getTodayAttendance() async {
    final List result = await _supabaseClient
        .from(Constants.attendanceTable)
        .select()
        .eq('employeeId', _supabaseClient.auth.currentUser!.id)
        .eq('date', todayDate);
    if (result.isNotEmpty) {
      attendanceModel = AttendanceModel.fromJson(result.first);
    }
    notifyListeners();
  }

  Future markAttendance(BuildContext context) async {
    if (attendanceModel.checkIn == null || attendanceModel.checkIn.isEmpty) {
      await _supabaseClient.from(Constants.attendanceTable).insert({
        'employeeId': _supabaseClient.auth.currentUser!.id,
        'date': todayDate,
        'checkIn': DateFormat('hh:mm:ss a').format(DateTime.now()),
      });
    } else if (attendanceModel.checkOut == null ||
        attendanceModel.checkOut.isEmpty) {
      await _supabaseClient
          .from(Constants.attendanceTable)
          .update({
            'checkOut': DateFormat('hh:mm:ss a').format(DateTime.now()),
          })
          .eq(
            'employeeId',
            _supabaseClient.auth.currentUser!.id,
          )
          .eq('date', todayDate);
    }else{
      Utils.showSnackBar('You Have Checked Out Today !', context,color: Colors.blue);
    }
    getTodayAttendance();
  }
}
