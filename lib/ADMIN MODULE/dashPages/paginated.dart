import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../pages/editUser/editUser.dart';
import '../model/userModel.dart';

class Paginated extends StatefulWidget {
  const Paginated({Key? key}) : super(key: key);

  @override
  State<Paginated> createState() => _PaginatedState();
}

class _PaginatedState extends State<Paginated> {
  final DataTableSource _data = MyData();
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
  // Stream ?userStream;

  // @override
  // void initState() {
  //   super.initState();
  //   userStream = FirebaseFirestore.instance
  //       .collection('Users')
  //       .snapshots();
  //   search = TextEditingController();
  // }

  Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? firstDoc;
  int pageIndex = 0;
  int ind = 0;
  @override
  void initState() {
    // usersListener(currentUserId);
    _controller = ScrollController();
    _controller1 = ScrollController();
    userStream = FirebaseFirestore.instance
        .collection('Users')
        .orderBy('index')
        .where('index', isNotEqualTo: 0)
        .limit(10)
        .snapshots();
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
            behavior: ScrollConfiguration.of(context).copyWith(dragDevices: {
              PointerDeviceKind.touch,
              PointerDeviceKind.mouse,
            }),
            child: Scrollbar(
              controller: _controller1,
              scrollbarOrientation: ScrollbarOrientation.top,
              child: SingleChildScrollView(
                  controller: _controller1,
                  scrollDirection: Axis.horizontal,
                  // child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                  //     stream: search!.text == ''
                  //         ? FirebaseFirestore.instance
                  //             .collection('Users')
                  //             .where('search',
                  //                 arrayContains: search!.text.toUpperCase())
                  //             .snapshots()
                  //         : FirebaseFirestore.instance
                  //             .collection('Users')
                  //             .where('search',
                  //                 arrayContains: search!.text.toUpperCase())
                  //             .snapshots(),
                  //     // search?.text!=""?FirebaseFirestore.instance.collection('Users')
                  //     //   .where('search',arrayContains: search?.text.toUpperCase()).limit(10).snapshots(): FirebaseFirestore.instance.collection('Users').limit(10).snapshots(),
                  //     builder: (context, snapshot) {
                  //       var data = snapshot.data!.docs;
                  //   return
                  child: PaginatedDataTable(
                    source: _data,
                    rowsPerPage: 10,
                    checkboxHorizontalMargin: Checkbox.width,
                    columnSpacing: 50,
                    showCheckboxColumn: true,
                    horizontalMargin: 50,
                    columns: const [
                      DataColumn(
                        label: Text('User ID'),
                      ),
                      DataColumn(
                        label: Text('Password'),
                      ),
                      DataColumn(label: Text('Name')),
                    ],
                  )
                  // })),
                  ),
            ),
          )
        ]),
      ]),
    ));
  }
}

class MyData extends DataTableSource {
  final List<Map<String, dynamic>> _data = List.generate(
      200,
      (index) => {
            "User ID": index,
            "Password": "Item $index",
            "Name": "Item $index",
          }); // List.generate

  @override
  DataRow? getRow(int index) {
    return DataRow(cells: [
      DataCell(SelectableText('$index')),
      DataCell(SelectableText('$index')),
      DataCell(Text('$index')),
    ]);
  }

  @override
  // TODO: implement isRowCountApproximate
  bool get isRowCountApproximate => false;
  @override
  // TODO: implement rowCount
  int get rowCount => _data.length;

  @override
  // TODO: implement selectedRowCount
  int get selectedRowCount => 0;
}
