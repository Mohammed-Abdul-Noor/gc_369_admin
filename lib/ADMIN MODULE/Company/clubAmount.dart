import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/editUser/userModel.dart';
import '../pages/layout.dart';
import '../widgets/changePassword.dart';
import '../widgets/userApp.dart';

class CreateGenID extends StatefulWidget {
  const CreateGenID({Key? key}) : super(key: key);

  @override
  State<CreateGenID> createState() => _CreateGenIDState();
}

class _CreateGenIDState extends State<CreateGenID> {
  ScrollController? _controller1;
  @override
  Widget build(BuildContext context) {
    final currentWidth = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          shrinkWrap: true,
          children:[ Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Club Amount',
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
              Scrollbar(
                scrollbarOrientation: ScrollbarOrientation.top,
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: StreamBuilder<QuerySnapshot>(
                      stream: FirebaseFirestore.instance
                          .collection('genCreateProof')
                          .where('verify', isEqualTo: false)
                          .snapshots(),
                      builder: (context, snapshot) {

                        if (!snapshot.hasData) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasData &&
                            snapshot.data!.docs.isEmpty) {
                          return Text("Empty");
                        } else {
                          List<DocumentSnapshot> data = snapshot.data!.docs;
                          return Column(
                            children: [
                              DataTable(
                                  dataRowHeight: h * 0.5,
                                  border: TableBorder.all(
                                      color: Colors.black.withOpacity(0.1)),
                                  dataRowColor: MaterialStateProperty.resolveWith(
                                      (Set states) {
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
                                        onSort: (columnIndex, ascending) =>
                                            const Text(''),
                                        label: const Text('SI.No')),
                                    const DataColumn(label: Text('User ID')),
                                    const DataColumn(label: Text('Date')),
                                    const DataColumn(label: Text('Proof')),
                                    const DataColumn( label: Text('Payment Method')),
                                    const DataColumn(label: Text('Amount')),
                                    const DataColumn(label: Text('Status')),
                                    const DataColumn(label: Text('Remove')),
                                  ],
                                  rows: List.generate(data.length, (index) {
                                    DocumentSnapshot clubProof = data[index];

                                    return DataRow(cells: [
                                      DataCell(Text('${index + 1}')),
                                      DataCell(Text(clubProof['senderId'])),
                                      DataCell(Text(
                                          "${DateFormat('dd-MMM-yyyy').format(clubProof['sendTime'].toDate())}")),
                                      DataCell(CachedNetworkImage(imageUrl: clubProof['file'],

                                        width:currentWidth<700?w*0.4: w*0.2,
                                        fit: BoxFit.fitHeight, )
                                      ),
                                      DataCell(Text(clubProof['paymentM'])),
                                      DataCell(Text(clubProof['amount'])),
                                      DataCell(Container(
                                          height: 30,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              color: Colors.red,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.3))),
                                          alignment: Alignment.center,
                                          child: const Text('View'))),
                                      DataCell(Container(
                                          height: 30,
                                          width: 90,
                                          decoration: BoxDecoration(
                                              color: Colors.yellow,
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              border: Border.all(
                                                  color: Colors.black
                                                      .withOpacity(0.3))),
                                          alignment: Alignment.center,
                                          child: InkWell(
                                              onTap: () async {
                                               await getHelp(data,index,context,clubProof['senderId']);
                                              },
                                              child: Text('verify')))),
                                    ]);
                                  })),
                            ],
                          );
                        }
                      }),
                ),
              )
            ],
          ),
        ]),
      ),
    );
  }
}
getHelp(List<DocumentSnapshot> data,int index,BuildContext context,String id) async {
  DocumentSnapshot<Map<String, dynamic>> sendUser =
  await FirebaseFirestore
      .instance
      .collection('Users')
      .doc(id)
      .get();
  int totalAmount = int.tryParse(
      sendUser
          .get('provideHelpUsers')[
      'Amount']
          .toString()) ??
      0;
  int paidAmount = int.tryParse(
      sendUser
          .get('provideHelpUsers')[
      'paidAmount']
          .toString()) ??
      0;
  UserModel sendUsermodel = UserModel.fromJson(sendUser.data()!);


  Map<String, dynamic> transaction = {};
  if (planMap == {}) {
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
  transaction = planMap[sendUsermodel?.sno][sendUsermodel?.currentPlanLevel];
  if (transaction['amt'] == (int.tryParse(data[index]
  ['amount']
      .toString()) ??
      0)) {
    if (transaction['type'] == 3) {
      getClub(transaction, data, index, sendUsermodel);
    }




    data[index].reference.update({
      'verify': true
    }).then((value) {
      showUploadMessage("Successfuly", context);
      Navigator.pop(context);
    });
  }
  else{
    showUploadMessage("Incorrect Amount Send", context);
  }
}
getClub(Map<String,dynamic> transaction,List<DocumentSnapshot> data,int index,UserModel sndUsr){

  if(transaction['cnt']==sndUsr.currentCount!+1 && planMap[sndUsr.sno]['last']==currentuser?.currentPlanLevel) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(sndUsr.uid)
        .update({
      'clubAmt.${sndUsr.sno}':
      FieldValue.increment(
          int.tryParse(data[
          index]
          [
          'amount']) ??
              0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },

      'sno':
      FieldValue.increment(
          1),
      'eligible': true,
      'currentPlanLevel':0,
      'currentCount':0,
      'enteredDate.${sndUsr.sno??0 + 1}':
      FieldValue
          .serverTimestamp(),
    });
  }
  else if(transaction['cnt']==sndUsr.currentCount!+1){
    FirebaseFirestore.instance
        .collection('Users')
        .doc(sndUsr.uid)
        .update({

      'clubAmt.${sndUsr.sno}':
      FieldValue.increment(
          int.tryParse(data[
          index]
          [
          'amount']) ??
              0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'eligible':!transaction['sent'],
      'currentPlanLevel':FieldValue.increment(1),
      'currentCount': 0,
    });
  }
  else {

    FirebaseFirestore.instance
        .collection('Users')
        .doc(sndUsr.uid)
        .update({
      'clubAmt.${sndUsr.sno}':
      FieldValue.increment(
          int.tryParse(data[
          index]
          [
          'amount']) ??
              0),
      'provideHelpUsers': {
        'Id': "",
        'Amount': 0,
        "paidAmount": 0,
      },
      'currentCount': FieldValue.increment(1),

    });
  }
}

