import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/widgets/changePassword.dart';
import 'package:intl/intl.dart';

import '../pages/editUser/ProvideHelp.dart';
import '../pages/editUser/genIDModel.dart';
import '../pages/editUser/getHelp.dart';
import '../model/userModel.dart';
import '../pages/layout.dart';

class WalletRegistration extends StatefulWidget {
  const WalletRegistration({Key? key}) : super(key: key);

  @override
  State<WalletRegistration> createState() => _WalletRegistrationState();
}

class _WalletRegistrationState extends State<WalletRegistration> {
  ScrollController? _controller1;
  bool disable = false;

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
          stream: FirebaseFirestore.instance
              .collection('walletRegistration')
              .where('verify', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            print(snapshot.error);
            // print(lenght);

            if (!snapshot.hasData) {
              return CircularProgressIndicator();
            } else if (snapshot.hasData && snapshot.data!.docs.isEmpty) {
              return Text("Empty");
            } else {
              var data = snapshot.data!.docs;

              return Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(shrinkWrap: true, children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'User verification',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 25,
                        ),
                      ),
                      const SizedBox(height: 15),
                      DecoratedBox(
                        decoration: BoxDecoration(
                            border: Border.all(
                                color: Colors.black.withOpacity(0.1))),
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
                                  const Spacer(),
                                  const Text('Search'),
                                  const SizedBox(width: 7),
                                  Container(
                                    height: 20,
                                    width: 130,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(3),
                                        border: Border.all(
                                            color:
                                            Colors.black.withOpacity(0.3))),
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
                            scrollDirection: Axis.horizontal,
                            child: Column(
                              children: [
                                DataTable(
                                    dataRowHeight: h * 0.5,
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
                                      const DataColumn(label: Text('JoinDate')),
                                      //  const DataColumn(label: Text('Time')),
                                      const DataColumn(label: Text('Name')),
                                      const DataColumn(
                                          label: Text('Mobile Number')),
                                      const DataColumn(
                                          label: Text('WhatsApp Number')),
                                      const DataColumn(label: Text('ID Proof')),
                                      const DataColumn(label: Text('Proof')),
                                      const DataColumn(label: Text('Verify')),
                                    ],
                                    rows: List.generate(data.length, (index) {
                                      var walletRegistration = data[index];

                                      return DataRow(cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(DateFormat('dd-MMM-yyyy')
                                            .format(walletRegistration
                                            .data()['joinDate']
                                            ?.toDate()))),
                                        DataCell(SelectableText(
                                            walletRegistration.data()['name'])),
                                        DataCell(SelectableText(
                                            walletRegistration.data()['mobNo'])),
                                        DataCell(SelectableText(
                                            walletRegistration.data()['whatsNo'])),
                                        DataCell(CachedNetworkImage(
                                          imageUrl:
                                           walletRegistration.data()['fProof'],
                                          width: currentWidth < 700
                                              ? w * 0.4
                                              : w * 0.2,
                                          fit: BoxFit.fitHeight,
                                        )),
                                        DataCell(SelectableText(
                                           'wallet transfer by\n${walletRegistration.data()['spendId']}')),
                                        DataCell(Column(
                                          crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                          mainAxisAlignment:
                                          MainAxisAlignment.center,
                                          children: [
                                            InkWell(
                                              onTap: () async {
                                                if (!disable) {
                                                  disable == true;
                                                  DocumentSnapshot id =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection(
                                                      'settings')
                                                      .doc('settings')
                                                      .get();
                                                  var user =
                                                  id["userId"].toString();
                                                  if (id["userId"] > 1000) {
                                                    var userid = "";
                                                    bool increment = true;
                                                    if (walletRegistration.data()[
                                                    'userId'] ==
                                                        "" ||
                                                        walletRegistration.data()[
                                                        'userId'] ==
                                                            null) {
                                                      id.reference.update({
                                                        "userId": FieldValue
                                                            .increment(1)
                                                      });
                                                      userid = "GC$user";
                                                    } else {
                                                      increment = false;
                                                      userid = walletRegistration
                                                          .data()['userId'];
                                                    }

                                                    final userdata = UserModel(
                                                      address: walletRegistration
                                                          .data()['address'],
                                                      bproof: walletRegistration
                                                          .data()['bProof'],
                                                      charAmt: {},
                                                      clubAmt: {},
                                                      directmember: 0,
                                                      downline1: 0,
                                                      downline2: 0,
                                                      downline3: 0,
                                                      checkGenId: false,
                                                      eligible: false,
                                                      email: "",
                                                      enteredDate: {
                                                        '0': FieldValue
                                                            .serverTimestamp(),
                                                      },
                                                      fproof: walletRegistration
                                                          .data()['fProof'],
                                                      genId: GenIdModel(
                                                          firstGenId: "",
                                                          secondGenId: "",
                                                          thirdGenId: ""),
                                                      getCount: {},
                                                      getHelpUsers:
                                                      GetHelpUsers(
                                                        Amount: 0,
                                                        Id: '',
                                                        receiveAmount: 0,
                                                      ),
                                                      googlepayno: "",
                                                      ifscno: '',
                                                      index: int.tryParse(user),
                                                      joinDate: DateTime.now(),
                                                      levelincome: 0,
                                                      mobno: walletRegistration
                                                          .data()['mobNo'],
                                                      motherId: true,
                                                      mystatus: '',
                                                      name: walletRegistration
                                                          .data()['name'],
                                                      paytmno: "",
                                                      phonepayno: "",
                                                      password: walletRegistration
                                                          .data()['password'],
                                                      provideHelpUsers:
                                                      ProvideHelpUsers(
                                                          Amount: 0,
                                                          Id: '',
                                                          paidAmount: 0),
                                                      panNo: '',
                                                      provideCount: {},
                                                      rebirthId: 0,
                                                      receivehelp: 0,
                                                      receiveCount: 0,
                                                      referral: [],
                                                      sendCount: 0,
                                                      search: setSearchParam(
                                                          userid +
                                                              '' +
                                                              walletRegistration
                                                                  .data()[
                                                              'name']),
                                                      sendhelp: 0,
                                                      sno: 0,
                                                      spnsr_Id: walletRegistration
                                                          .data()['spnsr_Id'],
                                                      spnsrId2: walletRegistration
                                                          .data()['spnsrId2'],
                                                      spnsrId3: walletRegistration
                                                          .data()['spnsrId3'],
                                                      spnsrAmt1: {},
                                                      spnsrAmt2: {},
                                                      spnsrAmt3: {},
                                                      sponsoremobile: '',
                                                      sponsorincome: 0,
                                                      status: true,
                                                      type: walletRegistration
                                                          .data()['typeId'],
                                                      upiId: '',
                                                      uid: userid,
                                                      upgradeAmt: {},
                                                      wallet: 0,
                                                      whatsNO: walletRegistration
                                                          .data()['whatsNo'],
                                                      whatsappcc: walletRegistration
                                                          .data()['whatsCc'],
                                                    );

                                                    FirebaseFirestore.instance
                                                        .collection('settings')
                                                        .doc('settings')
                                                        .update({
                                                      'totalMembers':
                                                      FieldValue.increment(
                                                          increment
                                                              ? 1
                                                              : 0),
                                                      'totalID':
                                                      FieldValue.increment(
                                                          increment
                                                              ? 1
                                                              : 0),
                                                    }).then((value) {
                                                      print(
                                                          "===================================");
                                                      String newId = userid;
                                                      print(userid);
                                                      print(userid.runtimeType);
                                                      Map<String, dynamic>
                                                      userMap =
                                                      userdata.toJson();
                                                      print(userMap);
                                                      try {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('Users')
                                                            .doc(newId)
                                                            .set(userMap);
                                                      } catch (err) {
                                                        print(
                                                            "hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh");
                                                        print(err.toString());
                                                      }
                                                      disable = false;
                                                    });
                                                    walletRegistration.reference
                                                        .update({
                                                      'verify': true,
                                                      'userId': userid,
                                                    });
                                                    if (walletRegistration.data()[
                                                    'spnsr_Id'] !=
                                                        '') {
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(walletRegistration
                                                          .data()[
                                                      'spnsr_Id'])
                                                          .update({
                                                        'levelincome':
                                                        FieldValue
                                                            .increment(30),
                                                        'wallet': FieldValue
                                                            .increment(30),
                                                        'downline1': FieldValue
                                                            .increment(1),
                                                      });
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(walletRegistration
                                                          .data()[
                                                      'spnsrId2'])
                                                          .update({
                                                        'levelincome':
                                                        FieldValue
                                                            .increment(15),
                                                        'wallet': FieldValue
                                                            .increment(15),
                                                        'downline2': FieldValue
                                                            .increment(1),
                                                      });
                                                      FirebaseFirestore.instance
                                                          .collection('Users')
                                                          .doc(walletRegistration
                                                          .data()[
                                                      'spnsrId3'])
                                                          .update({
                                                        'downline3': FieldValue
                                                            .increment(1),
                                                      });
                                                    }
                                                  } else {
                                                    showUploadMessage(
                                                        "Try again", context);
                                                  }
                                                }
                                              },
                                              child: Container(
                                                  height: 30,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: Colors.green,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          3),
                                                      border: Border.all(
                                                          color: Colors.black
                                                              .withOpacity(
                                                              0.3))),
                                                  alignment: Alignment.center,
                                                  child: const Text('Accept')),
                                            ),
                                            SizedBox(height: 13),
                                            InkWell(
                                              onTap: () {
                                                final userdata = UserModel(
                                                  address: walletRegistration
                                                      .data()['address'],
                                                  bproof: walletRegistration
                                                      .data()['bProof'],
                                                  charAmt: {},
                                                  clubAmt: {},
                                                  directmember: 0,
                                                  downline1: 0,
                                                  downline2: 0,
                                                  downline3: 0,
                                                  checkGenId: false,
                                                  eligible: false,
                                                  email: "",
                                                  enteredDate: {},
                                                  fproof: walletRegistration
                                                      .data()['fProof'],
                                                  genId: GenIdModel(
                                                      firstGenId: "",
                                                      secondGenId: "",
                                                      thirdGenId: ""),
                                                  getCount: {},
                                                  getHelpUsers: GetHelpUsers(
                                                    Amount: 0,
                                                    Id: '',
                                                    receiveAmount: 0,
                                                  ),
                                                  googlepayno: "",
                                                  ifscno: '',
                                                  index: 0,
                                                  joinDate: DateTime.now(),
                                                  levelincome: 0,
                                                  mobno: walletRegistration
                                                      .data()['mobNo'],
                                                  motherId: true,
                                                  mystatus: '',
                                                  name: walletRegistration
                                                      .data()['name'],
                                                  paytmno: "",
                                                  phonepayno: "",
                                                  password: walletRegistration
                                                      .data()['password'],
                                                  provideHelpUsers:
                                                  ProvideHelpUsers(
                                                      Amount: 0,
                                                      Id: '',
                                                      paidAmount: 0),
                                                  panNo: '',
                                                  provideCount: {},
                                                  rebirthId: 0,
                                                  receivehelp: 0,
                                                  receiveCount: 0,
                                                  referral: [],
                                                  sendCount: 0,
                                                  search: [],
                                                  sendhelp: 0,
                                                  sno: 0,
                                                  spnsr_Id: '',
                                                  spnsrId2: '',
                                                  spnsrId3: '',
                                                  spnsrAmt1: {},
                                                  spnsrAmt2: {},
                                                  spnsrAmt3: {},
                                                  sponsoremobile: '',
                                                  sponsorincome: 0,
                                                  status: true,
                                                  type: walletRegistration
                                                      .data()['typeId'],
                                                  upiId: '',
                                                  uid: "",
                                                  upgradeAmt: {},
                                                  wallet: 0,
                                                  whatsNO: walletRegistration
                                                      .data()['whatsNo'],
                                                  whatsappcc: walletRegistration
                                                      .data()['whatsCc'],
                                                  mobcc: walletRegistration
                                                      .data()['mobCc'],
                                                );
                                                walletRegistration.reference.update({
                                                  'verify': true,
                                                });

                                                FirebaseFirestore.instance
                                                    .collection('rejectedUsers')
                                                    .add(userdata.toJson());
                                              },
                                              child: Container(
                                                  height: 30,
                                                  width: 60,
                                                  decoration: BoxDecoration(
                                                      color: Colors.red,
                                                      borderRadius:
                                                      BorderRadius.circular(
                                                          3),
                                                      border: Border.all(
                                                          color: Colors.black
                                                              .withOpacity(
                                                              0.3))),
                                                  alignment: Alignment.center,
                                                  child: const Text('Reject')),
                                            ),
                                          ],
                                        )
                                        ),
                                      ]);
                                    })),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ]),
              );
            }
          }),
    );
  }
}

