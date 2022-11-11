import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/layout.dart';
SharedPreferences? preferences;
class Loginpage extends StatefulWidget {
  @override
  State<Loginpage> createState() => _LoginpageState();
}
String userId="";
String password="";
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
  Future loginEvent() async {
    preferences = await SharedPreferences.getInstance();
    userId = preferences?.getString('userId') ?? "";
    password = preferences?.getString('password') ?? "";
    if (userId == 'admin@gmail.com' &&
        password == 'admin369') {
      Navigator.of(context).push(MaterialPageRoute(
          builder: (context) => SiteLayout(index: 1))
      );

      print(nameController.text);
      print(passwordController.text);
    }
    //var password =localStorage.getString('pass');

    setState(() {});
  }

  @override
  void initState() {
    loginEvent();
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
                'Admin Panel',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 25),
              ),
              const Text(
                'Please Login Here',
                style: TextStyle(
                    color: Colors.red, fontWeight: FontWeight.w500, fontSize: 30),
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
                        backgroundColor: MaterialStateProperty.all(Colors.green)),
                    child: const Text('submit',
                        style: TextStyle(color: Colors.white)),
                    onPressed: () {
                      if (nameController.text == 'admin@gmail.com' &&
                          passwordController.text == 'admin369') {
                        preferences?.setString('userId',
                            nameController.text);
                        preferences?.setString('password',
                            passwordController.text);
                        Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => SiteLayout(index: 1))
                        );

                        print(nameController.text);
                        print(passwordController.text);
                      }
                      // Navigator.of(context).push(MaterialPageRoute(
                      //    builder: (context) => SiteLayout(index: 1)));
                    },
                  )),
              SizedBox(height: 10),
              Center(child: Text('Version 1.0.4'))
            ],
          )),
    );
  }
}
