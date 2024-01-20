import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import 'package:jupiter_frontend/models/course.dart';
import 'package:jupiter_frontend/services/cache.dart';
import 'package:jupiter_frontend/pages/home/courses_view.dart';
import 'package:jupiter_frontend/services/db_manager.dart';
import 'package:jupiter_frontend/services/shared_preferences.dart';
import 'package:jupiter_frontend/widgets/general/callisto_clickable.dart';
import 'package:jupiter_frontend/widgets/general/callisto_refresher.dart';
import 'package:jupiter_frontend/widgets/general/callisto_text.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/appbar.dart';
import 'package:jupiter_frontend/widgets/scaffold_components/drawer.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Course> courses = List.empty(growable: true);

  double uwAvg = 0;

  @override
  void initState() {
    super.initState();

    // gather course data stuff
    courses = CCache().cachedCourses;

    double gradeSum = 0.0;

    for (Course c in courses) {
      gradeSum += c.average;

      avgIncludedCourses[c] = true;
    }

    uwAvg = gradeSum / courses.length;
  }

  // Course is hashable?? this worked???? wtf
  HashMap<Course, bool> avgIncludedCourses = HashMap();

  void _showCustomPopup(BuildContext context) {
    List<Course> keysList = avgIncludedCourses.keys.toList();
    keysList.sort((a, b) {
      return a.name.compareTo(b.name);
    });
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return AlertDialog(
              scrollable: true,
              title: const FittedBox(
                child: CallistoText("Select courses to include", size: 30),
              ),
              content: Column(
                children: [
                  // const CallistoText("Select courses to include:", size: 18),
                  ...keysList.map((Course course) {
                    return Row(
                      children: [
                        Checkbox(
                          value: avgIncludedCourses[course],
                          onChanged: (val) {
                            setState(() {
                              avgIncludedCourses[course] = val!;
                            });
                          },
                        ),
                        CallistoText(course.name, size: 15),
                      ],
                    );
                  }),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    _updateAvg();
                    Navigator.of(context).pop();
                  },
                  child: const CallistoText("Finish", size: 18),
                ),
              ],
            );
          },
        );
      },
    );
  }

  void _updateAvg() {
    int count = 0;
    double gradeSum = 0.0;
    for (var entry in avgIncludedCourses.entries) {
      if (!entry.value) {
        continue;
      }

      count++;
      gradeSum += entry.key.average;
    }

    setState(() {
      uwAvg = gradeSum / count;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            appBar: const CAppBar(title: "Yet Another Jupiter Frontend"),
            drawer: const CDrawer(),
            body: CPullDownRefresh(
              child: ListView(
                children: [
                  const Gap(15),
                  const Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                    child: CallistoText("Welcome back,",
                        size: 20,
                        weight: FontWeight.bold,
                        textAlign: TextAlign.left),
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(15.0, 0, 0, 0),
                    child: CallistoText(CSharedPrefs().name!,
                        size: 35,
                        weight: FontWeight.bold,
                        textAlign: TextAlign.left),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(16),
                      child: CClickable(
                        onPressed: () {
                          _showCustomPopup(context);
                        },
                        child: Container(
                          alignment: Alignment.centerLeft,
                          decoration: BoxDecoration(
                              // color: ,
                              borderRadius: BorderRadius.circular(10.0),
                              border: Border.all(
                                  color:
                                      Theme.of(context).colorScheme.tertiary)),
                          child: Padding(
                              padding: const EdgeInsets.all(20),
                              child: CallistoText(
                                "Unweighted Average: ${uwAvg.toStringAsFixed(2)}",
                                size: 20,
                                weight: FontWeight.w600,
                              )),
                        ),
                      )),
                  const CoursesView(),
                ],
              ),
            )));
    // return PersistentTabView(
    //     context,
    //     controller: _controller,
    //     screens: _buildScreens(),
    //     items: _navBarsItems(),
    //     confineInSafeArea: true,
    //     backgroundColor: Theme.of(context).colorScheme.secondary, // Default is Colors.white.
    //     handleAndroidBackButtonPress: true, // Default is true.
    //     resizeToAvoidBottomInset: true, // This needs to be true if you want to move up the screen when keyboard appears. Default is true.
    //     stateManagement: true, // Default is true.
    //     hideNavigationBarWhenKeyboardShows: true, // Recommended to set 'resizeToAvoidBottomInset' as true while using this argument. Default is true.
    //     decoration: NavBarDecoration(
    //       borderRadius: BorderRadius.circular(10.0),
    //       colorBehindNavBar: Theme.of(context).colorScheme.background,
    //     ),
    //     popAllScreensOnTapOfSelectedTab: true,
    //     popActionScreens: PopActionScreensType.all,
    //     itemAnimationProperties: const ItemAnimationProperties( // Navigation Bar's items animation properties.
    //       duration: Duration(milliseconds: 400),
    //       curve: Curves.easeOutSine,
    //     ),
    //     screenTransitionAnimation: const ScreenTransitionAnimation( // Screen transition animation on change of selected tab.
    //       animateTabTransition: true,
    //       curve: Curves.easeOutSine,
    //       duration: Duration(milliseconds: 400),
    //     ),
    //     navBarStyle: NavBarStyle.style1, // Choose the nav bar style with this property.
  }
}
