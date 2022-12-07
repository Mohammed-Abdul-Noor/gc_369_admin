import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GenIDS extends StatefulWidget {
  const GenIDS({Key? key}) : super(key: key);

  @override
  State<GenIDS> createState() => _GenIDSState();
}

class _GenIDSState extends State<GenIDS> {
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
              .collection('genIdActivate')
              .where('verify', isEqualTo: false)
              .snapshots(),
          builder: (context, snapshot) {
            print(snapshot.error);

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
                        'GenId verification',
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
                                      const DataColumn(label: Text('Gen id')),
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
                                      var registration = data[index];

                                      return DataRow(cells: [
                                        DataCell(Text('${index + 1}')),
                                        DataCell(Text(
                                            registration.data()['userId'])),
                                        DataCell(SelectableText(
                                            registration.data()['name'])),
                                        DataCell(SelectableText(
                                            registration.data()['mobNo'])),
                                        DataCell(SelectableText(
                                            registration.data()['whatsNo'])),
                                        DataCell(CachedNetworkImage(
                                          imageUrl:
                                              registration.data()['fProof'],
                                          width: currentWidth < 700
                                              ? w * 0.4
                                              : w * 0.2,
                                          fit: BoxFit.fitHeight,
                                        )),
                                        DataCell(CachedNetworkImage(
                                          imageUrl: registration.data()['file'],
                                          width: currentWidth < 700
                                              ? w * 0.4
                                              : w * 0.2,
                                          fit: BoxFit.fitHeight,
                                        )),
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
                                                  registration.reference
                                                      .update({
                                                    'verify': true,
                                                  });
                                                  FirebaseFirestore.instance
                                                      .collection('Users')
                                                      .doc(registration
                                                          .data()['userId'])
                                                      .update({
                                                    'status': true,
                                                    'sno': 1,
                                                    'eligible': true
                                                  }).then((value) {});
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
                                          ],
                                        )),
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
