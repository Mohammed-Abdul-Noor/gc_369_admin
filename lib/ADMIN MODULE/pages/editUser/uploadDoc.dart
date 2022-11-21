

import 'dart:io';
import 'package:gc_369/ADMIN%20MODULE/model/userModel.dart';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

int currentUserId=currentUserListener('');

String url='';

String urb='';
class UploadDoc extends StatefulWidget {
  const UploadDoc({Key? key}) : super(key: key);

  @override
  State<UploadDoc> createState() => _UploadDocState();
}

class _UploadDocState extends State<UploadDoc> {
  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? file;
  var bytes;
  @override
  Widget build(BuildContext context) {
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return  AlertDialog(
      title: const Text('Upload proof'),
      content: Row(
        mainAxisSize:
        MainAxisSize.min,
        mainAxisAlignment:
        MainAxisAlignment
            .spaceAround,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Front side'),
              Container(
                height: h * 0.18,
                width: w * 0.23,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)
                ),
                child: url!=''?CachedNetworkImage(imageUrl: url,fit: BoxFit.cover,):SizedBox(),
              ),
              ElevatedButton(onPressed: (){
                setState(() {
                  imgFromGallery();
                });

              }, child: Text('Add')),
            ],
          ),
          const SizedBox(width: 6),
          Column(
            mainAxisSize:
            MainAxisSize
                .min,
            children: [
              const Text('Back side'),
              Container(
                height:
                h * 0.18,
                width:
                w * 0.23,
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black12)
                ),
                child: urb!=''?CachedNetworkImage(imageUrl: urb, fit: BoxFit.cover,):SizedBox(),
                // color: Colors
                //     .red,
              ),
              ElevatedButton(onPressed: (){
                imgFromGalleryb();

              }, child: Text('Add')),

            ],
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () {
              url='';
              urb='';
              Navigator.pop(context);
            },
            child:  Text(
                'Cancel')),
        TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
                'Done')),
      ],
    );
  }
  Future imgFromGallery() async {
    print('----------------------HERE?-------------------------');
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    var fileName = DateTime.now();
    var ref = await FirebaseStorage.instance.ref().child('proofs/$currentUserId/$fileName');
    Uri blobUri = Uri.parse(pickedFile.path);
    http.Response response = await http.get(blobUri);
    await ref
        .putData(response.bodyBytes, SettableMetadata(contentType: 'image/png'))
        .then((p0) async {
      url = (await ref.getDownloadURL()).toString();
      print(url);
      setState(() {});
    });

  }
  Future imgFromGalleryb() async {
    print('----------------------HERkkkE?-------------------------');
    pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    var fileName = DateTime.now();
    var ref = await FirebaseStorage.instance.ref().child('proofs/$currentUserId/$fileName');
    Uri blobUri = Uri.parse(pickedFile.path);
    http.Response response = await http.get(blobUri);
    await ref
        .putData(response.bodyBytes, SettableMetadata(contentType: 'image/png'))
        .then((p0) async {
      urb = (await ref.getDownloadURL()).toString();
      print(url);
      setState(() {});
    });

  }
}