getSponsor1(Map<String, dynamic> transaction, List<DocumentSnapshot> data,
    int index, UserModel sndUsr) {
  data[index].reference.update({'sponsorLevel': 1, 'verify': true});
  if (transaction['cnt'] == sndUsr.currentCount! + 1 &&
      planMap[sndUsr.sno]['last'] == currentuser?.currentPlanLevel) {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'spnsrAmt1.${sndUsr.sno}':
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
      'spnsrAmt1.${sndUsr.sno}':
      FieldValue.increment(int.tryParse(data[index]['amount']) ?? 0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'currentPlanLevel': FieldValue.increment(1),
      'currentCount': 0,
    });
  } else {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'spnsrAmt1.${sndUsr.sno}':
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

getSponsor2(Map<String, dynamic> transaction, List<DocumentSnapshot> data,
    int index, UserModel sndUsr) {
  data[index].reference.update({'sponsorLevel': 2, 'verify': true});
  if (transaction['cnt'] == sndUsr.currentCount! + 1 &&
      planMap[sndUsr.sno]['last'] == currentuser?.currentPlanLevel) {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'spnsrAmt2.${sndUsr.sno}':
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
      'spnsrAmt2.${sndUsr.sno}':
      FieldValue.increment(int.tryParse(data[index]['amount']) ?? 0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'currentPlanLevel': FieldValue.increment(1),
      'currentCount': 0,
    });
  } else {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'spnsrAmt3.${sndUsr.sno}':
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

getSponsor3(Map<String, dynamic> transaction, List<DocumentSnapshot> data,
    int index, UserModel sndUsr) {
  data[index].reference.update({'sponsorLevel': 3, 'verify': true});
  if (transaction['cnt'] == sndUsr.currentCount! + 1 &&
      planMap[sndUsr.sno]['last'] == currentuser?.currentPlanLevel) {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'spnsrAmt3.${sndUsr.sno}':
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
      'spnsrAmt3.${sndUsr.sno}':
      FieldValue.increment(int.tryParse(data[index]['amount']) ?? 0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'currentPlanLevel': FieldValue.increment(1),
      'currentCount': 0,
    });
  } else {
    FirebaseFirestore.instance.collection('Users').doc(sndUsr.uid).update({
      'spnsrAmt3.${sndUsr.sno}':
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
