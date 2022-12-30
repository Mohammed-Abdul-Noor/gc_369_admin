import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/rejectModel.dart';
import '../model/userModel.dart';
import '../pages/layout.dart';
import '../widgets/changePassword.dart';
import '../widgets/userApp.dart';

class RegistrationReport extends StatefulWidget {
  const RegistrationReport({Key? key}) : super(key: key);

  @override
  State<RegistrationReport> createState() => _RegistrationReportState();
}

class _RegistrationReportState extends State<RegistrationReport> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? firstDoc;
  int pageIndex = 0;
  int ind = 0;
  @override
  void initState() {
    // usersListener(currentUserId);
    _controller1 = ScrollController();
    userStream = FirebaseFirestore.instance
        .collection('registration')
        .limit(25)
        .snapshots();
    //  TextEditingController search =TextEditingController();
    super.initState();
  }

  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind = 0;
      pageIndex = 0;
      userStream = FirebaseFirestore.instance
          .collection('registration')
          .limit(25)
          .snapshots();
    } else {
      ind += 25;
      userStream = FirebaseFirestore.instance
          .collection('registration')
          // .orderBy('index')
          .startAfterDocument(lastDoc!)
          .limit(25)
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
          .collection('registration')
          .limit(25)
          .snapshots();
    } else {
      ind -= 25;

      userStream = FirebaseFirestore.instance
          .collection('registration')
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(25)
          .snapshots();
    }
    setState(() {});
  }

  ScrollController? _controller1;
  TextEditingController search = TextEditingController();
  bool disable = false;
  Map<int, DocumentSnapshot> lastDocuments = {};
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(shrinkWrap: true, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Registration Report',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 25,
                ),
              ),
              const SizedBox(height: 15),
              DecoratedBox(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black.withOpacity(0.1))),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Total User',
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                  scrollbarOrientation: ScrollbarOrientation.top,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: search!.text == ''
                              ? userStream
                              : FirebaseFirestore.instance
                                  .collection('registration')
                                  .where('mobNo',
                                      isEqualTo: search.text.toUpperCase())
                                  .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              return CircularProgressIndicator();
                            } else if (snapshot.hasData &&
                                snapshot.data!.docs.isEmpty) {
                              return Text("Empty");
                            } else {
                              List<DocumentSnapshot> data = snapshot.data!.docs;
                              lastDoc = snapshot.data!.docs[data.length - 1];
                              firstDoc = snapshot.data!.docs[0];
                              lastDocuments[pageIndex] = lastDoc!;
                              return Column(
                                children: [
                                  DataTable(
                                      dataRowHeight: h * 0.1,
                                      border: TableBorder.all(
                                          color: Colors.black.withOpacity(0.1)),
                                      dataRowColor:
                                          MaterialStateProperty.resolveWith(
                                              (Set states) {
                                        if (states
                                            .contains(MaterialState.selected)) {
                                          return Colors.grey;
                                        }
                                        return Colors
                                            .white; // Use the default value.
                                      }),
                                      checkboxHorizontalMargin: Checkbox.width,
                                      columnSpacing: 50,
                                      dividerThickness: 3,
                                      showCheckboxColumn: true,
                                      horizontalMargin: 50,
                                      //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

                                      columns: [
                                        DataColumn(
                                            numeric: true,
                                            onSort: (columnIndex, ascending) =>
                                                const Text(''),
                                            label: const Text('SI.No')),
                                        const DataColumn(label: Text('Name')),
                                        const DataColumn(
                                            label: Text('Password')),
                                        const DataColumn(label: Text('UserID')),
                                        const DataColumn(
                                            label: Text('Join Date')),
                                        const DataColumn(
                                            label: Text('Mobile Number')),
                                        // const DataColumn(label: Text('Sponsor I')),
                                        // const DataColumn(label: Text('Sponsor II')),
                                        // const DataColumn(label: Text('Sponsor III')),
                                      ],
                                      rows: List.generate(data.length, (index) {
                                        DocumentSnapshot registration =
                                            data[index];
                                        String userId = '';
                                        try {
                                          userId = registration['userId'];
                                        } catch (e) {
                                          print(e.toString());
                                        }

                                        return DataRow(cells: [
                                          DataCell(Text((ind == 0
                                                  ? index + 1
                                                  : ind + index + 1)
                                              .toString())),
                                          DataCell(SelectableText(
                                              registration['name'])),
                                          DataCell(SelectableText(
                                              registration['password'])),
                                          DataCell(SelectableText(userId)),
                                          // DataCell(SelectableText(
                                          //     registration['verify'] == true
                                          //         ? registration['userId'] ?? ''
                                          //         : '')),
                                          DataCell(Text(
                                              "${DateFormat('dd-MMM-yyyy').format(registration['joinDate'].toDate()) ?? ''}")),
                                          DataCell(SelectableText(
                                              registration['mobNo'] ?? '')),
                                          // DataCell(Text(registration['spnsr_Id']??'')),
                                          // DataCell(Text(registration['spnsrId2']??'')),
                                          // DataCell(Text(registration['spnsrId3']??'')),
                                        ]);
                                      })),
                                ],
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
                          child: Text('previous')),
                  SizedBox(width: 30),
                  lastDoc == null && pageIndex != 0
                      ? Container()
                      : ElevatedButton(
                          onPressed: () {
                            next();
                          },
                          child: Text('Next'))
                ],
              )
            ],
          ),
        ]),
      ),
    );
  }
}

