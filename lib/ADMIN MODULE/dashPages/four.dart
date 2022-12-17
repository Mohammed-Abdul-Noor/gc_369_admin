import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/widgets/changePassword.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../pages/editUser/ProvideHelp.dart';
import '../pages/editUser/genIDModel.dart';
import '../pages/editUser/getHelp.dart';
import '../pages/layout.dart';
import '../widgets/userApp.dart';
import '../pages/editUser/editUser.dart';
import '../model/userModel.dart';

class SendReceiveReport extends StatefulWidget {
  const SendReceiveReport({Key? key}) : super(key: key);

  @override
  State<SendReceiveReport> createState() => _SendReceiveReportState();
}

class _SendReceiveReportState extends State<SendReceiveReport> {
  Future<void>? _launched;

  TextEditingController? search;

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
        //.orderBy('index')
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
      pageIndex = 0;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          // .orderBy('index')
          .limit(10)
          .snapshots();
    } else {
      ind += 10;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          //  .orderBy('index')
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
          // .orderBy('index')
          .limit(10)
          .snapshots();
    } else {
      ind -= 10;

      userStream = FirebaseFirestore.instance
          .collection('Users')
          // .orderBy('index')
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
                  Row(
                    children: [
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
                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data!.docs.isEmpty) {
                          return Text('Empty');
                        } else {
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
                              DataColumn(label: Text('Recieve Help')),
                              DataColumn(label: Text('Send Help')),
                              DataColumn(label: Text('Wallet')),
                              DataColumn(label: Text('Current Plan Level')),
                              DataColumn(label: Text(' Level')),
                              DataColumn(label: Text('Mobile')),
                              DataColumn(
                                  label: Expanded(child: Text('Join Date'))),
                            ],
                            rows: List.generate(data.length, (index) {
                              final showEditIcon = index == index;
                              var user = data[index];
                              return DataRow(cells: [
                                DataCell(Text(
                                    (ind == 0 ? index + 1 : ind + index + 1)
                                        .toString())),
                                DataCell(SelectableText(user['uid'])),
                                DataCell(Text(user['name'])),
                                DataCell(
                                    SelectableText(
                                        user['receivehelp'].toString()),
                                    showEditIcon: showEditIcon, onTap: () {
                                  TextEditingController rcvHelp =
                                      TextEditingController(
                                          text: user['receivehelp'].toString());
                                  showDialog(
                                      context: context,
                                      builder: (buildContext) {
                                        return AlertDialog(
                                          title: const Text(
                                              'Edit Receive Help Amount'),
                                          content: SingleChildScrollView(
                                            child: Column(
                                                // shrinkWrap: true,
                                                children: [
                                                  TextFormField(
                                                    controller: rcvHelp,
                                                    decoration: InputDecoration(
                                                        border:
                                                            OutlineInputBorder()),
                                                  )
                                                ]),
                                          ),
                                          actions: [
                                            TextButton(
                                                onPressed: () {
                                                  if (double.tryParse(
                                                          rcvHelp.text) !=
                                                      null) {
                                                    user.reference.update({
                                                      'receivehelp':
                                                          double.tryParse(
                                                              rcvHelp.text)
                                                    });
                                                    showUploadMessage(
                                                        "edit successfull",
                                                        context);
                                                  } else {
                                                    showUploadMessage(
                                                        "invalid amount",
                                                        context);
                                                  }
                                                },
                                                child:
                                                    const Text('Confirm Edit')),
                                          ],
                                        );
                                      });

                                  setState(() {});
                                }),
                                DataCell(
                                    SelectableText(user['sendhelp'].toString()),
                                    showEditIcon: showEditIcon, onTap: () {
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (buildContext) {
                                          TextEditingController sndHelp =
                                              TextEditingController(
                                                  text: user['sendhelp']
                                                      .toString());
                                          return AlertDialog(
                                            title: const Text(
                                                'Edit Send Help Amount'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                  // shrinkWrap: true,
                                                  children: [
                                                    TextFormField(
                                                      controller: sndHelp,
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()),
                                                    )
                                                  ]),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    if (double.tryParse(
                                                            sndHelp.text) !=
                                                        null) {
                                                      user.reference.update({
                                                        'sendhelp':
                                                            double.tryParse(
                                                                sndHelp.text)
                                                      });
                                                      showUploadMessage(
                                                          "edit successfull",
                                                          context);
                                                      //  Navigator.pop(context);
                                                    } else {
                                                      showUploadMessage(
                                                          "invalid amount",
                                                          context);
                                                    }
                                                  },
                                                  child: const Text('Edit')),
                                            ],
                                          );
                                        });

                                    setState(() {});
                                  }
                                }),
                                DataCell(
                                    SelectableText(user['wallet'].toString()),
                                    showEditIcon: showEditIcon, onTap: () {
                                  {
                                    showDialog(
                                        context: context,
                                        builder: (buildContext) {
                                          TextEditingController wallet =
                                              TextEditingController(
                                                  text: user['wallet']
                                                      .toString());
                                          return AlertDialog(
                                            title: const Text(
                                                'Edit Wallet  Amount'),
                                            content: SingleChildScrollView(
                                              child: Column(
                                                  // shrinkWrap: true,
                                                  children: [
                                                    TextFormField(
                                                      controller: wallet,
                                                      decoration: InputDecoration(
                                                          border:
                                                              OutlineInputBorder()),
                                                    )
                                                  ]),
                                            ),
                                            actions: [
                                              TextButton(
                                                  onPressed: () {
                                                    if (double.tryParse(
                                                            wallet.text) !=
                                                        null) {
                                                      user.reference.update({
                                                        'wallet':
                                                            double.tryParse(
                                                                wallet.text)
                                                      });
                                                      showUploadMessage(
                                                          "edit successfull",
                                                          context);
                                                      //   Navigator.pop(context);
                                                    } else {
                                                      showUploadMessage(
                                                          "invalid amount",
                                                          context);
                                                    }
                                                  },
                                                  child: const Text('Edit')),
                                            ],
                                          );
                                        });

                                    setState(() {});
                                  }
                                }),
                                DataCell(SelectableText(
                                    user['currentPlanLevel'].toString())),
                                DataCell(
                                    SelectableText(user['sno'].toString())),
                                DataCell(SelectableText(user['mobno'])),
                                DataCell(Text(
                                    "${DateFormat('dd-MMM-yyyy').format(user['joinDate'].toDate())}")),
                              ]);
                            }),
                          );
                        }
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
                      child: Text('Next')),
            ],
          ),
          FutureBuilder<void>(future: _launched, builder: _launchStatus),
        ]),
      ]),
    ));
  }
}
