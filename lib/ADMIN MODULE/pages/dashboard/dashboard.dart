import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/dashboard/widgets/largeScreenView.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/dashboard/widgets/mediumScreenView.dart';

import '../../responsiveness/responsive.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                      margin: EdgeInsets.only(
                          top:
                              ResponsiveWidget.issmallScreen(context) ? 56 : 6),
                      child: Text(
                        'Dashboard',
                        style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      )),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    'Control Panel',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey),
                  ),
                ],
              ),
              SizedBox(
                  // height: h,
                  width: w,
                  child: dashViews(context))
            ],
          ),
        ),
      ),
    );
  }

  Widget dashViews(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      double _width = constraints.maxWidth;
      // return _width>= largeScreenSize?LargeScreenView():MediumScreenView();
      // _width>= largeScreenSize?largeScreen:(_width<largeScreenSize && _width>=mediumScreenSize)?mediumScreen:smallScreen;
      if (_width <= largeScreenSize && _width >= mediumScreenSize) {
        return const LargeScreenView();
      } else {
        return const MediumScreenView();
      }
    });
  }
}
