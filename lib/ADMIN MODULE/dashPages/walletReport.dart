import 'dart:convert';
import 'dart:html';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../model/rejectModel.dart';
import '../model/userModel.dart';
import '../pages/layout.dart';
import '../widgets/changePassword.dart';
import '../widgets/userApp.dart';

class WalletReport extends StatefulWidget {
  const WalletReport({Key? key}) : super(key: key);

  @override
  State<WalletReport> createState() => _WalletReportState();
}

class _WalletReportState extends State<WalletReport> {
  Stream<QuerySnapshot<Map<String, dynamic>>>? userStream;
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? firstDoc;
  int pageIndex = 0;
  int ind = 0;
  int len = 0;

  final scrollController=ScrollController();
  @override
  void initState() {
    // usersListener(currentUserId);
    getUser();
    _controller1 = ScrollController();


    //  TextEditingController search =TextEditingController();
    super.initState();
  }
  getUser()  {
    userStream = FirebaseFirestore.instance
        .collection('registration')
        .where('walletReg',isEqualTo: true)
        .orderBy('joinDate',descending: true)
    // .limit(100)
        .snapshots();
   userStream!.listen((event) {
     len = event.docs.length;
   });
    if(mounted){
      setState(() {

      });
    }
  }

  List<String> columns = [
    "A",
    "B",
    "C",
    "D",
    "E",
    "F",
    "G",
    "H",
    "I",
    "J",
    "K",
    "L",
    "M",
    "N",
    "O",
    "P",
    "Q",
    "R",
    "S",
    "T",
    "U",
    "V",
    "W",
    "X",
    "Y",
    "Z",
    "AA",
    "AB",
    "AC",
    "AD",
    "AE",
    "AF",
    "AG",
    "AH",
    "AI",
    "AJ",
    "AK",
    "AL",
    "AM",
    "AN",
    "AO",
    "AP",
    "AQ",
    "AR",
    "AS",
    "AT",
    "AU",
    "AV",
    "AW",
    "AX",
    "AY",
    "AZ",
    "BA",
    "BB",
    "BC",
    "BD",
    "BE",
    "BF",
    "BG",
    "BH",
    "BI",
    "BJ",
    "BK",
    "BL",
    "BM",
    "BN",
    "BO",
    "BP",
    "BQ",
    "BR",
    "BS",
    "BT",
    "BU",
    "BV",
    "BW",
    "BX",
    "BY",
    "BZ",
    "CA",
    "CB",
    "CC",
    "CD",
    "CE",
    "CF",
    "CG",
    "CH",
    "CI",
    "CJ",
    "CK",
    "CL",
    "CM",
    "CN",
    "CO",
    "CP",
    "CQ",
    "CR",
    "CS",
    "CT",
    "CU",
    "CV",
    "CW",
    "CX",
    "CY",
    "CZ",
    "DA",
    "DB",
    "DC",
    "DD",
    "DE",
    "DF",
    "DG",
    "DH",
    "DI",
    "DJ",
    "DK",
    "DL",
    "DM",
    "DN",
    "DO",
    "DP",
    "DQ",
    "DR",
    "DS",
    "DT",
    "DU",
    "DV",
    "DW",
    "DX",
    "DY",
    "DZ",
    "EA",
    "EB",
    "EC",
    "ED",
    "EE",
    "EF",
    "EG",
    "EH",
    "EI",
    "EJ",
    "EK",
    "EL",
    "EM",
    "EN",
    "EO",
    "EP",
    "EQ",
    "ER",
    "ES",
    "ET",
    "EU",
    "EV",
    "EW",
    "EX",
    "EY",
    "EZ",
    "FA",
    "FB",
    "FC",
    "FD",
    "FE",
    "FF",
    "FG",
    "FH",
    "FI",
    "FJ",
    "FK",
    "FL",
    "FM",
    "FN",
    "FO",
    "FP",
    "FQ",
    "FR",
    "FS",
    "FT",
    "FU",
    "FV",
    "FW",
    "FX",
    "FY",
    "FZ",
  ];
  bool loading = false;
  List<String> selectedFields = [
    "userId","name", "password", "joinDate","mobNo","spendId",

    // "status",
  ];
  getPurchases(QuerySnapshot<Map<String, dynamic>> data) async {
    int i = 1;
    var excel = Excel.createExcel();
    // var excel = Excel.createExcel();
    Sheet sheetObject = excel['WalletReport'];
    CellStyle cellStyle = CellStyle(
        backgroundColorHex: "#ffffff",
        fontFamily: getFontFamily(FontFamily.Calibri));
    if (data.docs.length > 0) {
      var cell = sheetObject.cell(CellIndex.indexByString("A1"));
      cell.value = 'SL NO'; // dynamic values support provided;
      cell.cellStyle = cellStyle;
      Map<String, dynamic> dt = data.docs[0].data();
      // print(dt.keys.toList().length);
      // print(dt.keys.toList());
      int k = 0;
      for (int n = 0; n < selectedFields.toList().length; n++) {
        if (selectedFields.contains(selectedFields.toList()[n])) {
          var cell =
          sheetObject.cell(CellIndex.indexByString("${columns[k + 1]}1"));
          cell.value =
          selectedFields.toList()[n]; // dynamic values support provided;
          cell.cellStyle = cellStyle;
          k++;
        }
      }
    }

    for (DocumentSnapshot<Map<String, dynamic>> doc in data.docs) {
      int l = 0;
      var cell = sheetObject.cell(CellIndex.indexByString("A${i + 1}"));
      cell.value = i.toString(); // dynamic values support provided;
      cell.cellStyle = cellStyle;
      // double amt=0;
      // double commission=0;
      // String shopsId='';
      Map<String, dynamic> dt = data.docs[0].data();
      Map<String, dynamic> dta = doc.data()!;
      // print('here');
      for (int n = 0; n < selectedFields.toList().length; n++) {
        if (selectedFields.contains(selectedFields.toList()[n])) {
          var cell = sheetObject
              .cell(CellIndex.indexByString("${columns[l + 1]}${i + 1}"));

          // if (dta[dt.keys.toList()[n]].runtimeType.toString() == "Timestamp") {
          if (selectedFields.toList()[n] == "joinDate") {
            cell.value = dta[selectedFields.toList()[n]].toDate().toString(); //
            cell.cellStyle = cellStyle;
          } else {
            cell.value = dta[selectedFields.toList()[n]].toString();
            cell.cellStyle = cellStyle;
          }
          l++;
        }

        //    dynamic values support provided;

      }

      i++;
    }

    excel.setDefaultSheet('WalletReport');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes!);
    final anchor = AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "369 Wallet Report Details.xlsx")
      ..click();
  }

  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind = 0;
      pageIndex = 0;
      userStream = FirebaseFirestore.instance
          .collection('registration')
          .where('walletReg',isEqualTo: true)
          .orderBy('joinDate',descending: true)
          .limit(100)
          .snapshots();
    } else {
      ind += 100;
      userStream = FirebaseFirestore.instance
          .collection('registration')
          .where('walletReg',isEqualTo: true)
          .orderBy('joinDate',descending: true)
          .startAfterDocument(lastDoc!)
          .limit(100)
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
          .where('walletReg',isEqualTo: true)
          .orderBy('joinDate',descending: true)
          .limit(100)
          .snapshots();
    } else {
      ind -= 100;

      userStream = FirebaseFirestore.instance
          .collection('registration')
          .where('walletReg',isEqualTo: true)
          .orderBy('joinDate',descending: true)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(100)
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
        child: ListView(controller:scrollController,shrinkWrap: true, children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Wallet Report',
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
                      //  Text(
                      //   'Total Wallet Id\'s : $len',
                      //   style: TextStyle(
                      //     color: Colors.blueGrey,
                      //     fontSize: 15,
                      //     fontWeight: FontWeight.bold,
                      //   ),
                      // ),
                      // const SizedBox(height: 10),
                      Row(
                        children: [
                          ElevatedButton(
                              onPressed: () async {
                                setState(() {
                                  loading = true;
                                });
                                QuerySnapshot<Map<String, dynamic>> data =
                                await FirebaseFirestore.instance
                                    .collection('registration')
                                    .where('walletReg',isEqualTo: true)
                                    .orderBy('joinDate',descending: true)
                                    .get();
                                await getPurchases(data);
                                setState(() {
                                  loading = false;
                                });
                              },
                              child: Row(
                                children: const [
                                  Icon(Icons.download),
                                  Text('Wallet Report'),
                                ],
                              )),
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
                  scrollbarOrientation: ScrollbarOrientation.top,
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: StreamBuilder<QuerySnapshot>(
                          stream: search!.text == ''
                              ? userStream
                              : FirebaseFirestore.instance
                              .collection('registration')
                              .where('walletReg',isEqualTo: true)
                              .where('mobNo',
                              isEqualTo: search.text.toUpperCase())
                              .snapshots(),
                          builder: (context, snapshot) {
                            if (!snapshot.hasData) {
                              print(snapshot.error);
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
                                        const DataColumn(label: Text('UserID')),
                                        const DataColumn(label: Text('Name')),
                                        const DataColumn(label: Text('Password')),
                                        const DataColumn(label: Text('Join Date')),
                                        const DataColumn(label: Text('Mobile Number')),
                                        const DataColumn(label: Text('Spend Id')),
                                        // const DataColumn(label: Text('Sponsor I')),
                                        // const DataColumn(label: Text('Sponsor II')),
                                        // const DataColumn(label: Text('Sponsor III')),
                                      ],
                                      rows: List.generate(data.length, (index) {
                                        DocumentSnapshot registration =
                                        data[index];
                                        String spndId = '';
                                        String userId = '';
                                        try {
                                          spndId = registration['spendId'];
                                          userId = registration['userId'];
                                        } catch (e) {
                                          print(e.toString());
                                        }

                                        return DataRow(cells: [
                                          DataCell(Text((ind == 0 ? index + 1 : ind + index + 1).toString())),
                                          DataCell(SelectableText(userId)),
                                          DataCell(SelectableText(registration['name'])),
                                          DataCell(SelectableText(registration['password'])),
                                          DataCell(Text("${DateFormat('dd-MMM-yyyy').format(registration['joinDate'].toDate()) ?? ''}")),
                                          DataCell(SelectableText(registration['mobNo'] ?? '')),
                                          DataCell(SelectableText(spndId)),
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
      'enteredDate.${(sndUsr.sno ?? 0) + 1}': FieldValue.serverTimestamp(),
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
