import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/cordinator/cordinatorView.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/layout.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userModel.dart';
import 'loginpage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  Future loginEvent() async {

    final preferences = await SharedPreferences.getInstance();
    if(currentUserId!=null){
      preferences.setString('userId', currentUserId!);

    }else{
      currentUserId = preferences.getString('userId') ?? "";

    }
  
    print('UserId : ' + currentUserId!);
    setState(() {});
  }

  @override
  void initState() {
    // addFieldtoAlldoc();
    // TODO: implement initState
    loginEvent().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                     currentUserId == null || currentUserId == ""
                         ? Loginpage():currentUserId == 'cordinator@369'? CoView()
                         : const SiteLayout(index: 1)
            ),
                (route) => false);
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // var w = MediaQuery.of(context).size.width;
    // var h = MediaQuery.of(context).size.height;
    return Center(
      child: Image.asset('assets/369logo.jpg'),
    );
  }
}

logOutEvent(BuildContext context) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('userId');
  await prefs.remove('pass');
  // CoId='';
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>  Loginpage(),
      ),
          (route) => false);
}

// addFieldtoAlldoc() {
//   print('------------------');
//   FirebaseFirestore.instance.collection('Users').where('uid',isGreaterThan: 'GC10001353').get().then(
//         (value) => value.docs.forEach(
//           (element) async {
//             Map<String, dynamic> doc = element.data();
//             if (doc['sponsorname'] == null || doc['sponsorname'] == '') {
//               // FirebaseFirestore.instance
//               //     .collection('registration')
//               //     .get()
//               //     .then((events) {
//               //  events.docs.forEach((eee) {
//               //    Map<String, dynamic> doc1 = eee.data();
//               //    if (doc1['userId'] == doc['uid']) {
//               //      FirebaseFirestore.instance.collection('Users').doc(element.id).update({
//               //        'sponsoremobile': doc1['sponsoremobile'],
//               //        'sponsorname': doc1['sponsorname'],
//               //      });
//                    print(element.id);
//               //    }
//               //    });
//               // });
//             }
//           }));
//   print('------------------');
// }


// addFieldtoAlldoc() {
//   print('------------------');
//   FirebaseFirestore.instance.collection('Users').where('uid',isEqualTo:'GC2502694').get().then(
//         (value) => value.docs.forEach(
//           (element) async {
//
//             Map<String, dynamic> doc = element.data();
//             await FirebaseFirestore.instance.collection('Users').doc(element.id).update(
//                 {
//                   'address' :{}
//                 });
//
//
//                    print(element.id);
//
//
//           }));
//   print('------------------');
// }