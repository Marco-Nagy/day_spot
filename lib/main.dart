import 'package:employees_attendance/Authentication/presentation/provider/AuthenticationProvider.dart';
import 'package:employees_attendance/Authentication/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // load env
  await dotenv.load();
  //initial SupaBase
  String supaBaseUrl = dotenv.env['SUPABASE_URL'] ?? '';
  String supaBaseKey = dotenv.env['SUPABASE_KEY'] ?? '';
  await Supabase.initialize(url: supaBaseUrl, anonKey: supaBaseKey);
  runApp(  const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers: [
      ChangeNotifierProvider<AuthenticationProvider>(
          create: (_) => AuthenticationProvider()),
    ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Employees Attendance',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const LoginScreen(),
      ),
    );
  }
}
