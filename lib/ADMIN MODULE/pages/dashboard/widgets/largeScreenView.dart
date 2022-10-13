import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../widgets/gridCont.dart';

List valuelist = [
  {
    "title": "Total Members",
    "value": totalMembers.toString(),
    "color": Colors.orange
  },
  {"title": "Total IDs", "value": totalId.toString(), "color": Colors.red},
  {
    "title": "Total Rebirth IDs",
    "value": totalRebirthId.toString(),
    "color": Colors.black
  },
  {"title": "Total Gen IDs", "value": "0", "color": Colors.deepOrangeAccent},
  {
    "title": "Total Received Amount",
    "value": totalAmount.toString(),
    "color": Colors.pink
  },
  {"title": "Total GH", "value": totalGH.toString(), "color": Colors.green},
  {"title": "Total PH", "value": totalPH.toString(), "color": Colors.indigo},
];
int? totalMembers;
int? totalId;
double? totalRebirthId;
double? totalAmount;
double? totalGH;
double? totalPH;

class LargeScreenView extends StatefulWidget {
  const LargeScreenView({Key? key}) : super(key: key);

  @override
  State<LargeScreenView> createState() => _LargeScreenViewState();
}

class _LargeScreenViewState extends State<LargeScreenView> {
  @override
  void initState() {
    super.initState();
    getCount();
    loop();
  }

  getCount() {
    FirebaseFirestore.instance.collection('Users').snapshots().listen((event) {
      totalMembers = 0;
      totalId = 0;
      totalRebirthId = 0;
      totalAmount = 0;
      totalGH = 0;
      totalPH = 0;
      totalMembers = event.docs.length;
      for (DocumentSnapshot user in event.docs) {
        if (user['status'] == true) {
          totalId = totalId! + 1;
        }
        totalRebirthId = totalRebirthId! + user['rebirthId'];
        totalGH = totalGH! + user['receivehelp'];
        totalPH = totalPH! + user['sendhelp'];
      }
      print(totalId);
      print(totalId! * 119);
      totalAmount = totalAmount! + (119 * totalId!);

      setState(() {});
    });
    print(mounted);
    if (mounted) {
      setState(() {});
    }
  }

  loop() async {
    for (int i = 1; i > 0; i++) {
      if (totalMembers != null) {
        setState(() {});
        break;
      }
      await Future.delayed(Duration(seconds: 1));
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.width;
    var w = MediaQuery.of(context).size.height;
    return totalMembers == null
        ? const Center(
            child: CircularProgressIndicator(),
          )
        : Column(
            children: [
              Container(
                width: h * 0.9,
                height: w,
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 20,
                      crossAxisSpacing: 30,
                      childAspectRatio: 0.7,
                      mainAxisExtent: 150),
                  itemCount: valuelist.length,
                  itemBuilder: (context, index) {
                    return Wrap(children: [
                      GContainer(
                        title: valuelist[index]['title'],
                        value: valuelist[index]['value'],
                        color: valuelist[index]['color'],
                      )
                    ]);
                  },
                ),
              )
            ],
          );
  }
}
