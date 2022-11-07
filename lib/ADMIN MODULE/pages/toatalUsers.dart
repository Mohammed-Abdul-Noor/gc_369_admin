import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/userApp.dart';
import 'editUser/editUser.dart';
import 'editUser/uploadDoc.dart';
import 'editUser/userModel.dart';


class TotalUsersPage extends StatefulWidget {
  const TotalUsersPage({Key? key}) : super(key: key);

  @override
  State<TotalUsersPage> createState() => _TotalUsersPageState();
}

class _TotalUsersPageState extends State<TotalUsersPage> {

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
   // usersListener(currentUserId);
    _controller=ScrollController();
    _controller1=ScrollController();
    userStream =  FirebaseFirestore.instance.collection('Users')
        .orderBy('joinDate')

        .limit(10).snapshots();
    search=TextEditingController();
    super.initState();

  }

  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      ind=0;

      userStream =
          FirebaseFirestore.instance.collection('Users')
              .orderBy('joinDate')
              .limit(10).snapshots();
    } else {
      ind+=10;
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('joinDate')
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
      ind=0;

      userStream =
          FirebaseFirestore.instance.collection('Users')
              .orderBy('joinDate')

              .limit(10).snapshots();
    } else {
      ind-=10;

      userStream = FirebaseFirestore.instance
          .collection('Users')
          .orderBy('joinDate')

          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(10)
          .snapshots();
    }
    setState(() {});
  }
   ScrollController? _controller;
   ScrollController? _controller1;

  Map<int, DocumentSnapshot> lastDocuments = {};
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
      controller: _controller,
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
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
                  currentWidth<650?
                  Column(
                    children: [
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
                            child: const Text('Copy'),
                          ),
                          const SizedBox(width: 10),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            alignment: Alignment.center,
                            height: 20,
                            width: 50,
                            child: const Text('CSV'),
                          ),
                          const SizedBox(width: 10),
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
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                border: Border.all(
                                    color: Colors.black.withOpacity(0.3))),
                            alignment: Alignment.center,
                            height: 20,
                            width: 50,
                            child: const Text('PDF'),
                          ),
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
                      ),
                    ],
                  )
                 : Row(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3))),
                        alignment: Alignment.center,
                        height: 20,
                        width: 50,
                        child: const Text('Copy'),
                      ),
                      const SizedBox(width: 10),
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3))),
                        alignment: Alignment.center,
                        height: 20,
                        width: 50,
                        child: const Text('CSV'),
                      ),
                      const SizedBox(width: 10),
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
                      Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3))),
                        alignment: Alignment.center,
                        height: 20,
                        width: 50,
                        child: const Text('PDF'),
                      ),
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
                            onFieldSubmitted: (value){
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
          SingleChildScrollView(
            controller:_controller1 ,
            scrollDirection: Axis.horizontal,
            child: search!.text==''?
            StreamBuilder<QuerySnapshot<Map<String,dynamic>>>(
                stream:userStream,
               // search?.text!=""?FirebaseFirestore.instance.collection('Users')
                 //   .where('search',arrayContains: search?.text.toUpperCase()).limit(10).snapshots(): FirebaseFirestore.instance.collection('Users').limit(10).snapshots(),
                builder: (context, snapshot) {
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
                              child: const Text('Goto Panel')),
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
                                      builder: (context) =>  EditUser(user:UsersModel.fromJson(user.data())),
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
                              child: InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const UserApp(),
                                      )),
                                  child: const Text('Goto Panel'))),
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
                                      builder: (context) =>  EditUser(user:UsersModel.fromJson(user.data())),
                                    ));},
                                child: const Text('Edit')))),
                      ]);
                    }),
                  );
                }),
          ),
          Row(
            children: [
              ElevatedButton(onPressed: (){
                prev();
              }, child: Text('Previous')),
              SizedBox(width: 30,),
              ElevatedButton(onPressed: (){
               next();
              } ,child: Text('Next'))
            ],
          )
        ]),
      ),
    ));
  }
}
