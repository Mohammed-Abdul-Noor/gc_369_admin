import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/editUser/editUser.dart';
import '../model/userModel.dart';

class PendingProvides extends StatefulWidget {
  const PendingProvides({Key? key}) : super(key: key);

  @override
  State<PendingProvides> createState() => _PendingProvidesState();
}

class _PendingProvidesState extends State<PendingProvides> {
  Future<void>? _launched;

  _launchURLBrowser(String userId) async {
    var url =
        Uri.parse("https://www.369globalclub.org/#/adminUserPanel?$userId");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  TextEditingController? search;

  DocumentSnapshot? lastDoc;
  DocumentSnapshot? firstDoc;
  int pageIndex = 0;
  int ind = 0;
  DateTime? yesterday;
  @override
  void initState() {
    yesterday = DateTime.now().subtract(const Duration(days: 1));
    _controller = ScrollController();
    _controller1 = ScrollController();

    search = TextEditingController();
    super.initState();
  }

  ScrollController? _controller;
  ScrollController? _controller1;

  Widget _launchStatus(BuildContext context, AsyncSnapshot<void> snapshot) {
    if (snapshot.hasError) {
      return Text('Error: ${snapshot.error}');
    } else {
      return const Text('');
    }
  }

  Map<int, DocumentSnapshot> lastDocuments = {};
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: ListView(shrinkWrap: true, children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: const [
              Text(
                'Total Users',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              SizedBox(width: 10),
              Text(
                'Advanced table',
                style: TextStyle(fontSize: 20, color: Colors.grey),
              )
            ],
          ),
          const SizedBox(height: 15),
          Container(
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black.withOpacity(0.1))),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // const Text(
                  //   'Total User',
                  //   style: TextStyle(
                  //     color: Colors.red,
                  //     fontSize: 20,
                  //     fontWeight: FontWeight.bold,
                  //   ),
                  // ),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      InkWell(
                        onTap: () {},
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.3))),
                          alignment: Alignment.center,
                          height: 20,
                          width: 75,
                          child: const Text('Download'),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Text((pageIndex+1).toString()),
                      // Text((ind+1).toString()),
                      const Spacer(),
                      const Text('Search'),
                      const SizedBox(width: 7),
                      Container(
                        height: 30,
                        width: 150,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3))),
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: TextFormField(
                            controller: search,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                            ),
                            onFieldSubmitted: (value) {
                              setState(() {
                                //  usersFiltered = userStream;
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 10),
          ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: Scrollbar(
              controller: _controller1,
              scrollbarOrientation: ScrollbarOrientation.top,
              child: SingleChildScrollView(
                  controller: _controller1,
                  scrollDirection: Axis.horizontal,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: search!.text == ''
                          ? FirebaseFirestore.instance
                              .collection('Users')
                              .where('provideHelpUsers.date', isGreaterThan: yesterday)
                              .orderBy('provideHelpUsers.date')
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection('Users')
                              .where('search',
                                  arrayContains: search!.text.toUpperCase())
                              .snapshots(),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data!.docs.isEmpty) {
                          return Text('Empty');
                        } else {
                          print(snapshot.error);
                          var data = snapshot.data!.docs;
                          return DataTable(
                            border: TableBorder.all(
                                color: Colors.black.withOpacity(0.1)),
                            dataRowColor:
                                MaterialStateProperty.resolveWith((Set states) {
                              if (states.contains(MaterialState.selected)) {
                                return Colors.grey;
                              }
                              return Colors.white; // Use the default value.
                            }),
                            checkboxHorizontalMargin: Checkbox.width,
                            columnSpacing: 50,
                            dividerThickness: 3,
                            showCheckboxColumn: true,
                            horizontalMargin: 50,
                            columns: const [
                              DataColumn(numeric: true, label: Text('SI.No')),
                              DataColumn(
                                label: Text('User ID'),
                              ),
                              DataColumn(
                                label: Text('Password'),
                              ),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Mobile')),
                              DataColumn(
                                  label: Expanded(child: Text('Join Date'))),
                              DataColumn(label: Text('Slip Entered Date')),
                            ],
                            rows: List.generate(data.length, (index) {
                              var user = data[index];
                              return DataRow(cells: [
                                DataCell(Text(
                                    (ind == 0 ? index + 1 : ind + index + 1)
                                        .toString())),
                                DataCell(SelectableText(user['uid'])),
                                DataCell(SelectableText(user['password'])),
                                DataCell(Text(user['name'])),
                                DataCell(SelectableText(user['mobno'])),
                                DataCell(Text(
                                    "${DateFormat('dd-MMM-yyyy').format(user['joinDate'].toDate())}")),
                                //  DataCell(Text(DateFormat('dd-MMM-yyyy').format(user['join_date'].toDate()))),
                                DataCell(Text(DateFormat('dd-MMM-yyyy').format(
                                    user['provideHelpUsers.date'].toDate()))),
                              ]);
                            }),
                          );
                        }
                      })),
            ),
          ),

          FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ]),
      ]),
    ));
  }
}
