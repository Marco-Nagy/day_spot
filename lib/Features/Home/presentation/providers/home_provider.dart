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
  List attendanceHistoryList = [];
  String todayDate = DateFormat('dd MMM yyyy').format(DateTime.now());
  bool isVisible = false;
  bool _isLoading = false;

  set attendanceHistoryMonth(String value) {
    _attendanceHistoryMonth = value;
    notifyListeners();
  }

  String _attendanceHistoryMonth =
      DateFormat('MMM yyyy').format(DateTime.now());

  String get attendanceHistoryMonth => _attendanceHistoryMonth;

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
    if (userModel.employeeId != dataBaseServices.uniqueCode) {
      Utils.showSnackBar('بلاش الحركات دي .. متعملش كدة تانى ', context,
          color: Colors.red);
    } else if ((attendanceModel.checkIn == null ||
            attendanceModel.checkIn.isEmpty) &&
        userModel.employeeId == dataBaseServices.uniqueCode) {
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
    } else {
      Utils.showSnackBar('You Have Checked Out Today !', context,
          color: Colors.blue);
    }
    getTodayAttendance();
  }

  Future<List<AttendanceModel>> getAttendanceHistory() async {
    _isLoading = true;
    attendanceHistoryList = await _supabaseClient
        .from(Constants.attendanceTable)
        .select()
        .eq('employeeId', _supabaseClient.auth.currentUser!.id)
        .textSearch('date', "'$attendanceHistoryMonth'", config: 'english')
        .order('created_at', ascending: false);
    print(
        'attendance history ${attendanceHistoryList.map((attendance) => AttendanceModel.fromJson(attendance)).toList().toString()}');

    if (attendanceHistoryList != null) {
      _isLoading = false;
    }
    notifyListeners();
    return attendanceHistoryList
        .map((attendance) => AttendanceModel.fromJson(attendance))
        .toList();
  }
}
