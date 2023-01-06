import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/widgets/changePassword.dart';
import 'package:intl/intl.dart';

class ClearPro extends StatefulWidget {
  const ClearPro({Key? key}) : super(key: key);

  @override
  State<ClearPro> createState() => _ClearProState();
}

class _ClearProState extends State<ClearPro> {
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
                    'Clear Provides',
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
                              .where('provideHelpUsers.date', isLessThanOrEqualTo: yesterday)
                              .orderBy('provideHelpUsers.date')
                              .snapshots()
                              : FirebaseFirestore.instance
                              .collection('Users')
                              .where('provideHelpUsers.date', isLessThanOrEqualTo: yesterday)
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
                                columnSpacing: 80,
                                dataRowHeight: 80,
                                dividerThickness: 3,
                                showCheckboxColumn: true,
                                horizontalMargin: 50,
                                columns: const [
                                  DataColumn(numeric: true, label: Text('SI.No')),
                                  DataColumn(label: Text('User ID'),),
                                  DataColumn(label: Text('Slip Details'),),
                                  DataColumn(label: Text('Password'),),
                                  DataColumn(label: Text('Name')),
                                  DataColumn(label: Text('Mobile')),
                                  DataColumn(label: Text('Update')),
                                  // DataColumn(label: Expanded(child: Text('Join Date'))),
                                ],
                                rows: List.generate(data.length, (index) {
                                  var user = data[index];

                                  String proId = '';
                                  try {
                                    proId = user['provideHelpUsers.Id'];
                                  } catch (e) {
                                    print(e.toString());
                                  }
                                  return DataRow(cells: [
                                    DataCell(Text((ind == 0 ? index + 1 : ind + index + 1).toString())),
                                    DataCell(SelectableText(user['uid'])),
                                    DataCell(Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        children: [
                                          SelectableText("Provide Id : "+proId),
                                          SelectableText("Amount : "+user['provideHelpUsers.Amount'].toString()),
                                          SelectableText("Amount Paid : "+user['provideHelpUsers.paidAmount'].toString()),
                                          Text("Slip Date : ${DateFormat('dd-MMM-yyyy').format(user['provideHelpUsers.date'].toDate())}"),
                                        ],
                                      ),
                                    )),
                                    DataCell(SelectableText(user['password'])),
                                    DataCell(Text(user['name'])),
                                    DataCell(SelectableText(user['mobno'])),
                                    // DataCell(Text("${DateFormat('dd-MMM-yyyy').format(user['joinDate'].toDate())}")),
                                    DataCell(Container(
                                      height: 30,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(3),
                                          border: Border.all(
                                              color: Colors.black.withOpacity(0.3))),
                                      alignment: Alignment.center,
                                      child: InkWell(
                                        onTap: () {
                                          FirebaseFirestore.instance.collection('ClearProvides').add(
                                              {
                                                'userId':user['uid'],
                                                'slipClearedDate' : FieldValue.serverTimestamp(),
                                                'provideHelpUsers' : {
                                                'id': proId,
                                                'amount':user['provideHelpUsers.Amount'],
                                                'amountPaid':user['provideHelpUsers.paidAmount'],
                                                'date':user['provideHelpUsers.date'],
                                                },
                                              }).then((e) async {
                                             await FirebaseFirestore.instance.collection('Users').doc(user['uid']).update(
                                                  {
                                                    'provideHelpUsers.Id':"",
                                                    'provideHelpUsers.paidAmount':0,
                                                    'provideHelpUsers.Amount':0,
                                                    'provideHelpUsers.date':'',
                                                  });
                                              await FirebaseFirestore.instance.collection('Users').doc(user['provideHelpUsers.Id']).update(
                                                  {
                                                    'getHelpUsers.Id':"",
                                                    'getHelpUsers.Amount':0,
                                                    'getHelpUsers.receiveAmount':0,
                                                    'getHelpUsers.date':'',
                                                  });
                                                showUploadMessage('Succefully Updated', context);
                                                print('---------------');
                                          });
                                        },
                                        child: const Text('Clear'),
                                      ),
                                    )),
                                  ]);
                                }),
                              );
                            }
                          })),
                ),
              ),
            ]),
          ]),
        ));
  }
}
