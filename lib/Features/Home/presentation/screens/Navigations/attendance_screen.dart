import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:slide_to_act_reborn/slide_to_act_reborn.dart';

class AttendanceScreen extends StatelessWidget {
  AttendanceScreen({Key? key}) : super(key: key);
  final GlobalKey<SlideActionState> slideKye = GlobalKey<SlideActionState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                'Welcome',
                style: GoogleFonts.aBeeZee(color: Colors.black54, fontSize: 30),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 5),
              child: Text(
                'Employee Name',
                style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 25),
              ),
            ),
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                'Today\'s Status',
                style: GoogleFonts.aBeeZee(color: Colors.black54, fontSize: 20),
              ),
            ),
            Card(
              elevation: 16,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              color: Colors.white,
              surfaceTintColor: Colors.white,
              shape: const OutlineInputBorder(
                borderSide:
                    BorderSide(style: BorderStyle.solid, color: Colors.white),
                borderRadius: BorderRadius.all(Radius.circular(30)),
                gapPadding: 1,
              ),
              child: Container(
                height: 120,
                margin: const EdgeInsets.only(top: 12, bottom: 32),
                padding: const EdgeInsets.all(5),
                decoration: const BoxDecoration(
                  color: Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Check In',
                          style: GoogleFonts.aBeeZee(
                              color: Colors.black54, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 80,
                          child: Divider(),
                        ),
                        Text(
                          '9:25',
                          style: GoogleFonts.aBeeZee(fontSize: 25),
                        ),
                      ],
                    )),
                    Expanded(
                        child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Check Out',
                          style: GoogleFonts.aBeeZee(
                              color: Colors.black54, fontSize: 20),
                        ),
                        const SizedBox(
                          width: 80,
                          child: Divider(),
                        ),
                        Text(
                          '--:--',
                          style: GoogleFonts.aBeeZee(fontSize: 25),
                        ),
                      ],
                    )),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '15 April 2023',
                style: GoogleFonts.aBeeZee(fontSize: 20),
              ),
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '20:00:00 PM',
                style: GoogleFonts.aBeeZee(fontSize: 15, color: Colors.black54),
              ),
            ),
            Container(
              child: Builder(
                builder: (context) => SlideAction(
                  key: slideKye,
                  text: "Slide To Check Out",
                  textStyle:
                      GoogleFonts.aBeeZee(fontSize: 18, color: Colors.black54),
                  innerColor: Colors.redAccent,
                  outerColor: Colors.white,
                  onSubmit: (){
                    slideKye.currentState?.reset();
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
