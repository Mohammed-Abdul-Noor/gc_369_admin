import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import '../navigation/navigationDrawer.dart';
import '../responsiveness/responsive.dart';
import '../widgets/largeScreen.dart';
import '../widgets/smalScreen.dart';
import '../widgets/top_nav.dart';
import '../model/userModel.dart';
Map<String, dynamic> currentPlan = {};
var rcv_amt;
var snd_amt;
int currentUserLevel =0;
UserModel? clubUser;
UserModel? charityUser;
List plans = [];
List phData = [];
List ghData = [];
//List plans = [];
Map planMap = {};
//List sendUserdata=[];
//Map sendUserdata={};
Map sendUserPlan = {};


setSearchParam(String caseNumber) {
  List<String> caseSearchList = [];
  String temp = "";

  List<String> nameSplits = caseNumber.split(" ");
  for (int i = 0; i < nameSplits.length; i++) {
    String name = "";

    for (int k = i; k < nameSplits.length; k++) {
      name = name + nameSplits[k] + " ";
    }
    temp = "";

    for (int j = 0; j < name.length; j++) {
      temp = temp + name[j];
      caseSearchList.add(temp.toUpperCase());
    }
  }
  return caseSearchList;
}
class SiteLayout extends StatefulWidget {
   final int index;
   const SiteLayout({Key? key, required this.index}) : super(key: key);
  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}


class _SiteLayoutState extends State<SiteLayout> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();
  // addFieldtoAlldoc() {
  //
  //   FirebaseFirestore.instance
  //       .collection('proof')
  //       .get()
  //       .then((event) {
  //     for (DocumentSnapshot doc in event.docs) {
  //       List sr =setSearchParam(doc['senderId']+" "+doc['receiverId']);
  //
  //       FirebaseFirestore.instance.collection('proof').doc(doc.id).update({
  //         'search': sr,
  //       }).whenComplete(() => 'updated');
  //
  //     }
  //   });
  // }
  // addFieldtoAlldoc() {
  //   FirebaseFirestore.instance.collection('registration').get().then(
  //         (value) => value.docs.forEach(
  //           (element) async {
  //         Map<String, dynamic> d = element.data();
  //         if (d['userId'] == null) {
  //
  //           await FirebaseFirestore.instance
  //               .collection('registration')
  //               .doc(element.id)
  //               .update({
  //             'userId': d['userId'] ?? "",
  //           }).whenComplete(() {
  //             print('Field Updated: ${element.id}');
  //           });
  //         }
  //       },
  //     ),
  //   );
  //   print('55555555555555555555555555');
  // }

  getCurrentPlan() async {
    print('33333333333333333333333333333');
    DocumentSnapshot<Map<String, dynamic>> event = await FirebaseFirestore
        .instance
        .collection('settings')
        .doc('settings')
        .get();
    if (event.exists) {
      plans = event.data()!['plan'];
    }
    if (currentPlan.keys.isEmpty && currentuser != null) {
      for (int i = 0; i < plans.length; i++) {
        if (plans[i]['sno'] == currentUserLevel) {
          currentPlan = plans[i];

          break;
        }
        // else if (currentUserLevel == 0) {
        //   currentPlan = plans[5];

        //   setState(() {});
        //   break;
        //  }
      }
    }
    DocumentSnapshot<Map<String, dynamic>> clUsr = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(event.data()!['clubId'])
        .get();
    clubUser = UserModel.fromJson(clUsr.data()!);
    DocumentSnapshot<Map<String, dynamic>> chUsr = await FirebaseFirestore
        .instance
        .collection('Users')
        .doc(event.data()!['charityId'])
        .get();
    charityUser = UserModel.fromJson(chUsr.data()!);
    rcv_amt = currentPlan['rcv_amt'];
    snd_amt = currentPlan['snd_amt'];
    if(mounted) {
      setState(() {});
    }
  }



  @override
  void initState() {
    // TODO: implement initState
    //addFieldtoAlldoc();



    getCurrentPlan();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: const Drawer(
          child: NavigationDrawerWidget(),
        ),
       body: ResponsiveWidget(largeScreen: LargeScreen(index: widget.index,),smallScreen: SmallScreen(index: widget.index,), mediumScreen: LargeScreen(index: widget.index,))
    );
  }
}
