import 'dart:convert';
import 'dart:html';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/routing/splashScreen.dart';
import 'package:intl/intl.dart';

class CoView extends StatefulWidget {
  static const String id = "AllUsers";

  @override
  State<CoView> createState() => _CoViewState();
}

class _CoViewState extends State<CoView> {
  final items = ['CSV File', 'EXCEL File', 'PDF File', 'Copy All'];

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
  List<String> selectedFields = [
    "uid",
    "name",
    "joinDate",
  ];
  getExcel(QuerySnapshot<Map<String, dynamic>> data) async {
    int i = 1;
    var excel = Excel.createExcel();
    Sheet sheetObject = excel['Users'];
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

    excel.setDefaultSheet('Users');
    var fileBytes = excel.encode();
    File file;

    final content = base64Encode(fileBytes!);
    final anchor = AnchorElement(
        href: "data:application/octet-stream;charset=utf-16le;base64,$content")
      ..setAttribute("download", "369 District Wise Members.xlsx")
      ..click();
  }

  getSortedUsers(String txt) {
    allUsersSort = [];
    for (int i = 0; i < allUsers.length; i++) {
      if (allUsers[i]['name'].toString().toLowerCase().contains(txt) ||
          allUsers[i]['uid'].toString().toLowerCase().contains(txt)) {
        allUsersSort.add(allUsers[i]);
      }
    }
    setState(() {});
  }

  String districtValue = "";
  TextEditingController search = TextEditingController();

  bool loading = false;
  List<DocumentSnapshot<Map<String, dynamic>>> allUsers = [];
  List<DocumentSnapshot<Map<String, dynamic>>> allUsersSort = [];
  final controller = ScrollController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var data = allUsers;
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'District Wise Users',
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black),
          ),
        ),
        actions: [
          IconButton(
              onPressed: () {
                logOutEvent(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: Container(
        color: Colors.blueGrey[50],
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    allUsers.isEmpty
                        ? SizedBox()
                        : Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.white),
                            width: 200,
                            height: 40,
                            child: TextField(
                              onChanged: ((str) {
                                allUsersSort = [];
                                if (search.text.isEmpty) {
                                  allUsersSort.addAll(allUsers);
                                } else {
                                  getSortedUsers(str.toLowerCase());
                                }
                                setState(() {});
                              }),
                              controller: search,
                              decoration: InputDecoration(
                                hintText: "Search here",
                                prefixIcon: const Icon(CupertinoIcons.search),
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                            )),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8.0)),
                      height: 45,
                      width: 170,
                      child: Center(
                        child: DropdownButton(
                          underline: const SizedBox(),
                          value: districtValue,
                          hint: const Center(
                              child: Text(
                            'Select District',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          )),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                          items: const [
                            DropdownMenuItem(
                              value: '',
                              child: Text(
                                'Select district',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Kasaragod',
                              child: Text(
                                'Kasaragod',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Kannur',
                              child: Text(
                                'Kannur',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Wayanad',
                              child: Text(
                                'Wayanad',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Kozhikode',
                              child: Text(
                                'Kozhikode',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Malappuram',
                              child: Text(
                                'Malappuram',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Palakkad',
                              child: Text(
                                'Palakkad',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Thrissur',
                              child: Text(
                                'Thrissur',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Ernakulam',
                              child: Text(
                                'Ernakulam',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Idukki',
                              child: Text(
                                'Idukki',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Kottayam',
                              child: Text(
                                'Kottayam',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Alappuzha',
                              child: Text(
                                'Alappuzha',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Pathanamthitta',
                              child: Text(
                                'Pathanamthitta',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Kollam',
                              child: Text(
                                'Kollam',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                            DropdownMenuItem(
                              value: 'Thiruvananthapuram',
                              child: Text(
                                'Thiruvananthapuram',
                                style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ),
                          ],
                          onChanged: (String? value) async {
                            if (value == '') {
                              allUsers = [];
                              allUsersSort = [];
                              setState(() {
                                loading = false;
                              });
                            } else {
                              districtValue = value!;
                              setState(() {
                                loading = true;
                              });
                              QuerySnapshot<Map<String, dynamic>> doc =
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .where('motherId', isEqualTo: true)
                                      .where('address.city',
                                          isEqualTo: districtValue)
                                      .orderBy('index')
                                      .get();
                              allUsers = doc.docs;
                              allUsersSort = doc.docs;
                              setState(() {
                                loading = false;
                              });
                            }
                          },
                        ),
                      ),
                    ),
                    const Spacer(),
                    districtValue == ''
                        ? Container()
                        : ElevatedButton(
                            onPressed: () async {
                              setState(() {
                                loading = true;
                              });
                              QuerySnapshot<Map<String, dynamic>> data =
                                  await FirebaseFirestore.instance
                                      .collection('Users')
                                      .where('motherId', isEqualTo: true)
                                      .where('address.city',
                                          isEqualTo: districtValue)
                                      .orderBy('index')
                                      .get();
                              await getExcel(data);
                              setState(() {
                                loading = false;
                              });
                            },
                            child: Row(
                              children: [
                                Icon(Icons.download),
                                Text('Download'),
                              ],
                            )),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                loading == true
                    ? Center(
                        child: CircularProgressIndicator(),
                      )
                    : Scrollbar(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Column(
                            children: [
                              DataTable(
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
                                  columnSpacing: 50.0,
                                  dividerThickness: 3,
                                  showCheckboxColumn: true,
                                  horizontalMargin: 50,
                                  //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

                                  columns: const [
                                    DataColumn(
                                        numeric: true, label: (Text('SI.No'))),
                                    DataColumn(label: Text('User ID')),
                                    DataColumn(label: Text('Name')),
                                    DataColumn(label: Text('Mobile')),
                                    DataColumn(label: Text('Join Date')),
                                    DataColumn(label: Text('Sponsor ID')),
                                    DataColumn(label: Text('Sponsor Name')),
                                  ],
                                  rows: List.generate(allUsersSort.length,
                                      (index) {
                                    var user = allUsersSort[index];
                                    return DataRow(cells: [
                                      DataCell(Text('${index + 1}')),
                                      DataCell(Text(user['uid'])),
                                      DataCell(Text(user['name'])),
                                      DataCell(SelectableText(user['mobno'])),
                                      DataCell(Text(DateFormat('dd-MMM-yyyy')
                                          .format(user['joinDate'].toDate()))),
                                      DataCell(Text(user["spnsr_Id"])),
                                      DataCell(Text(user["sponsorname"])),
                                    ]);
                                  })),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void topScroll() {
    final double start = 0;
    controller.jumpTo(start);
  }
}
