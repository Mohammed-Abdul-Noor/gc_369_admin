import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/userApp.dart';

class ClubsPage extends StatefulWidget {
  const ClubsPage({Key? key}) : super(key: key);

  @override
  State<ClubsPage> createState() => _ClubsPageState();
}

class _ClubsPageState extends State<ClubsPage> {
  Stream<QuerySnapshot>? userStream;
  DocumentSnapshot? lastDoc;
  DocumentSnapshot? firstDoc;
  int pageIndex = 0;
  @override
  void initState() {
    super.initState();
    userStream = FirebaseFirestore.instance
        .collection('Users')
        .where('sno', isGreaterThan: 2)
        .limit(10)
        .snapshots();
  }




  next() {
    pageIndex++;
    if (lastDoc == null || pageIndex == 0) {
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('sno', isGreaterThan: 2)
          .limit(10)
          .snapshots();
    } else {
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('sno', isGreaterThan: 2)
          .startAfterDocument(lastDoc!)
          .limit(15)
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
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('sno', isGreaterThan: 2)
          .limit(10)
          .snapshots();
    } else {
      userStream = FirebaseFirestore.instance
          .collection('Users')
          .where('sno', isGreaterThan: 2)
          .startAfterDocument(lastDocuments[pageIndex - 1]!)
          .limit(10)
          .snapshots();
    }
    if(mounted) {
      setState(() {});
    }
  }

  Map<int, DocumentSnapshot> lastDocuments = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(10.0),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Total Users',
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
                      const Spacer(),
                      const Text('Search'),
                      const SizedBox(width: 7),
                      Container(
                        height: 20,
                        width: 130,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(3),
                            border: Border.all(
                                color: Colors.black.withOpacity(0.3))),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          // SizedBox(height: 10),
          Row(
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: userStream,
                  builder: (context, snapshot) {
                    var data = snapshot.data!.docs;
                    if (data.length > 0) {
                      lastDoc = snapshot.data!.docs[data.length - 1];
                      lastDocuments[pageIndex] = lastDoc!;
                    }

                    firstDoc = snapshot.data!.docs[0];
                    return Expanded(
                      child: FittedBox(
                          child: DataTable(
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
                        //decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),

                        columns: const [
                          DataColumn(numeric: true, label: Text('SI.No')),
                          DataColumn(label: Text('User ID')),
                          DataColumn(label: Text('Name')),
                          DataColumn(label: Text('Mobile')),
                          DataColumn(label: Text('Club')),
                          DataColumn(label: Text('User Panel')),
                          DataColumn(label: Text('View')),
                        ],
                        rows: List.generate(data.length, (index) {
                          var user = data[index];

                          int sno = user['sno'] - 2;
                          return DataRow(cells: [
                            DataCell(Text('${index + 1}')),
                            DataCell(Text(user['uid'])),
                            DataCell(Text(user['name'])),
                            DataCell(Text(user['mobno'])),
                            DataCell(Text(sno.toString())),
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
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const UserApp(),
                                        )),
                                    child: const Text('Goto Panel')))),
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
                                    onTap: () => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => const UserApp(),
                                        )),
                                    child: const Text('View')))),
                          ]);
                        }),
                      )),
                    );
                  }),
            ],
          )
        ]),
      ),
    ));
  }
}
