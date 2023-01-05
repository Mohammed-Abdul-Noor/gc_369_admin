import 'dart:convert';
import 'dart:html';
import 'dart:ui';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/widgets/changePassword.dart';
import 'package:intl/intl.dart';

class SponsorIncome extends StatefulWidget {
  const SponsorIncome({Key? key}) : super(key: key);

  @override
  State<SponsorIncome> createState() => _SponsorIncomeState();
}

class _SponsorIncomeState extends State<SponsorIncome> {
  TextEditingController? search;
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? firstDoc;
  int pageIndex = 0;
  int ind = 0;
  DateTime? yesterday;
  @override
  void initState() {
    search = TextEditingController();
    super.initState();
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
    "uid", "name", "sponsorincome",

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
      print("hereeee");
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

    excel.setDefaultSheet('expense');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes!);
    final anchor = AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "369 club Total users.xlsx")
      ..click();
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

  bool loading = false;

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
                'Sponsor Income',
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
                      ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loading = true;
                            });
                            QuerySnapshot<Map<String, dynamic>> data =
                                await FirebaseFirestore.instance
                                    .collection('Users')
                                    .where('sponsorincome', isEqualTo: String)
                                    .orderBy('index')
                                    .get();

                            await getPurchases(data);

                            setState(() {
                              loading = false;
                            });
                          },
                          child: Row(
                            children: const [
                              Icon(Icons.download),
                              Text('Sponsor Income'),
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
              controller: _controller1,
              scrollbarOrientation: ScrollbarOrientation.top,
              child: SingleChildScrollView(
                  controller: _controller1,
                  scrollDirection: Axis.horizontal,
                  child: StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                      stream: search!.text == ''
                          ? FirebaseFirestore.instance
                              .collection('Users')
                              // .orderBy('index')
                              .where('sponsorincome', isNotEqualTo: 0)
                              .snapshots()
                          : FirebaseFirestore.instance
                              .collection('Users')
                              .where('sponsorincome', isNotEqualTo: 0)
                              .where('search',
                                  arrayContains: search!.text.toUpperCase())
                              .snapshots(),
                      builder: (context, snapshot) {
                        print(snapshot.error);
                        if (!snapshot.hasData) {
                          return const CircularProgressIndicator();
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
                              DataColumn(
                                label: Text('User ID'),
                              ),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Sponsor Income')),
                            ],
                            rows: List.generate(data.length, (index) {
                              var user = data[index];
                              return DataRow(cells: [
                                DataCell(Text(
                                    (ind == 0 ? index + 1 : ind + index + 1)
                                        .toString())),
                                DataCell(SelectableText(user['uid'])),
                                DataCell(Text(user['name'])),
                                DataCell(SelectableText(
                                    user['sponsorincome'].toString())),
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
