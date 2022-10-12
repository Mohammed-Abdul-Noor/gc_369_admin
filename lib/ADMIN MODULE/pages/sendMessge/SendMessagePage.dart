import 'package:flutter/material.dart';

class SendMessagePage extends StatelessWidget {
  const SendMessagePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Scaffold(
        body:  Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: const [
                Padding(
                  padding: EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    'Send Message',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 25),
            Container(
              height: 4,
              width: w * 0.6,
              color: Colors.blue.shade900,
            ),
            Center(
              child: Container(
                padding: EdgeInsets.all(15),
                decoration:
                BoxDecoration(border: Border.all(color: Colors.black12)),
                width: w * 0.6,
                height: h * 0.5,
                // color: Colors.red,
                child: Column(
                  children: [
                    const Align(alignment: Alignment(-0.95,0.9),
                      child: Padding(
                        padding: EdgeInsets.only(top: 6),
                        child: Text(
                          'Send Message',
                          style: TextStyle(fontWeight: FontWeight.normal,
                              fontSize: 20),
                        ),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        hintText:'User ID',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        hintText:'Subject',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height: 15),
                    TextField(
                      decoration: InputDecoration(
                        hintText:'Message',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    const SizedBox(height:16 ),
                    Align(
                        alignment: const Alignment(-0.95, 1),
                        child: ElevatedButton(style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.green)),
                            onPressed: () {}, child: const Text('Send')))
                  ],
                ),
              ),
            )
          ],
        ),);
  }
}
