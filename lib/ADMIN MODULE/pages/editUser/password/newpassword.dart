import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../widgets/changePassword.dart';
import '../editUser.dart';
import '../uploadDoc.dart';
import '../../../model/userModel.dart';
class NewPassword extends StatefulWidget {

  static const String id = "changepasswords";
  final UserModel user;
   NewPassword({Key? key, required this.user}) : super(key: key);

  @override
  State<NewPassword> createState() => _NewPasswordState();
}

class _NewPasswordState extends State<NewPassword> {
  var h;

  var w;

  List<List<dynamic>> data = [];

  List<dynamic> kms = [];

  void pickFile() async {
    final result = await FilePicker.platform.pickFiles(
      allowMultiple: false,
      withData: true,
      // withReadStream: true,
    );

    if (result == null) return;
    final file = result.files.first;
    print(file.name);
    _openFile(file);
  }

  List<int> pincodes = [];

  void _openFile(PlatformFile file) {
    print("-----------------------");
    List<List<dynamic>> listData =
    CsvToListConverter().convert(String.fromCharCodes(file.bytes!));
    print('abc');
    pincodes = [];
    List list = [];
    int dfgh = 0;
    for (dynamic a in listData) {


      dfgh++;
      print(dfgh);
    }
    // data = listData;
    // print(list[0]);
    // for(var data in list){
    //   FirebaseFirestore.instance.collection('Users')
    //       .doc(data[0])
    // }
    if(mounted) {
      setState(() {});
    }
  }

  var changekey = new GlobalKey<FormState>();
  TextEditingController currentpassword = TextEditingController();
  TextEditingController newpassword = TextEditingController();
  TextEditingController confirmpassword = TextEditingController();
  @override
  Widget build(BuildContext context) {
    h = MediaQuery.of(context).size.height;
    w = MediaQuery.of(context).size.width;
    return Scaffold(
      body: Form(
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
                      // TextFormField(
                      //   controller: currentpassword,
                      //   enabled: true,
                      //   decoration: const InputDecoration(
                      //     border: OutlineInputBorder(),
                      //     icon: Icon(Icons.keyboard),
                      //     labelText: 'Current password',
                      //   ),
                      //   validator: (value) {
                      //     if (currentpassword.text != currentuser?.password) {
                      //       return 'invalid Currentpassword';
                      //     } else
                      //       return null;
                      //   },
                      //   onEditingComplete: () {
                      //     setState(() {});
                      //   },
                      // ),
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
                              // pickFile();
                              if (changekey.currentState!.validate()) {
                                FirebaseFirestore.instance
                                    .collection('Users')
                                    .doc(widget
                                    .user
                                    .uid)
                                    .update({
                                  "password": newpassword.text,
                                }).then((value) {
                                  showUploadMessage(
                                      ' Password Updated', context);
                                });
                              }
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
    );
  }
}
