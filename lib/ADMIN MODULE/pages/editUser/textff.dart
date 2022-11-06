import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class TextFF extends StatefulWidget {
  final TextEditingController ctrl;
  final String label;
  final bool read;

  const TextFF({
    Key? key,
    required this.ctrl,
    required this.label, required this.read,
  }) : super(key: key);

  @override
  State<TextFF> createState() => _TextFFState();
}

class _TextFFState extends State<TextFF> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(widget.label),
          SizedBox(height: 3),
          TextFormField(
            readOnly: widget.read,
            // maxLines: 2,
            controller: widget.ctrl,
            decoration: InputDecoration(
              fillColor: Colors.blue.withOpacity(0.07),
              filled: true,
              labelStyle: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.yellow,
              ),
              border: InputBorder.none,
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.black,
                ),
              ),
            ),
            cursorColor: Colors.black,
            // validator: (ctrl){
            //   if(ctrl==null && ctrl!.isEmpty){
            //     return 'This field is empty';
            //   }else{
            //     return null;
            //   }
            // },
          ),
        ],
      ),
    );
  }
}
