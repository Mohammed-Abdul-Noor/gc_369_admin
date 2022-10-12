import 'package:flutter/material.dart';

import '../../../constants/style.dart';
class SmallCard extends StatelessWidget {
  final String title;
  final String value;
  final Function onTap;
  final bool isActive;
  const SmallCard(
      {Key? key,
      required this.title,
      required this.value,
      required this.onTap,
      required this.isActive})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wrap(
      children:[ Expanded(
          child: InkWell(
        onTap: () {},
        child: Container(
          padding: EdgeInsets.all(24),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              border:
                  Border.all(color: isActive ? active : lightGrey, width: .6)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.w300,
                  fontSize: 24,
                  color: isActive ? active : lightGrey,
                ),
              ),
              Text(title,
                  style: TextStyle(
                      fontWeight: FontWeight.w300,
                      fontSize: 24,
                      color: isActive ? active : lightGrey)),
            ],
          ),
        ),
      )),
    ]);
  }
}
