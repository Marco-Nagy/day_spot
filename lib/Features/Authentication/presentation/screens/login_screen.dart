import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../provider/AuthenticationProvider.dart';
import 'register_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      body: Consumer(
        builder: (context, AuthProvider ap, child) {
          return SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  height: size.height / 3,
                  width: size.width,
                  decoration: const BoxDecoration(
                      color: Colors.redAccent,
                      borderRadius:
                          BorderRadius.only(bottomRight: Radius.circular(70))),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const FaIcon(Icons.fingerprint,
                            color: Colors.white, size: 80),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'Day Spot',
                          style: GoogleFonts.abel(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                        ),
                      ]),
                ),
                const SizedBox(
                  height: 50,
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: ap.emailController,
                        decoration: const InputDecoration(
                            label: Text('Employee Email Id'),
                            prefixIcon: Icon(Icons.person),
                            border: OutlineInputBorder()),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: ap.passwordController,
                        decoration: InputDecoration(
                            label: const Text('Password'),
                            prefixIcon: const Icon(FontAwesomeIcons.lock),
                            suffixIcon: IconButton(
                              onPressed: () {
                                ap.changePasswordVisibility();
                              },
                              icon: ap.isVisible
                                  ? const Icon(FontAwesomeIcons.eye)
                                  : const Icon(FontAwesomeIcons.eyeSlash),
                            ),
                            border: const OutlineInputBorder()),
                        obscureText: ap.isVisible == false,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 60,
                        width: double.infinity,
                        child: ap.isLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : ElevatedButton(
                                onPressed: () {
                                  ap.loginEmployee(
                                      ap.emailController.text.trim(),
                                      ap.passwordController.text.trim(),

                                      context);
                                },
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.redAccent,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                child: const Text(
                                  "LOGIN",
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegisterScreen()));
                          },
                          child: const Text(
                              "Are you a new Employee ? Register here"))
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
