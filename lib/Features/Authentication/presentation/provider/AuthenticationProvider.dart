// ignore_for_file: use_build_context_synchronously

import 'package:employees_attendance/Features/Home/presentation/screens/home_screen.dart';
import 'package:employees_attendance/core/data_base_services.dart';
import 'package:employees_attendance/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../screens/login_screen.dart';

class AuthProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  final DataBaseServices _dataBaseServices = DataBaseServices();
  bool isVisible = false;
  bool _isLoading = false;

  get isLoading => _isLoading;

  set setLoading(value) {
    _isLoading = value;
    notifyListeners();
  }

  void changePasswordVisibility() {
    isVisible = !isVisible;
    notifyListeners();
  }

  Future registerEmployee(
      String email, String password, BuildContext context) async {
    try {
      setLoading = true;
      if (email.isEmpty || password.isEmpty) {
        throw ('All fields are Required');
      }
      final AuthResponse response =
          await _supabaseClient.auth.signUp(password: password, email: email);
   if(response !=null){
     await _dataBaseServices.insertNewUser(email, response.user!.id);
     Utils.showSnackBar("Successfully Registered  ! ${emailController.text} you can now login", context,
         color: Colors.green);
     setLoading = false;

     await  Future.delayed(const Duration(seconds: 2)).then((value) =>Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),)));
   }
    } catch (e) {
      setLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
      print(e.toString());
    }
    notifyListeners();
  }

  Future loginEmployee(
      String email, String password, BuildContext context) async {
    try {
      setLoading = true;
      if (email.isEmpty || password.isEmpty) {
        throw ('All fields are Required');
      }
      final AuthResponse response = await _supabaseClient.auth
          .signInWithPassword(password: password, email: email);
      setLoading = false;

      if(response!=null){
        Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const HomeScreen(),));
      }
    } catch (e) {
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
      setLoading = false;
    }
    notifyListeners();
  }

  Future signOut() async {
    await _supabaseClient.auth.signOut();
  }

  User? get currentAuth => _supabaseClient.auth.currentUser;
}
