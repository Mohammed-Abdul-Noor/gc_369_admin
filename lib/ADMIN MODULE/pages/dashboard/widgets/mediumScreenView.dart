import 'package:flutter/material.dart';

import 'cards.dart';

class MediumScreenView extends StatelessWidget {
  const MediumScreenView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var h =MediaQuery.of(context).size.height;
    var w=MediaQuery.of(context).size.width;
    return Scaffold(
      body: Column(
        children: [
          Container(

            width: w,
            height: h,
            child: GridView.builder(gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 0.7,
                crossAxisSpacing: 25,
                childAspectRatio: 0.7,
                mainAxisExtent: 150
            ),
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
              itemBuilder: (context, index) {
                return Wrap(children:[
                  Cards(title: 'RS', value: '5764567', topColor: Colors.yellow, isActive: false, onTap: (){})
                ]);
              },),
          )

        ],
      ),
    );
  }
}
