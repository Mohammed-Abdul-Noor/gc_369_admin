import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../pages/editUser/ProvideHelp.dart';
import '../pages/editUser/genIDModel.dart';
import '../pages/editUser/getHelp.dart';
import '../model/userModel.dart';
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
                                        DataCell(SelectableText(clubProof['senderId'])),
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
  Map<String, dynamic> nextTransaction = {};
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
  transaction = planMap[sendUsermodel?.sno.toString()][sendUsermodel?.currentPlanLevel.toString()];
  nextTransaction = planMap[sendUsermodel?.sno.toString()]['${(sendUsermodel?.currentPlanLevel??0)+1}']??{};
  if (transaction['amt'] == (int.tryParse(data[index]
  ['amount']
      .toString()) ??
      0)) {
    if (transaction['type'] == 5) {
      getGenId(transaction, data, index, sendUsermodel,nextTransaction);
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
getGenId(Map<String,dynamic> transaction,List<DocumentSnapshot> data,int index,UserModel sndUsr,Map<String,dynamic> nextTransaction){
  createGenId(sndUsr);
  if(transaction['cnt']==sndUsr.currentCount!+1 && planMap[sndUsr.sno.toString()]['last']==sndUsr?.currentPlanLevel) {
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
      'eligible':!nextTransaction['sent'],
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
createGenId(UserModel sndUsr) async {
  DocumentSnapshot id =
  await FirebaseFirestore
      .instance
      .collection('settings')
      .doc('settings')
      .get();
  await id.reference.update({
    "userId":
    FieldValue.increment(1)
  });
  var user =
  id["userId"].toString();

  var userid = "GCA$user";
  var userdata;
  if(sndUsr.genId?.firstGenId==""){
    userid = "GCA$user";
    userdata = UserModel(
      address: sndUsr.address,
      bproof: sndUsr.bproof,
      charAmt: {},
      clubAmt: {},
      directmember: 0,
      downline1: 0,
      downline2: 0,
      downline3: 0,
      checkGenId: false,
      eligible: true,
      email: sndUsr.email,
      enteredDate: {
        '0' :FieldValue.serverTimestamp(),
      },
      fproof: sndUsr.fproof,
      genId: GenIdModel(
          firstGenId: "",
          secondGenId: "",
          thirdGenId: ""),
      getCount: {},
      getHelpUsers: GetHelpUsers(
        Amount: 0,
        Id: '',
        receiveAmount: 0,
      ),
      googlepayno: sndUsr.googlepayno,
      ifscno: sndUsr.ifscno,
      index: int.tryParse(user),
      joinDate: DateTime.now(),
      levelincome: 0,
      mobno: sndUsr.mobno,
      motherId: false,
      mystatus: sndUsr.mystatus,
      name:sndUsr.name,
      paytmno: sndUsr.paytmno,
      phonepayno: sndUsr.phonepayno,
      password: sndUsr.password,
      provideHelpUsers:
      ProvideHelpUsers(
          Amount: 0,
          Id: '',
          paidAmount: 0),
      panNo: sndUsr.panNo,
      provideCount: {},
      rebirthId: 0,
      receivehelp: 0,
      receiveCount: 0,
      referral: [],
      sendCount: 0,
      search: setSearchParam(userid+''+sndUsr.name!),
      sendhelp: 0,
      sno: 1,
      spnsr_Id: sndUsr.spnsr_Id,
      spnsrId2: sndUsr.spnsr_Id,
      spnsrId3: sndUsr.spnsr_Id,
      spnsrAmt1: {},
      spnsrAmt2: {},
      spnsrAmt3: {},
      sponsoremobile: '',
      sponsorincome: 0,
      status: sndUsr.status,
      type: sndUsr.type,
      upiId: sndUsr.upiId,
      uid: userid,
      upgradeAmt: {},
      wallet: 0,
      whatsNO: sndUsr.whatsNO,
      whatsappcc: sndUsr.whatsappcc,
    );
  }
  else if(sndUsr.genId?.secondGenId==""){
    userid = "GCB$user";
    userdata = UserModel(
      address: sndUsr.address,
      bproof: sndUsr.bproof,
      charAmt: {},
      clubAmt: {},
      directmember: 0,
      downline1: 0,
      downline2: 0,
      downline3: 0,
      checkGenId: false,
      eligible: true,
      email: sndUsr.email,
      enteredDate: {
        '0' :FieldValue.serverTimestamp(),
      },
      fproof: sndUsr.fproof,
      genId: GenIdModel(
          firstGenId: "",
          secondGenId: "",
          thirdGenId: ""),
      getCount: {},
      getHelpUsers: GetHelpUsers(
        Amount: 0,
        Id: '',
        receiveAmount: 0,
      ),
      googlepayno: sndUsr.googlepayno,
      ifscno: sndUsr.ifscno,
      index: int.tryParse(user),
      joinDate: DateTime.now(),
      levelincome: 0,
      mobno: sndUsr.mobno,
      motherId: false,
      mystatus: sndUsr.mystatus,
      name:sndUsr.name,
      paytmno: sndUsr.paytmno,
      phonepayno: sndUsr.phonepayno,
      password: sndUsr.password,
      provideHelpUsers:
      ProvideHelpUsers(
          Amount: 0,
          Id: '',
          paidAmount: 0),
      panNo: sndUsr.panNo,
      provideCount: {},
      rebirthId: 0,
      receivehelp: 0,
      receiveCount: 0,
      referral: [],
      sendCount: 0,
      search: setSearchParam(userid+''+sndUsr.name!),
      sendhelp: 0,
      sno: 1,
      spnsr_Id: sndUsr.spnsrId2,
      spnsrId2: sndUsr.spnsrId2,
      spnsrId3: sndUsr.spnsrId2,
      spnsrAmt1: {},
      spnsrAmt2: {},
      spnsrAmt3: {},
      sponsoremobile: '',
      sponsorincome: 0,
      status: sndUsr.status,
      type: sndUsr.type,
      upiId: sndUsr.upiId,
      uid: userid,
      upgradeAmt: {},
      wallet: 0,
      whatsNO: sndUsr.whatsNO,
      whatsappcc: sndUsr.whatsappcc,
    );
  }
  else if(sndUsr.genId?.thirdGenId==""){
    userid = "GCC$user";
    userdata = UserModel(
      address: sndUsr.address,
      bproof: sndUsr.bproof,
      charAmt: {},
      clubAmt: {},
      directmember: 0,
      downline1: 0,
      downline2: 0,
      downline3: 0,
      checkGenId: false,
      eligible: true,
      email: sndUsr.email,
      enteredDate: {
        '0' :FieldValue.serverTimestamp(),
      },
      fproof: sndUsr.fproof,
      genId: GenIdModel(
          firstGenId: "",
          secondGenId: "",
          thirdGenId: ""),
      getCount: {},
      getHelpUsers: GetHelpUsers(
        Amount: 0,
        Id: '',
        receiveAmount: 0,
      ),
      googlepayno: sndUsr.googlepayno,
      ifscno: sndUsr.ifscno,
      index: int.tryParse(user),
      joinDate: DateTime.now(),
      levelincome: 0,
      mobno: sndUsr.mobno,
      motherId: false,
      mystatus: sndUsr.mystatus,
      name:sndUsr.name,
      paytmno: sndUsr.paytmno,
      phonepayno: sndUsr.phonepayno,
      password: sndUsr.password,
      provideHelpUsers:
      ProvideHelpUsers(
          Amount: 0,
          Id: '',
          paidAmount: 0),
      panNo: sndUsr.panNo,
      provideCount: {},
      rebirthId: 0,
      receivehelp: 0,
      receiveCount: 0,
      referral: [],
      sendCount: 0,
      search: setSearchParam(userid+''+sndUsr.name!),
      sendhelp: 0,
      sno: 1,
      spnsr_Id: sndUsr.spnsrId3,
      spnsrId2: sndUsr.spnsrId3,
      spnsrId3: sndUsr.spnsrId3,
      spnsrAmt1: {},
      spnsrAmt2: {},
      spnsrAmt3: {},
      sponsoremobile: '',
      sponsorincome: 0,
      status: sndUsr.status,
      type: sndUsr.type,
      upiId: sndUsr.upiId,
      uid: userid,
      upgradeAmt: {},
      wallet: 0,
      whatsNO: sndUsr.whatsNO,
      whatsappcc: sndUsr.whatsappcc,
    );
  }
  else{
    return;
  }




  FirebaseFirestore.instance
      .collection('settings')
      .doc('settings')
      .update({

    'totalGenId':
    FieldValue.increment(1),
  }).then((value) {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(userid)
        .set(userdata.toJson());
  });
}

