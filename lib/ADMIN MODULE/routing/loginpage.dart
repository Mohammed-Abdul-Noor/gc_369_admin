import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/cordinator/cordinatorView.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../model/userModel.dart';
import '../pages/layout.dart';
import '../widgets/changePassword.dart';

SharedPreferences? preferences;

// var CoId;
// var AdId;
class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}

String userId = "";
String password = "";

class _LoginpageState extends State<Loginpage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: const MyStatefulWidget(),
      ),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  const MyStatefulWidget({Key? key}) : super(key: key);

  @override
  State<MyStatefulWidget> createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  var loginkey = GlobalKey();

  @override
  void initState() {
    // loginEvent();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: loginkey,
      child: Padding(
          padding: const EdgeInsets.all(10),
          child: ListView(
            children: <Widget>[
              const Text(
                '369 Panel',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              const Text(
                'Please Login Here',
                style: TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 30),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      'User name',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  TextFormField(
                    controller: nameController,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your ID',
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 15, bottom: 15),
                    child: Text(
                      'Password',
                      style: TextStyle(color: Colors.black, fontSize: 17),
                    ),
                  ),
                  TextFormField(
                    obscureText: false,
                    controller: passwordController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      labelText: 'Your Password',
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                  height: 50,
                  padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
                  child: ElevatedButton(
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.green)),
                    child: const Text('submit',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () async {
                      try {
                        currentuser = null;
                        currentUserId = "";
                        DocumentSnapshot doc = await FirebaseFirestore.instance
                            .collection('settings')
                            .doc('settings')
                            .get();
                        // CoId = doc['cordinatorId'];
                        // AdId = doc['adminId'];
                        // print(' Coid        '+CoId);
                        if (!doc.exists) {
                          return;
                        }
                        if ((doc['adminId'] == nameController.text &&
                                doc['adminPassword'] ==
                                    passwordController.text) ||
                            (doc['cordinatorId'] == nameController.text &&
                                doc['copass'] == passwordController.text)) {
                          preferences = await SharedPreferences.getInstance();
                          preferences?.setString('userId', nameController.text);
                          preferences?.setString(
                              'pass', passwordController.text);
                          currentUserId = nameController.text;
                          currentUserId == doc['adminId']
                              ? Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                    pageBuilder: (context, _, __) =>
                                        SiteLayout(index: 1),
                                  ),
                                  (route) => false)
                              : Navigator.pushAndRemoveUntil(
                                  context,
                                  PageRouteBuilder(
                                      pageBuilder: (context, _, __) =>
                                          CoView()),
                                  (route) => false);
                        } else {
                          if ((doc['adminId'] != nameController.text) &&
                              (doc['cordinatorId'] != nameController.text)) {
                            showUploadMessage('Invalid User ID', context);
                          } else {
                            showUploadMessage('Invalid Password', context);
                          }
                        }
                      } catch (r) {
                        showUploadMessage('Invalid User Id', context);
                      }
                      print(nameController.text);
                      print(passwordController.text);
                      print('UserId : ' + currentUserId!);
                    },
                  )),
              SizedBox(height: 10),
              Center(child: Text('Version 1.1.3'))
            ],
          )),
    );
  }
}
