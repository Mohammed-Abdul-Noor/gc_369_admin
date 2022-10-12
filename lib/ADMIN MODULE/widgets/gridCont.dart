import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GContainer extends StatefulWidget {
  final title;
  final value;
  final color;

  GContainer({
    Key? key,
    this.title,
    this.value,
    this.color,
  }) : super(key: key);

  @override
  State<GContainer> createState() => _GContainerState();
}

class _GContainerState extends State<GContainer> {
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return Container(
      width: w * 0.35,
      height: h * 0.2,
      decoration: BoxDecoration(
          color: widget.color,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 5,
              blurRadius: 7,
              offset: Offset(0, 3),
            )
          ]),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  widget.value,
                  style: TextStyle(fontSize: 30, color: Colors.white),
                )
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              children: [
                Text(
                  widget.title,
                  style: TextStyle(fontSize: 18, color: Colors.white),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
