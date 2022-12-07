import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../model/userModel.dart';
import 'newpassword.dart';

class PasswordTable extends StatefulWidget {
  const PasswordTable({Key? key}) : super(key: key);

  @override
  State<PasswordTable> createState() => _PasswordTableState();
}

class _PasswordTableState extends State<PasswordTable> {
  Future<void>? _launched;

  _launchURLBrowser() async {
    var url = Uri.parse("https://www.369globalclub.org/");
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

  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind = 0;

      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('index')
          .limit(10)
          .snapshots();
    } else {
      ind += 10;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('index')
          .startAfterDocument(lastDoc!)
          .limit(10)
          .snapshots();
    }

    setState(() {});
  }

  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      print("here");
      ind = 0;

      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('index')
          .limit(10)
          .snapshots();
    } else {
      ind -= 10;

      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('index')
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(10)
          .snapshots();
    }
    setState(() {});
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
                  currentWidth < 650
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.3))),
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 50,
                                  child: const Text('Copy'),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.3))),
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 50,
                                  child: const Text('CSV'),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.3))),
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 50,
                                  child: const Text('Excel'),
                                ),
                                const SizedBox(width: 10),
                                Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.3))),
                                  alignment: Alignment.center,
                                  height: 20,
                                  width: 50,
                                  child: const Text('PDF'),
                                ),
                                // Text((pageIndex+1).toString()),
                                // Text((ind+1).toString()),
                              ],
                            ),
                            const SizedBox(height: 9),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text('Search'),
                                SizedBox(width: 6),
                                Container(
                                  height: 30,
                                  width: 150,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.3))),
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
                        )
                      : Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3))),
                              alignment: Alignment.center,
                              height: 20,
                              width: 50,
                              child: const Text('Copy'),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3))),
                              alignment: Alignment.center,
                              height: 20,
                              width: 50,
                              child: const Text('CSV'),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3))),
                              alignment: Alignment.center,
                              height: 20,
                              width: 50,
                              child: const Text('Excel'),
                            ),
                            const SizedBox(width: 10),
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  border: Border.all(
                                      color: Colors.black.withOpacity(0.3))),
                              alignment: Alignment.center,
                              height: 20,
                              width: 50,
                              child: const Text('PDF'),
                            ),
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
                          ? userStream
                          : FirebaseFirestore.instance
                              .collection('Users')
                              .where('search',
                                  arrayContains: search!.text.toUpperCase())
                              .limit(10)
                              .snapshots(),
                      // search?.text!=""?FirebaseFirestore.instance.collection('Users')
                      //   .where('search',arrayContains: search?.text.toUpperCase()).limit(10).snapshots(): FirebaseFirestore.instance.collection('Users').limit(10).snapshots(),
                      builder: (context, snapshot) {
                        var data = snapshot.data!.docs;

                        lastDoc = snapshot.data!.docs[data.length - 1];
                        lastDocuments[pageIndex] = lastDoc!;
                        firstDoc = snapshot.data!.docs[0];
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
                            DataColumn(label: Text('Name')),
                            DataColumn(label: Text('Mobile')),
                            DataColumn(
                                label: Expanded(child: Text('Join Date'))),
                            DataColumn(label: Text('Status')),
                            DataColumn(label: Text('User Panel')),
                            DataColumn(label: Text('View')),
                          ],
                          rows: List.generate(data.length, (index) {
                            var user = data[index];
                            return DataRow(cells: [
                              DataCell(Text(
                                  (ind == 0 ? index + 1 : ind + index + 1)
                                      .toString())),
                              DataCell(SelectableText(user['uid'])),
                              DataCell(Text(user['name'])),
                              DataCell(SelectableText(user['mobno'])),
                              DataCell(Text(
                                  "${DateFormat('dd-MMM-yyyy').format(user['joinDate'].toDate())}")),
                              //  DataCell(Text(DateFormat('dd-MMM-yyyy').format(user['join_date'].toDate()))),
                              DataCell(Text(
                                  user['status'] ? 'Active' : 'Not Active')),
                              DataCell(
                                Container(
                                    height: 30,
                                    width: 90,
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                            color:
                                                Colors.black.withOpacity(0.3))),
                                    alignment: Alignment.center,
                                    child: InkWell(
                                        onTap: () {
                                          _launchURLBrowser();
                                        },
                                        child: const Text('Goto Panel'))),
                              ),
                              DataCell(Container(
                                  height: 30,
                                  width: 90,
                                  decoration: BoxDecoration(
                                      color: Colors.yellow,
                                      borderRadius: BorderRadius.circular(3),
                                      border: Border.all(
                                          color:
                                              Colors.black.withOpacity(0.3))),
                                  alignment: Alignment.center,
                                  child: InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => NewPassword(
                                                  user: UserModel.fromJson(
                                                      user.data())),
                                            ));
                                      },
                                      child: const Text('Edit')))),
                            ]);
                          }),
                        );
                      })),
            ),
          ),
          Row(
            children: [
              pageIndex == 0
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        prev();
                      },
                      child: Text('Previous')),
              SizedBox(
                width: 30,
              ),
              lastDoc == null && pageIndex != 0
                  ? Container()
                  : ElevatedButton(
                      onPressed: () {
                        next();
                      },
                      child: Text('Next'))
            ],
          ),
          FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ]),
      ]),
    ));
  }
}
