import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

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
      body: Container(
        height: size.height / 3,
        width: size.width,
        decoration: const BoxDecoration(
            color: Colors.redAccent,
            borderRadius: BorderRadius.only(bottomRight: Radius.circular(70))),
        child:   Column(
          mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FaIcon(Icons.fingerprint,color: Colors.white,size: 80),
              SizedBox(height: 20,),
              Text('Day Spot',style: GoogleFonts.abel(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 25),)

        ]),
      ),
    );
  }
}
