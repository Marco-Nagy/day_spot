// ignore_for_file: use_build_context_synchronously

import 'package:employees_attendance/Authentication/presentation/screens/login_screen.dart';
import 'package:employees_attendance/core/utils.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthenticationProvider extends ChangeNotifier {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  final SupabaseClient _supabaseClient = Supabase.instance.client;
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
      Utils.showSnackBar("Success ! ${emailController.text} you can now login", context,
          color: Colors.green);
      Future.delayed(const Duration(seconds: 2)).then((value) =>Navigator.push(context, MaterialPageRoute(builder: (context) => const LoginScreen(),)));
      setLoading = false;
    } catch (e) {
      setLoading = false;
      Utils.showSnackBar(e.toString(), context, color: Colors.red);
    }
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
