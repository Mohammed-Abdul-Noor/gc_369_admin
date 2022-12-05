import 'dart:convert';
import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/main.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../model/userModel.dart';
import '../pages/editUser/editUser.dart';

class DownTotalUsers extends StatefulWidget {
  const DownTotalUsers({Key? key}) : super(key: key);

  @override
  State<DownTotalUsers> createState() => _DownTotalUsersState();
}

class _DownTotalUsersState extends State<DownTotalUsers> {
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
  bool called = false;

  List<String> selectedFields = [
    "uid", "joinDate", "name",

    //  "password",

    //"mobno",
    // "status",
  ];
  getPurchases(QuerySnapshot<Map<String, dynamic>> data) async {
    int i = 1;
    var excel = Excel.createExcel();
    // var excel = Excel.createExcel();
    Sheet sheetObject = excel['expense'];
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
      for (int n = 0; n < dt.keys.toList().length; n++) {
        if (selectedFields.contains(dt.keys.toList()[n])) {
          var cell =
              sheetObject.cell(CellIndex.indexByString("${columns[k + 1]}1"));
          cell.value = dt.keys.toList()[n]; // dynamic values support provided;
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
      print("hereeee");
      for (int n = 0; n < dt.keys.toList().length; n++) {
        if (selectedFields.contains(dt.keys.toList()[n])) {
          var cell = sheetObject
              .cell(CellIndex.indexByString("${columns[l + 1]}${i + 1}"));

          // if (dta[dt.keys.toList()[n]].runtimeType.toString() == "Timestamp") {
          if (dt.keys.toList()[n] == "joinDate") {
            cell.value = dta[dt.keys.toList()[n]].toDate().toString(); //
            cell.cellStyle = cellStyle;
          } else {
            cell.value = dta[dt.keys.toList()[n]].toString();
            cell.cellStyle = cellStyle;
          }
          l++;
        }

        //    dynamic values support provided;

      }

      i++;
    }

    excel.setDefaultSheet('expense');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes!);
    final anchor = AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "369 club Total users.xlsx")
      ..click();
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
  bool loading = false;
  @override
  void initState() {
    // usersListener(currentUserId);
    _controller = ScrollController();
    _controller1 = ScrollController();
    userStream = FirebaseFirestore.instance
        .collection('Users')
        .orderBy('index')
        .where('index', isNotEqualTo: 0)
        // .limit(10)
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
          .orderBy('index')
          // .limit(10)
          .snapshots();
    } else {
      ind += 10;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('index')
          .startAfterDocument(lastDoc!)
          // .limit(10)
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
          // .limit(10)
          .snapshots();
    } else {
      ind -= 10;

      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('index')
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          // .limit(10)
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
        body: loading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Padding(
                padding: const EdgeInsets.all(10.0),
                child: ListView(shrinkWrap: true, children: [
                  Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
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
                              style:
                                  TextStyle(fontSize: 20, color: Colors.grey),
                            )
                          ],
                        ),
                        const SizedBox(height: 15),
                        Container(
                          decoration: BoxDecoration(
                              border: Border.all(
                                  color: Colors.black.withOpacity(0.1))),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Download Total Users')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 0)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Club 0 Users')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 1)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Club 1 Users')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 2)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Club 2 Users')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 3)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Club 3 Users')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 4)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Club 4 Users')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 5)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Club 5 Users')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 0)
                                                .where('eligible',
                                                    isEqualTo: true)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Seniority Level 0')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 1)
                                                .where('eligible',
                                                    isEqualTo: true)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Seniority Level 1')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 2)
                                                .where('eligible',
                                                    isEqualTo: true)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Seniority Level 2')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 3)
                                                .where('eligible',
                                                    isEqualTo: true)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Seniority Level 3')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 4)
                                                .where('eligible',
                                                    isEqualTo: true)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Seniority Level 4')),
                                const SizedBox(height: 15),
                                ElevatedButton(
                                    onPressed: () async {
                                      setState(() {
                                        loading = true;
                                      });
                                      if (allUsers == null) {
                                        QuerySnapshot<Map<String, dynamic>>
                                            data = await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .where('sno', isEqualTo: 5)
                                                .where('eligible',
                                                    isEqualTo: true)
                                                .orderBy('index')
                                                .get();
                                        allUsers = data;
                                        await getPurchases(data);
                                      } else {
                                        await getPurchases(allUsers!);
                                      }
                                      setState(() {
                                        loading = false;
                                      });
                                    },
                                    child: Text('Seniority Level 5')),
                                Row(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        // getPurchases(excelData!);
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(3),
                                            border: Border.all(
                                                color: Colors.white
                                                    .withOpacity(0.3))),
                                        alignment: Alignment.center,
                                        height: 20,
                                        width: 50,
                                        child: const Text(''),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    // Text((pageIndex+1).toString()),
                                    // Text((ind+1).toString()),
                                    const Spacer(),
                                    const SizedBox(width: 7),
                                    Container(
                                      height: 30,
                                      width: 150,
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(3),
                                          border: Border.all(
                                              color: Colors.white
                                                  .withOpacity(0.3))),
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
                      ]),
                ]),
              ));
  }
}
