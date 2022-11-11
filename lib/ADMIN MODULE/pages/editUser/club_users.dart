import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/editUser/userModel.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import 'editUser.dart';




class ClubUsers extends StatefulWidget {
  final int sno;
  const ClubUsers({Key? key, required this.sno}) : super(key: key);

  @override
  State<ClubUsers> createState() => _ClubUsersState();
}

class _ClubUsersState extends State<ClubUsers> {
  Future<void>? _launched;




  _launchURLBrowser() async {
    var url = Uri.parse("https://www.369globalclub.org/");
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }
  List<String> columns=["A","B","C","D","E","F","G","H","I","J","K","L","M","N","O","P","Q","R","S","T","U","V","W","X","Y","Z","AA","AB","AC","AD","AE","AF","AG","AH","AI","AJ","AK","AL","AM","AN","AO","AP","AQ","AR","AS","AT","AU","AV","AW","AX","AY","AZ","BA","BB","BC","BD","BE","BF","BG","BH","BI","BJ","BK","BL","BM","BN","BO","BP","BQ","BR","BS","BT","BU","BV","BW","BX","BY","BZ","CA","CB","CC","CD","CE","CF","CG","CH","CI","CJ","CK","CL","CM","CN","CO","CP","CQ","CR","CS","CT","CU","CV","CW","CX","CY","CZ","DA","DB","DC","DD","DE","DF","DG","DH","DI","DJ","DK","DL","DM","DN","DO","DP","DQ","DR","DS","DT","DU","DV","DW","DX","DY","DZ","EA","EB","EC","ED","EE","EF","EG","EH","EI","EJ","EK","EL","EM","EN","EO","EP","EQ","ER","ES","ET","EU","EV","EW","EX","EY","EZ","FA","FB","FC","FD","FE","FF","FG","FH","FI","FJ","FK","FL","FM","FN","FO","FP","FQ","FR","FS","FT","FU","FV","FW","FX","FY","FZ",];
bool called =false;
  // getPurchases(QuerySnapshot<Map<String,dynamic>> data)async{
  //
  //   int i=1;
  //   var excel = Excel.createExcel();
  //   // var excel = Excel.createExcel();
  //   Sheet sheetObject = excel['expense'];
  //   CellStyle cellStyle = CellStyle(
  //       backgroundColorHex: "#1AFF1A",
  //       fontFamily: getFontFamily(FontFamily.Calibri));
  //   if(data.docs.length>0){
  //     var cell = sheetObject
  //         .cell(CellIndex.indexByString("A1"));
  //     cell.value =
  //     'SL NO'; // dynamic values support provided;
  //     cell.cellStyle = cellStyle;
  //     Map<String,dynamic> dt =data.docs[0].data();
  //     print(dt.keys.toList().length);
  //     print(dt.keys.toList());
  //     int k=0;
  //     for(int n=0;n<dt.keys.toList().length;n++){
  //
  //         var cell = sheetObject
  //             .cell(CellIndex.indexByString("${columns[k+1]}1"));
  //         cell.value =
  //         dt.keys.toList()[n]; // dynamic values support provided;
  //         cell.cellStyle = cellStyle;
  //         k++;
  //
  //     }
  //   }
  //
  //
  //   for(DocumentSnapshot<Map<String,dynamic>> doc in data.docs){
  //     // address=doc.get('shippingAddress');
  //     int l=0;
  //     var cell = sheetObject
  //         .cell(CellIndex.indexByString("A${i+1}"));
  //     cell.value =
  //         i.toString(); // dynamic values support provided;
  //     cell.cellStyle = cellStyle;
  //     // double amt=0;
  //     // double commission=0;
  //     // String shopsId='';
  //     Map<String,dynamic> dt =data.docs[0].data();
  //     Map<String,dynamic> dta =doc.data()!;
  //     print("hereeee");
  //     for(int n=0;n<dt.keys.toList().length;n++){
  //
  //         var cell = sheetObject
  //             .cell(CellIndex.indexByString("${columns[l + 1]}${i + 1}"));
  //
  //         // if (dta[dt.keys.toList()[n]].runtimeType.toString() == "Timestamp") {
  //         if (dt.keys.toList()[n]=="date") {
  //           cell.value =
  //               dta[dt.keys.toList()[n]].toDate().toString(); //
  //           cell.cellStyle = cellStyle;
  //         }
  //         else {
  //           cell.value =
  //               dta[dt.keys.toList()[n]].toString();
  //           cell.cellStyle = cellStyle;
  //         }
  //         l++;
  //
  //       //    dynamic values support provided;
  //
  //     }
  //
  //
  //
  //
  //
  //     i++;
  //   }
  //
  //   excel.setDefaultSheet('expense');
  //   var fileBytes = excel.encode();
  //   File file;
  //
  //   final content = base64Encode(fileBytes!);
  //   final anchor = AnchorElement(
  //       href: "data:application/octet-stream;charset=utf-16le;base64,$content")
  //     ..setAttribute("download", "369 club ${widget.sno} users.xlsx")
  //     ..click();
  //
  //
  // }
  TextEditingController? search ;
  // Stream ?userStream;

