import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/layout.dart';
import '../widgets/userApp.dart';

class CharityAmountPage extends StatelessWidget {
  const CharityAmountPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SingleChildScrollView(
          child:
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const Text(
              'Charity Amount',
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
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('charityProof')
                  .where('verify',isEqualTo: false)
                      .snapshots(),
                  builder: (context, snapshot) {
                    var data = snapshot.data!.docs;
                    if (!snapshot.hasData) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasData &&
                        snapshot.data!.docs.isEmpty) {
                      return Text("Empty");
                    } else {
                      return Column(
                        children: [
                          DataTable(
                              dataRowHeight: h*0.5,

                              border: TableBorder.all(color: Colors.black.withOpacity(0.1)),
                              dataRowColor: MaterialStateProperty.resolveWith((Set states) {
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

                              columns: [
                                DataColumn(
                                    numeric: true,
                                    onSort: (columnIndex, ascending) => const Text(''),
                                    label: const Text('SI.No')),
                                const DataColumn(label: Text('User ID')),
                                const DataColumn(label: Text('Date')),
                                const DataColumn(label: Text('Proof')),
                                const DataColumn(label: Text('Payment Method')),
                                const DataColumn(label: Text('Amount')),
                                const DataColumn(label: Text('Status')),
                                const DataColumn(label: Text('Remove')),
                              ],
                              rows: List.generate(data.length, (index) {
                                var charityProof = data[index];

                                return DataRow(cells: [
                                  DataCell(Text('${index + 1}')),
                                  DataCell(Text(charityProof['senderId'])),
                                  DataCell(Text("${DateFormat('dd-MMM-yyyy').format(charityProof['sendTime'].toDate())}")),
                                  DataCell(Container(
                                    height: h * 0.5,
                                    width: currentWidth < 800 ? w * 0.6 : 0.2,
                                    child:  Image(fit: BoxFit.fill,
                                      image: NetworkImage(
                                          charityProof ['file']),),
                                  )),
                                  DataCell(Text(charityProof['paymentM'])),
                                  DataCell(Text(charityProof['amount'])),
                                  DataCell(Container(
                                      height: 30,
                                      width: 60,
                                      decoration: BoxDecoration(
                                          color: Colors.red,
                                          borderRadius: BorderRadius.circular(
                                              3),
                                          border: Border.all(
                                              color: Colors.black.withOpacity(
                                                  0.3))),
                                      alignment: Alignment.center,
                                      child: const Text('View'))),
                                  DataCell(Container(
                                      height: 30,
                                      width: 90,
                                      decoration: BoxDecoration(
                                          color: Colors.yellow,
                                          borderRadius: BorderRadius.circular(
                                              3),
                                          border: Border.all(
                                              color: Colors.black.withOpacity(
                                                  0.3))),
                                      alignment: Alignment.center,
                                      child: InkWell(
                                          onTap: () async {

                                            DocumentSnapshot sendUser =
                                            await FirebaseFirestore
                                                .instance
                                                .collection('Users')
                                                .doc(charityProof.get('senderId'))
                                                .get();



                                            int a=1;
                                            print(a);a++;
                                            Map sendUserPlan={};

                                            for(var pln in plans){
                                              print(pln);
                                              if(pln['sno']==sendUser.get('sno')){
                                                sendUserPlan=pln;
                                                break;
                                              }
                                              else{

                                              }
                                            }
                                            print(sendUserPlan);
                                            print(a);a++;

                                            if(sendUser.get('clubAmt')[sendUser.get('sno')??0]??0 +(int.tryParse(data[index].get('amount').toString())??0)== sendUserPlan['club_amt']&&sendUser.get('charAmt')[sendUser.get('sno')??0]??0 ==sendUserPlan['char_amt']) {
                                              FirebaseFirestore
                                                  .instance
                                                  .collection('Users')
                                                  .doc(sendUser.id)
                                                  .update({

                                                'charAmt.${sendUser.get('sno')??0}':FieldValue.increment(int.tryParse(data[index].get('amount').toString())??0),
                                                'provideHelpUsers': {
                                                  'Id': '',
                                                  'Amount': 0,
                                                  "paidAmount": 0,
                                                }
                                              });
                                            }
                                            else if(sendUser.get('charAmt')[sendUser.get('sno')??0]??0 +(int.tryParse(data[index].get('amount').toString())??0) == sendUserPlan['char_amt']){
                                              FirebaseFirestore
                                                  .instance
                                                  .collection('Users')
                                                  .doc(sendUser.id)
                                                  .update({

                                                'charAmt.${sendUser.get('sno')??0}':FieldValue.increment(int.tryParse(data[index].get('amount').toString())??0),



                                                'provideHelpUsers': {
                                                  'Id': clubUser?.uid,
                                                  'Amount': sendUserPlan['club_amt'],
                                                  "paidAmount": 0,
                                                }
                                              });
                                            }
                                            else if(sendUser.get('charAmt')[sendUser.get('sno')??0]??0 +(int.tryParse(data[index].get('amount').toString())??0) != sendUserPlan['char_amt']){
                                              FirebaseFirestore
                                                  .instance
                                                  .collection('Users')
                                                  .doc(sendUser.id)
                                                  .update({

                                                'charAmt.${sendUser.get('sno')??0}':FieldValue.increment(int.tryParse(data[index].get('amount').toString())??0),
                                                'provideHelpUsers.paidAmount': FieldValue.increment(
                                                    int.tryParse(
                                                        data[index]['amount']) ??
                                                        0),
                                              });
                                            }








                                          },

                                          child:  Text(charityProof['verify'])))),
                                ]);
                              })),
                        ],
                      );
                    }
                  }),
            )
          ],
          ),
        ),
      ),
    );
  }
}

