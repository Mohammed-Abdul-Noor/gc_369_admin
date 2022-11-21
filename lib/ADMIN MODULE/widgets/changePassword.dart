import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../pages/editUser/uploadDoc.dart';
import '../model/userModel.dart';

class Changepasswords extends StatefulWidget {
  static const String id = "changepasswords";

  @override
  State<Changepasswords> createState() => _ChangepasswordsState();
}

class _ChangepasswordsState extends State<Changepasswords> {
  var h;
  var w;

  var changekey = new GlobalKey<FormState>();
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return ListView(
      children:[ Form(
        key: changekey,
        child: Container(
          decoration: BoxDecoration(
            color: Colors.blueGrey.shade50,
          ),
          padding: EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    'Change Password',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blueGrey.shade50,
                  ),
                  margin: EdgeInsets.all(50),
                  width: w * 0.7,
                  height: h * 0.7,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: currentpassword,
                        enabled: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.keyboard),
                          labelText: 'Current password',
                        ),
                        // validator: (value) {
                        //
                        //   if (currentpassword.text != doc['admin']) {
                        //     return 'invalid Currentpassword';
                        //   } else
                        //     return null;
                        // },
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: newpassword,
                        enabled: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.keyboard),
                          labelText: 'New password',
                        ),
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: confirmpassword,
                        enabled: true,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          icon: Icon(Icons.keyboard),
                          labelText: 'Confirms Password',
                        ),
                        validator: (value) {
                          if (confirmpassword.text != newpassword.text) {
                            return 'Not Match';
                          } else
                            return null;
                        },
                        onEditingComplete: () {
                          setState(() {});
                        },
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          confirmpassword.text != newpassword.text
                              ? SizedBox()
                              : ElevatedButton(
                            onPressed: () {
                              // if (changekey.currentState!.validate()) {
                                FirebaseFirestore.instance
                                    .collection('settings')
                                    .doc('settings')
                                    .update({
                                  "adminPassword": newpassword.text,
                                }).then((value) {
                                  showUploadMessage(
                                      ' Password Updated', context);
                                });
                              // }
                            },
                            child: Text(
                              'Update Password',
                            ),
                            style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all(Colors.blue)),
                          ),
                        ],
                      ),
                    ],
                  ),
                  //  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
   ] );
  }
}
void showUploadMessage(String message, BuildContext context,
    {bool showLoading = false}) {
  ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        duration: showLoading ? const Duration(minutes: 30) : const Duration(seconds: 4),
        content: Row(
          children: [
            if (showLoading)
              const Padding(
                padding: EdgeInsets.only(right: 10.0),
                child: CircularProgressIndicator(),
              ),
            Text(message),
          ],
        ),
      ),
    );
}