  // @override
  // void initState() {
  //   super.initState();
  //   userStream = FirebaseFirestore.instance
  //       .collection('Users')
  //       .snapshots();
  //   search = TextEditingController();
  // }



  Stream<QuerySnapshot<Map<String,dynamic>>>? userStream;
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? firstDoc;
  int pageIndex = 0;
  int ind = 0;
  @override
  void initState() {
    // CurrentUserListener(currentUserId);
    _controller2=ScrollController();
    _controller3=ScrollController();
    userStream =  FirebaseFirestore.instance.collection('Users')
        .where('sno',isEqualTo: widget.sno)

        .orderBy('index')
        .limit(10)
        .snapshots();
    search=TextEditingController();
    super.initState();

  }

  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind=0;

      userStream =
          FirebaseFirestore.instance.collection('Users')
          .where('sno',isEqualTo: widget.sno)
              .orderBy('index')
              .limit(10).snapshots();
    } else {
      ind+=10;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('sno',isEqualTo: widget.sno)
          .orderBy('index')
          .startAfterDocument(lastDoc!)
          .limit(10)
          .snapshots();
    }

    if(mounted) {
      setState(() {});
    }
  }

  prev() {
    pageIndex--;
    if (firstDoc == null || pageIndex == 0) {
      print("here");
      ind=0;

      userStream =
          FirebaseFirestore.instance.collection('Users')
              .where('sno',isEqualTo: widget.sno)
              .orderBy('index')

              .limit(10).snapshots();
    } else {
      ind-=10;

      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('sno',isEqualTo: widget.sno)
          .orderBy('index')

          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(10)
          .snapshots();
    }
    setState(() {});
  }
  ScrollController? _controller2;
  ScrollController? _controller3;

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
          child: ListView(
              shrinkWrap: true,children: [
            Row(
              children:  [
                Text(
                  'Club ${widget.sno} Users',
                  style:const TextStyle(
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
                child: Row(
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
                      mainAxisAlignment: MainAxisAlignment.center,


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
                                  color: Colors.black.withOpacity(0.3))),
                          child: Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: TextFormField(
                              controller: search,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                              ),
                              onFieldSubmitted: (value){
                                setState(() {

                                  //  usersFiltered = userStream;
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
            // SizedBox(height: 10),
            Scrollbar(
              controller: _controller3,
              scrollbarOrientation: ScrollbarOrientation.top,

              child: SingleChildScrollView(
                controller:_controller3 ,
                scrollDirection: Axis.horizontal,
                child: search!.text==''?
                StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                    stream:userStream,
                    // search?.text!=""?FirebaseFirestore.instance.collection('Users')
                    //   .where('search',arrayContains: search?.text.toUpperCase()).limit(10).snapshots(): FirebaseFirestore.instance.collection('Users').limit(10).snapshots(),
                    builder: (context, snapshot) {
                      if(!snapshot.hasData){
                        return Center(child: CircularProgressIndicator(),);
                      }
                      if(snapshot.hasData &&  snapshot.data!.docs.isEmpty){
                        return Center(child: Text("No Users found!!!"),);
                      }
                      // if(called==false){
                      //   called=true;
                      //   // getPurchases(snapshot.data!);
                      // }
                      var data = snapshot.data!.docs;
                       print(snapshot.error);
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
                          DataColumn(label: Expanded(child: Text('Join Date'))),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('User Panel')),
                          DataColumn(label: Text('View')),
                        ],
                        rows: List.generate(data.length, (index) {
                          var user = data[index];
                          return DataRow(cells: [
                            DataCell(Text( (ind==0?index+1:ind+index+1).toString())),
                            DataCell(Text(user['uid'])),
                            DataCell(Text(user['name'])),
                            DataCell(Text(user['mobno'])),
                            DataCell(Text("${DateFormat('dd-MMM-yyyy').format(user['joinDate'].toDate())}")),
                            //  DataCell(Text(DateFormat('dd-MMM-yyyy').format(user['join_date'].toDate()))),
                            DataCell(
                                Text(user['status'] ? 'Active' : 'Not Active')),
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
                                // child: InkWell(
                                //     onTap:(){
                                //       _launchURLBrowser();
                                //
                                //     },
                                child: const Text('Goto Panel'),
                              ),
                            ),
                            DataCell(Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3))),
                                alignment: Alignment.center,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,

                                          MaterialPageRoute(
                                            builder: (context) =>  EditUser(user:UserModel.fromJson(user.data())),
                                          ));},
                                    child: const Text('Edit')))),
                          ]);
                        }),
                      );
                    }):
                StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                    stream:FirebaseFirestore.instance.collection('Users')
                        .where('search',arrayContains: search!.text.toUpperCase()).limit(10).snapshots(),
                    // search?.text!=""?FirebaseFirestore.instance.collection('Users')
                    //   .where('search',arrayContains: search?.text.toUpperCase()).limit(10).snapshots(): FirebaseFirestore.instance.collection('Users').limit(10).snapshots(),
                    builder: (context, snapshot) {
                      // if(!snapshot.hasData){
                      //   return Center(child: CircularProgressIndicator(),);
                      // }
                      // if(snapshot.hasData &&  snapshot.data!.docs.isEmpty){
                      //   return Center(child: Text("No Users found!!!"),);
                      // }
                      var data = snapshot.data!.docs;
                      // lastDoc = snapshot.data!.docs[data.length - 1];
                      // lastDocuments[pageIndex] = lastDoc!;
                      // firstDoc = snapshot.data!.docs[0];
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
                          DataColumn(label: Expanded(child: Text('Join Date'))),

                          // DataColumn(label: Expanded(child: Text('Join Date'))),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('User Panel')),
                          DataColumn(label: Text('View')),
                        ],
                        rows: List.generate(data.length, (index) {
                          var user = data[index];
                          return DataRow(cells: [
                            DataCell(Text('${pageIndex+index+1}')),
                            DataCell(Text(user['uid'])),
                            DataCell(Text(user['name'])),
                            DataCell(Text(user['mobno'])),
                            DataCell(Text("${DateFormat('dd-MMM-yyyy').format(user['joinDate'].toDate())}")),

                            // DataCell(Text(DateFormat('dd-MMM-yyyy').format(user['join_date'].toDate()))),
                            DataCell(
                                Text(user['status'] ? 'Active' : 'Not Active')),
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
                                  // child: InkWell(
                                  //     onTap: () {
                                  //
                                  //       _launchURLBrowser();
                                  //
                                  //
                                  //       // Navigator.push(context, MaterialPageRoute(builder: (context) => UserApp(),));
                                  //     },
                                  //
                                  child: const Text('Goto Panel')
                              ),
                            ),
                            DataCell(Container(
                                height: 30,
                                width: 90,
                                decoration: BoxDecoration(
                                    color: Colors.yellow,
                                    borderRadius: BorderRadius.circular(3),
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.3))),
                                alignment: Alignment.center,
                                child: InkWell(
                                    onTap: () {
                                      Navigator.push(
                                          context,

                                          MaterialPageRoute(
                                            builder: (context) =>  EditUser(user:UserModel.fromJson(user.data())),
                                          ));},
                                    child: const Text('Edit')))),
                          ]);
                        }),
                      );
                    }),
              ),
            ),
            Row(
              children: [
              pageIndex==0?Container():  ElevatedButton(onPressed: (){
                  prev();
                }, child: Text('Previous')),
                SizedBox(width: 30,),
                lastDoc==null&&pageIndex!=0?Container():  ElevatedButton(onPressed: (){
                  next();
                } ,child: Text('Next'))
              ],
            ),
            FutureBuilder<void>(future: _launched, builder: _launchStatus),
          ]),
        ));
  }
}
