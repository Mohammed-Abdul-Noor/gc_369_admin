import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import '../../../widgets/gridCont.dart';

List valuelist = [
  {
    "title": "Total Members",
    "value": getCount().toString(),
    "color": Colors.orange
  },
  {"title": "Total IDs", "value": "3253", "color": Colors.red},
  {"title": "Total IDs", "value": "256", "color": Colors.black},
  {"title": "Total Gen IDs", "value": "0", "color": Colors.deepOrangeAccent},
  {"title": "Total Received Amount", "value": "387107", "color": Colors.pink},
  {"title": "Total GH", "value": "1995000", "color": Colors.green},
  {"title": "Total PH", "value": "1995000", "color": Colors.indigo},
];

Future<int> getCount() async {
  int count = await FirebaseFirestore.instance
      .collection('collection')
      .get()
      .then((value) => value.size);
  print("----------------------------------------------");
  print(count);
  print("----------------------------------------------");
  return count;
}

class LargeScreenView extends StatelessWidget {
  const LargeScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.width;
    var w = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Container(
          width: h * 0.9,
          height: h,
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
