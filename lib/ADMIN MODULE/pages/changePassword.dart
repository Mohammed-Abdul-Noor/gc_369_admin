import 'package:flutter/material.dart';

class ChangePasswordPage extends StatelessWidget {
  const ChangePasswordPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return Container(
      padding: const EdgeInsets.all(16),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(border: Border.all(color: Colors.black12)),
        width: w*0.96,
        height: h*0.6,
        child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Align(alignment: Alignment(-0.95,-1),
                child: Text('Update Password',style: TextStyle(fontSize: 17),)),
            const SizedBox(height:18 ),
            const Align(alignment: Alignment(-0.95,-1),
                child: Text('Username',style: TextStyle(fontWeight: FontWeight.bold),)),
            const TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const Align(alignment: Alignment(-0.95,-1),
                child: Text('Current Password',style: TextStyle(fontWeight: FontWeight.bold))),
            const TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const Align(alignment: Alignment(-0.95,-1),
                child: Text('New Password',style: TextStyle(fontWeight: FontWeight.bold))),
            const TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const Align(alignment: Alignment(-0.95,-1),
                child: Text('Confirm Password',style: TextStyle(fontWeight: FontWeight.bold))),
            const TextField(
              decoration: InputDecoration(border: OutlineInputBorder()),
            ),
            const SizedBox(height:15 ),
            Align(alignment: const Alignment(-0.95,0),
                child: ElevatedButton(onPressed: (){}, child: const Text('Change Password')))
          ],
        ),
      ),
    );
  }
}
