import 'package:flutter/material.dart';

import '../../../constants/style.dart';

class Cards extends StatelessWidget {
  final String title;
  final String value;
  final Color topColor;
  final bool isActive;
  final Function onTap;

  const Cards(
      {Key? key,
      required this.title,
      required this.value,
      required this.topColor,
      required this.isActive,
      required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: InkWell(
      onTap: (){},
          child: Container(
            height: 136,
            decoration: BoxDecoration(
              color: Colors.white,
              boxShadow: [BoxShadow(
                offset: Offset(0, 6),
                color: lightGrey.withOpacity(0.1),
                blurRadius: 12,
              )],
              borderRadius: BorderRadius.circular(16)
            ),
            child: Column(
              children: [
                Wrap(
                  children:[ Row(
                    children: [
                      Expanded(child: Container(
                        color: topColor ,
                        height: 5,
                      ))
                    ],
                  ),
                ]),
                Expanded(child: Container()),
                RichText(
                    textAlign: TextAlign.start,
                    text: TextSpan(
                      children: [
                        TextSpan(
                          text: '$value ',
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          )
                        ),
                    //     TextSpan(
                    // text: '$value',
                    // style: TextStyle(
                    //   color: Colors.black,
                    //   fontSize: 18,
                    //   fontWeight: FontWeight.bold,
                    //
                    // )),

                      ]

                )),Text('$title',style: TextStyle(fontSize: 18,color: Colors.black,),),
                Expanded(child: Container()),
              ],
            ),
          ),
    ));
  }
}
