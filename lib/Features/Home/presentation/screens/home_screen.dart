// ignore_for_file: library_private_types_in_public_api

import 'package:employees_attendance/Features/Home/presentation/providers/home_provider.dart';
import 'package:employees_attendance/Features/Home/presentation/screens/Navigations/attendance_screen.dart';
import 'package:employees_attendance/Features/Home/presentation/screens/Navigations/calender_screen.dart';
import 'package:employees_attendance/Features/Home/presentation/screens/Navigations/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<IconData> navigationIcons = [
    FontAwesomeIcons.solidCalendarDays,
    FontAwesomeIcons.check,
    FontAwesomeIcons.solidUser,
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Consumer(
        builder: (context, HomeProvider hp, child) {
          return Scaffold(
            body: Center(
                child: IndexedStack(
              index: hp.navigationIndex,
              children:  [
                const CalenderScreen(),
                AttendanceScreen(),
                const ProfileScreen(),
              ],
            )),
            bottomNavigationBar: Container(
              height: 70,
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 24),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black54,
                      blurRadius: 10,
                      offset: Offset(2, 2),
                    )
                  ]),
              child: Row(
                children: [
                  for (int i = 0; i < navigationIcons.length; i++) ...{
                    Expanded(
                      child: Center(
                        child: IconButton(
                          icon: FaIcon(
                            navigationIcons[i],
                            color: hp.navigationIndex == i
                                ? Colors.redAccent
                                : Colors.black,
                          ),
                          onPressed: () {
                            hp.setNavigateIndex(i);
                          },
                          highlightColor: Colors.red.shade200,
                        ),
                      ),
                    )
                  }
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
