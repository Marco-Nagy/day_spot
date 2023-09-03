import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:simple_month_year_picker/simple_month_year_picker.dart';

import '../../providers/home_provider.dart';

class CalenderScreen extends StatefulWidget {
  const CalenderScreen({Key? key}) : super(key: key);

  @override
  _CalenderScreenState createState() => _CalenderScreenState();
}

class _CalenderScreenState extends State<CalenderScreen> {
  @override
  void initState() {
    HomeProvider hp = Provider.of<HomeProvider>(context, listen: false);
    // hp.getUserData();
    hp.getAttendanceHistory();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Consumer(
      builder: (context, HomeProvider hp, child) {
        return Column(
          children: [
            Container(
              alignment: Alignment.centerLeft,
              margin: const EdgeInsets.only(top: 60, bottom: 10, left: 20),
              child: Text(
                'My Attendance',
                style: GoogleFonts.aBeeZee(color: Colors.black54, fontSize: 30),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  hp.attendanceHistoryMonth.isNotEmpty
                      ? hp.attendanceHistoryMonth
                      : '',
                  style: GoogleFonts.aBeeZee(color: Colors.black, fontSize: 25),
                ),
                OutlinedButton(
                  onPressed: () async {
                    final selectedDate =
                        await SimpleMonthYearPicker.showMonthYearPickerDialog(
                            context: context,
                            disableFuture: true,
                            titleTextStyle: GoogleFonts.aBeeZee(
                                color: Colors.blueAccent, fontSize: 20),
                            monthTextStyle: GoogleFonts.aBeeZee(),
                            selectionColor: Colors.blueAccent);
                    String pickedMonth =
                        DateFormat('MMM yyyy').format(selectedDate);
                    hp.attendanceHistoryMonth = pickedMonth;
                    hp.getAttendanceHistory();
                  },
                  child: Text(
                    'Pick a Month',
                    style: GoogleFonts.aBeeZee(
                        color: Colors.blueAccent, fontSize: 20),
                  ),
                ),
              ],
            ),
            hp.isLoading == true
                ? const LinearProgressIndicator(
                    backgroundColor: Colors.white,
                    color: Colors.grey,
                  )
                : hp.attendanceHistoryList.isEmpty
                    ? Expanded(
                      child: Center(
                          child: Text(
                            'No Data Available',
                            style: GoogleFonts.aBeeZee(
                                color: Colors.black54, fontSize: 20),
                          ),
                        ),
                    )
                    : Expanded(
                        child: ListView.builder(
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Card(
                              elevation: 16,
                              clipBehavior: Clip.antiAliasWithSaveLayer,

                              // color: Colors.white,
                              // surfaceTintColor: Colors.white,
                              shape: const OutlineInputBorder(
                                borderSide: BorderSide(
                                    style: BorderStyle.none),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                // gapPadding: 1,
                              ),
                              child: Container(
                                height: 150,
                                padding:
                                    const EdgeInsets.only(right:  12),
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Card(
                                        clipBehavior: Clip.antiAlias,
                                        margin: EdgeInsets.zero,
                                        color: Colors.redAccent,
                                        surfaceTintColor: Colors.redAccent,
                                        shape: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              style: BorderStyle.solid,
                                              color: Colors.redAccent),
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                        ),
                                        child: Container(
                                          height: double.infinity,
                                          decoration: const BoxDecoration(
                                            color: Colors.redAccent,
                                          ),
                                          child: Center(
                                            child: Text(
                                              DateFormat('EE \n dd').format(
                                                  DateTime.parse(
                                                      hp.attendanceHistoryList[
                                                          index]['created_at'])),
                                              style: GoogleFonts.aBeeZee(
                                                  fontSize: 22),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                        child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            'Check In',
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.black54,
                                                fontSize: 20),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 80,
                                          child: Divider(),
                                        ),
                                      FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(    hp.attendanceHistoryList[
                                          index]['checkIn']==''|| hp.attendanceHistoryList[
                                          index]['checkIn']==null?   '--/--':
                                            DateFormat('hh:mm a').format(
                                                    DateFormat('hh:mm:ss a').parse(
                                                        hp.attendanceHistoryList[
                                                            index]['checkIn'])) ,
                                            style:
                                                GoogleFonts.aBeeZee(fontSize: 20),
                                          ),
                                        ),
                                      ],
                                    )),
                                    Expanded(
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                      children: [
                                          Text(
                                            'Check Out',
                                            style: GoogleFonts.aBeeZee(
                                                color: Colors.black54,
                                                fontSize: 20),
                                          ),
                                          const SizedBox(
                                            width: 80,
                                            child: Divider(),
                                          ),
                                          FittedBox(
                                            fit: BoxFit.scaleDown,
                                            child: Text(
                                                hp.attendanceHistoryList[
                                                index]['checkOut']==''|| hp.attendanceHistoryList[
                                                index]['checkOut']==null?   '--/--':
                                              DateFormat('hh:mm a').format(
                                                      DateFormat('hh:mm:ss a').parse(
                                                          hp.attendanceHistoryList[
                                                              index]['checkOut'])).toString()
                                              ,
                                              style:
                                                  GoogleFonts.aBeeZee(fontSize: 20),
                                            ),
                                          ),
                                      ],
                                    ),
                                        )),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        itemCount: hp.attendanceHistoryList.length,
                      ))
          ],
        );
      },
    ));
  }
}
