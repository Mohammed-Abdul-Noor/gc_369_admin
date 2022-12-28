import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    // TODO: implement initState
    loginEvent().whenComplete(() async {
      Timer(const Duration(seconds: 3), () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
                builder: (context) =>
                     currentUserId == null || currentUserId == ""
                    ? Loginpage()
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
  Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) =>  Loginpage(),
      ),
          (route) => false);
}