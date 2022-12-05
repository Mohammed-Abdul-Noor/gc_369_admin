import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

import '../widgets/changePassword.dart';
import '../widgets/userApp.dart';
import '../pages/editUser/editUser.dart';
import '../model/userModel.dart';

class sponsorlessUsersPage extends StatefulWidget {
  const sponsorlessUsersPage({Key? key}) : super(key: key);

  @override
  State<sponsorlessUsersPage> createState() => _sponsorlessUsersPageState();
}

class _sponsorlessUsersPageState extends State<sponsorlessUsersPage> {
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
        .where('spnsr_Id', isEqualTo: '')
        .orderBy('index')
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
          .where('spnsr_Id', isEqualTo: '')
          .orderBy('index')
          .limit(10)
          .snapshots();
    } else {
      ind += 10;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('spnsr_Id', isEqualTo: '')
          .orderBy('index')
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
          .where('spnsr_Id', isEqualTo: '')
          .orderBy('index')
          .limit(10)
          .snapshots();
    } else {
      ind -= 10;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('spnsr_Id', isEqualTo: '')
          .orderBy('index')
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
                'Sponsorless Users',
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
          Scrollbar(
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
                        return Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                      if (snapshot.data?.docs.length == 0) {
                        return Center(
                          child: Text("No Users Found"),
                        );
                      }
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
                          DataColumn(label: Expanded(child: Text('Join Date'))),
                          DataColumn(label: Text('Status')),
                          DataColumn(label: Text('Sponsor Id')),
                          DataColumn(label: Text('Action')),
                        ],
                        rows: List.generate(data.length, (index) {
                          TextEditingController sponsorId$index =
                              TextEditingController();
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
                            DataCell(
                                Text(user['status'] ? 'Active' : 'Not Active')),
                            DataCell(TextFormField(
                              readOnly: false,
                              // maxLines: 2,
                              controller: sponsorId$index,

                              decoration: InputDecoration(
                                fillColor: Colors.blue.withOpacity(0.07),
                                filled: true,
                                labelStyle: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.yellow,
                                ),
                                border: InputBorder.none,
                                focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              cursorColor: Colors.black,
                              // validator: (ctrl){
                              //   if(ctrl==null && ctrl!.isEmpty){
                              //     return 'This field is empty';
                              //   }else{
                              //     return null;
                              //   }
                              // },
                            )),
                            DataCell(ElevatedButton(
                                onPressed: () async {
                                  if (sponsorId$index.text != '') {
                                    DocumentSnapshot doc =
                                        await FirebaseFirestore.instance
                                            .collection('Users')
                                            .doc(sponsorId$index.text
                                                .toUpperCase())
                                            .get();

                                    if (doc.exists) {
                                      FirebaseFirestore.instance
                                          .collection('Users')
                                          .doc(user['uid'])
                                          .update({
                                        'spnsr_Id':
                                            sponsorId$index.text.toUpperCase(),
                                        'spnsrId2': doc['spnsr_Id'],
                                        'spnsrId3': doc['spnsrId2'],
                                      });
                                      showUploadMessage(
                                          'Sponsor Updated... \n Sponsor name :${doc.get('name')}',
                                          context);
                                    } else {
                                      showUploadMessage(
                                          'No User Found', context);
                                    }
                                  } else {
                                    showUploadMessage(
                                        'Please Enter Sponsor Id', context);
                                  }
                                },
                                child: const Text('Update Sponsor Id'))),
                          ]);
                        }),
                      );
                    })),
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