getHelp(List<DocumentSnapshot> data, int index, BuildContext context,
    String id) async {
  DocumentSnapshot<Map<String, dynamic>> sendUser =
      await FirebaseFirestore.instance.collection('Users').doc(id).get();
  int totalAmount =
      int.tryParse(sendUser.get('provideHelpUsers')['Amount'].toString()) ?? 0;
  int paidAmount =
      int.tryParse(sendUser.get('provideHelpUsers')['paidAmount'].toString()) ??
          0;
  UserModel sendUsermodel = UserModel.fromJson(sendUser.data()!);

  Map<String, dynamic> transaction = {};
  if (planMap.keys.length < 2) {
    DocumentSnapshot<Map<String, dynamic>> event = await FirebaseFirestore
        .instance
        .collection('settings')
        .doc('settings')
        .get();
    if (event.exists) {
      plans = event.data()!['plan'];
      planMap = event.data()!['plans'];
    }
  }
  transaction =
      planMap['${sendUsermodel?.sno}']['${sendUsermodel?.currentPlanLevel}'];
  if (transaction['amt'] ==
      (int.tryParse(data[index]['amount'].toString()) ?? 0)) {
    if (transaction['type'] == 3) {
      getClub(transaction, data, index, sendUsermodel);
    }

    data[index].reference.update({'verify': true}).then((value) {
      showUploadMessage("Successfuly", context);

      // Navigator.pop(context);
    });
  } else {
    showUploadMessage("Incorrect Amount Send", context);
  }
}

getClub(Map<String, dynamic> transaction, List<DocumentSnapshot> data,
    int index, UserModel sndUsr) {
  if (transaction['cnt'] == sndUsr.currentCount! + 1 &&
      planMap['${sndUsr.sno}']['last'] == currentuser?.currentPlanLevel) {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'clubAmt.${sndUsr.sno}':
          FieldValue.increment(int.tryParse(data[index]['amount']) ?? 0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'sno': FieldValue.increment(1),
      'eligible': true,
      'currentPlanLevel': 0,
      'currentCount': 0,
      'enteredDate.${sndUsr.sno ?? 0 + 1}': FieldValue.serverTimestamp(),
    });
  } else if (transaction['cnt'] == sndUsr.currentCount! + 1) {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'clubAmt.${sndUsr.sno}':
          FieldValue.increment(int.tryParse(data[index]['amount']) ?? 0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'eligible': !transaction['sent'],
      'currentPlanLevel': FieldValue.increment(1),
      'currentCount': 0,
    });
  } else {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'clubAmt.${sndUsr.sno}':
          FieldValue.increment(int.tryParse(data[index]['amount']) ?? 0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'currentCount': FieldValue.increment(1),
    });
  }
}
