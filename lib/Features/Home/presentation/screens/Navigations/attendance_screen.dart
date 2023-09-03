import 'package:employees_attendance/Features/Home/presentation/providers/home_provider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:slide_to_act_reborn/slide_to_act_reborn.dart';

class AttendanceScreen extends StatefulWidget {
  const AttendanceScreen({Key? key}) : super(key: key);

  @override
  State<AttendanceScreen> createState() => _AttendanceScreenState();
}

class _AttendanceScreenState extends State<AttendanceScreen> {
  final GlobalKey<SlideActionState> slideKye = GlobalKey<SlideActionState>();
@override
  void initState() {
  HomeProvider hp = Provider.of<HomeProvider>(context,listen: false);
  hp.getUserData();
  hp.getTodayAttendance();
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer(
  builder: (context,HomeProvider hp, child) {
  return SingleChildScrollView(
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
                hp.userModel.name.isNotEmpty?hp.userModel.name:hp.userModel.email,
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
                          hp.attendanceModel.checkIn.isNotEmpty?hp.attendanceModel.checkIn:'--/--',
                          style: GoogleFonts.aBeeZee(fontSize: 22),
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
                          hp.attendanceModel.checkOut.isNotEmpty?hp.attendanceModel.checkOut:'--/--',
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
                DateFormat('dd MMM yyyy').format(DateTime.now()),
                style: GoogleFonts.aBeeZee(fontSize: 20),
              ),
            ),
            StreamBuilder(
              stream: Stream.periodic(const Duration(seconds: 1 )),
              builder: (context, snapshot) {
                return Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    DateFormat('hh : mm: ss a').format(DateTime.now()),
                    style: GoogleFonts.aBeeZee(fontSize: 15, color: Colors.black54),
                  ),
                );
              }
            ),
            Container(
              child: Builder(
                builder: (context) => SlideAction(
                  key: slideKye,
                  text:hp.attendanceModel.checkIn.isEmpty?"Slide To Check In" :"Slide To Check Out",
                  textStyle:
                      GoogleFonts.aBeeZee(fontSize: 18, color:hp.attendanceModel.checkIn.isEmpty? Colors.green:Colors.red),
                  innerColor: Colors.redAccent,
                  outerColor: Colors.white,
                  onSubmit: () async {
                  await  hp.markAttendance(context);
                    slideKye.currentState?.reset();
                  },
                ),
              ),
            )
          ],
        ),
      );
  },
),
    );
  }
}
