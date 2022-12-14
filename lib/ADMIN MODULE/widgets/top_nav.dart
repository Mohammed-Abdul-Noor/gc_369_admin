import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toggle_switch/toggle_switch.dart';

import '../constants/style.dart';
import '../navigation/navigationProvider.dart';
import '../responsiveness/responsive.dart';
import 'customText.dart';

AppBar topNavigationBar(BuildContext context, GlobalKey<ScaffoldState> key) =>
    AppBar(
      leading: !ResponsiveWidget.issmallScreen(context)
          ? Row(
              children: [
                IconButton(
                    onPressed: () {
                      final provider = Provider.of<NavigationProvider>(context,
                          listen: false);
                      provider.toggleIsCollapsed();
                      // key.currentState?.openDrawer();
                    },
                    icon: Icon(
                      Icons.menu,
                      color: dark,
                    )),
              ],
            )
          : IconButton(
              onPressed: () {
                key.currentState?.openDrawer();
              },
              icon: Icon(Icons.menu, color: Colors.black)),
      backgroundColor: Colors.blue.shade900,
      elevation: 0,
      title: Row(
        children: [
          Visibility(
            child: CustomText(
                text: 'G C 369',
                size: 20,
                color: lightGrey,
                weight: FontWeight.bold),
          ),
          SizedBox(width: 200),
          // Center(
          //   child: ToggleSwitch(
          //     minWidth: 130.0,
          //     minHeight: 70.0,
          //     initialLabelIndex: 0,
          //     totalSwitches: 2,
          //     activeBgColor: [Colors.green],
          //     activeFgColor: Colors.white,
          //     inactiveBgColor:Colors.red ,
          //     inactiveFgColor: Colors.white,
          //     labels: [
          //       'Enable Register',
          //       'Disable Register',
          //     ],
          //
          //     onToggle: (index) {
          //
          //       FirebaseFirestore.instance.collection('settings').doc('settings').update({
          //         'registration':index==0?false:true,
          //       });
          //     },
          //   ),
          // ),
          Expanded(child: Container()),
          Container(
            decoration: BoxDecoration(
                color: Colors.blue.shade100,
                borderRadius: BorderRadius.circular(30)),
            child: Container(
              padding: EdgeInsets.all(2),
              margin: EdgeInsets.all(2),
              child: CircleAvatar(
                backgroundColor: Colors.white,
                child: Icon(Icons.person, color: Colors.black),
              ),
            ),
          ),
          SizedBox(width: 20),
          CustomText(
              text: 'ADMIN 369',
              size: 16,
              color: Colors.grey,
              weight: FontWeight.bold)
        ],
      ),
    );
