import 'dart:io';
import 'dart:typed_data';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/editUser/textff.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/editUser/uploadDoc.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/editUser/userModel.dart';
import 'package:http/http.dart' as http;

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';



class EditUser extends StatefulWidget {
  static const String id = "TopProfile";
  final UsersModel user;

  EditUser({
    Key? key,
    required this.user,
  }) : super(key: key);

  @override
  State<EditUser> createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  RegExp phnValidation = RegExp(r'[0-9]{10}$');
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  List<String> listState = ['Kerala', 'Outside Kerala'];
  List<String> listDistrict = ['select District'];
  var state;
  var district;
  bool imageAvailable = false;
  late Uint8List imageFile;
  var typeId;
  UsersModel? user;
  TextEditingController s = TextEditingController();
  TextEditingController joinDateController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController userIdController = TextEditingController();
  TextEditingController mobileNumberController = TextEditingController();
  TextEditingController fullAddressController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController stateController = TextEditingController();
  TextEditingController pinCodeController = TextEditingController();

  TextEditingController mailIdController = TextEditingController();

  TextEditingController acNumberController = TextEditingController();
  TextEditingController whatsappNumberController = TextEditingController();

  TextEditingController acHolderNameController = TextEditingController();

  TextEditingController ifscCodeController = TextEditingController();

  TextEditingController bankNameController = TextEditingController();
  TextEditingController panNoController = TextEditingController();

  TextEditingController branchNameController = TextEditingController();

  TextEditingController googlePayController = TextEditingController();

  TextEditingController phonePayController = TextEditingController();

  TextEditingController payTmController = TextEditingController();

  TextEditingController upiIdController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState

    user = widget.user;
    // address=widget.user.address;

    if (kDebugMode) {
      print(widget.user.address);
    }
    url=currentuser?.fProof??"";
    urb=currentuser?.bProof??"";
    print("+++++++++++++++++++++++++++++++++++++++");
    print(url);
    print(urb);
    typeId=currentuser?.type??"";
    mailIdController = TextEditingController(text: widget.user.email);
    userIdController = TextEditingController(text: widget.user.uid);
    joinDateController = TextEditingController(
        text: widget.user.joinDate.toString().substring(0, 10));
    nameController = TextEditingController(text: widget.user.name);
    mobileNumberController = TextEditingController(text: widget.user.mobno);
    whatsappNumberController = TextEditingController(text: widget.user.whatsNO);
    fullAddressController =
        TextEditingController(text: user?.address?['hname']??"");
    pinCodeController = TextEditingController(text: user?.address?['pincode']??"");

    stateController = TextEditingController(text: user?.address?['state']??"");
    districtController = TextEditingController(text: user?.address?['city']??"");

    if (user!.address!['state'] == 'Kerala') {
      listDistrict = [
        'Alappuzha',
        'Ernakulam',
        'Idukki',
        'Kannur',
        'Kasaragod',
        'Kollam',
        'Kottayam',
        'Kozhikode',
        'Malappuram',
        'Palakkad',
        'Pathanamthitta',
        'Thiruvananthapuram',
        'Thrissur',
        'Wayanad',
      ];
    } else {
      listDistrict = ['Other'];
    }
    acNumberController = TextEditingController(text: widget.user.accno);
    acHolderNameController =
        TextEditingController(text: widget.user.accholname);
    ifscCodeController = TextEditingController(text: widget.user.ifscno);
    bankNameController = TextEditingController(text: widget.user.bankname);
    panNoController = TextEditingController(text: widget.user.panNo ?? '');
    branchNameController = TextEditingController(text: widget.user.branch);
    googlePayController = TextEditingController(text: widget.user.googlepayno);
    upiIdController = TextEditingController(text: widget.user.upiId);
    super.initState();
  }

  String whatsappcountryCode = '';
  String mobilecountryCode = '';
  var pickedFile;
  final ImagePicker _picker = ImagePicker();
  File? file;
  var bytes;
  @override
  Widget build(BuildContext context) {
    print("+++++++++++++++++++++++++++++++++++++++");
    print(url);
    print(urb);
    final currentWidth = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    var w = MediaQuery.of(context).size.width;
    return widget.user == null
        ? const CircularProgressIndicator()
        :  Scaffold(
          body: Container(
          width: double.infinity,
          color: Colors.teal,
          child:
          SingleChildScrollView(
            child: Column(
              children: [
                Text(
                  'your Profile',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 30,
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: const Color(0XFFFFFFFF)),
                  width: w * 0.9,
                  child: Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Form(
                        child: Column(
                          children: [
                            Container(
                              width: w * 0.9,
                              padding:
                              const EdgeInsets.only(left: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0XFFC7F3F0),
                                  borderRadius:
                                  BorderRadius.circular(25)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Sponsor ID:',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      widget.user.spnsr_Id!,
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: w * 0.9,
                              padding:
                              const EdgeInsets.only(left: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0XFFC7F3F0),
                                  borderRadius:
                                  BorderRadius.circular(25)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Sponsor Name:',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      sponsorUser1?.name??"",
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              width: w * 0.9,
                              padding:
                              const EdgeInsets.only(left: 15),
                              height: 50,
                              decoration: BoxDecoration(
                                  color: const Color(0XFFC7F3F0),
                                  borderRadius:
                                  BorderRadius.circular(25)),
                              child: SingleChildScrollView(
                                scrollDirection: Axis.horizontal,
                                child: Row(
                                  children: [
                                    const Text(
                                      'Sponsor No:',
                                      style: TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Text(
                                      sponsorUser1?.mobno??"",
                                      style: const TextStyle(
                                          fontWeight:
                                          FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            const Text(
                              'Personal Details',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: userIdController,
                              label: 'User ID',
                              read: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: joinDateController,
                              label: 'Join Date',
                              read: true,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: nameController,
                              label: 'Full Name',
                              read: false,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Mobile Number')),
                            Container(
                              height: 50,
                              width: w * 0.9,
                              color: Colors.blue.withOpacity(0.07),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7),
                                    child: Text(mobilecountryCode),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showCountryPicker(
                                        context: context,
                                        //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                        exclude: <String>['KN', 'MF'],
                                        favorite: <String>['SE'],
                                        //Optional. Shows phone code before the country name.
                                        showPhoneCode: true,
                                        onSelect: (country) {
                                          if (kDebugMode) {
                                            print(
                                                'Select country: ${country.displayName}');
                                          }
                                          if (kDebugMode) {
                                            print(country.flagEmoji);
                                          }
                                          mobilecountryCode =
                                          '${country.flagEmoji} ${country.phoneCode}';
                                          setState(() {});
                                        },
                                        // Optional. Sets the theme for the country list picker.
                                        countryListTheme:
                                        CountryListThemeData(
                                          // Optional. Sets the border radius for the bottomsheet.
                                          bottomSheetHeight: h * 0.5,
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(40.0),
                                            topRight:
                                            Radius.circular(40.0),
                                          ),
                                          // Optional. Styles the search field.
                                          inputDecoration:
                                          InputDecoration(
                                            labelText: 'Search',
                                            hintText:
                                            'Start typing to search',
                                            prefixIcon: const Icon(
                                                Icons.search),
                                            border:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(
                                                    0xFF8C98A8)
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_drop_down),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType:
                                      TextInputType.number,
                                      maxLines: 1,
                                      maxLength: 10,
                                      controller:
                                      mobileNumberController,
                                      decoration:
                                      const InputDecoration(
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      cursorColor: Colors.black,
                                      autovalidateMode:
                                      AutovalidateMode
                                          .onUserInteraction,
                                      validator: (value) {
                                        String patttern = r'(^[0-9]*$)';
                                        RegExp regExp = new RegExp(patttern);
                                        if (value!.isEmpty) {
                                          return "Mobile is Required";
                                        } else if(value.length != 10){
                                          return "Mobile number must 10 digits";
                                        }else if (!regExp.hasMatch(value)) {
                                          return "Mobile Number must be digits";
                                        }
                                        return null;

                                        // if (!phnValidation
                                        //     .hasMatch(v!)) {
                                        //   return "Enter valid Phone Number";
                                        // } else {
                                        //   return null;
                                        // }
                                      },
                                      // validator: (v) {
                                      //   if (!phnValidation
                                      //       .hasMatch(v!)) {
                                      //     return "Enter valid Phone Number";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('WhatsApp Number')),
                            Container(
                              height: 50,
                              width: w * 0.9,
                              color: Colors.blue.withOpacity(0.07),
                              child: Row(
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(
                                        left: 7),
                                    child: Text(whatsappcountryCode),
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      showCountryPicker(
                                        context: context,
                                        //Optional.  Can be used to exclude(remove) one ore more country from the countries list (optional).
                                        exclude: <String>['KN', 'MF'],
                                        favorite: <String>['SE'],
                                        //Optional. Shows phone code before the country name.
                                        showPhoneCode: true,
                                        onSelect: (country) {
                                          if (kDebugMode) {
                                            print(
                                                'Select country: ${country.displayName}');
                                          }
                                          if (kDebugMode) {
                                            print(country.flagEmoji);
                                          }
                                          whatsappcountryCode =
                                          '${country.flagEmoji} ${country.phoneCode}';
                                          setState(() {});
                                        },
                                        // Optional. Sets the theme for the country list picker.
                                        countryListTheme:
                                        CountryListThemeData(
                                          bottomSheetHeight: h * 0.5,

                                          // Optional. Sets the border radius for the bottomsheet.
                                          borderRadius:
                                          const BorderRadius.only(
                                            topLeft:
                                            Radius.circular(40.0),
                                            topRight:
                                            Radius.circular(40.0),
                                          ),
                                          // Optional. Styles the search field.
                                          inputDecoration:
                                          InputDecoration(
                                            labelText: 'Search',
                                            hintText:
                                            'Start typing to search',
                                            prefixIcon: const Icon(
                                                Icons.search),
                                            border:
                                            OutlineInputBorder(
                                              borderSide: BorderSide(
                                                color: const Color(
                                                    0xFF8C98A8)
                                                    .withOpacity(0.2),
                                              ),
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                    icon: const Icon(
                                        Icons.arrow_drop_down),
                                  ),
                                  Flexible(
                                    child: TextFormField(
                                      keyboardType:
                                      TextInputType.number,
                                      maxLines: 1,
                                      maxLength: 10,
                                      controller:
                                      whatsappNumberController,
                                      decoration:
                                      const InputDecoration(
                                        labelStyle: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          color: Colors.yellow,
                                        ),
                                        border: InputBorder.none,
                                        focusedBorder:
                                        UnderlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.black,
                                          ),
                                        ),
                                      ),
                                      cursorColor: Colors.black,
                                      autovalidateMode:
                                      AutovalidateMode
                                          .onUserInteraction,
                                      validator: (value) {
                                        String patttern = r'(^[0-9]*$)';
                                        RegExp regExp = new RegExp(patttern);
                                        if (value!.isEmpty) {
                                          return "Mobile is Required";
                                        } else if(value.length != 10){
                                          return "Mobile number must 10 digits";
                                        }else if (!regExp.hasMatch(value)) {
                                          return "Mobile Number must be digits";
                                        }
                                        return null;

                                        // if (!phnValidation
                                        //     .hasMatch(v!)) {
                                        //   return "Enter valid Phone Number";
                                        // } else {
                                        //   return null;
                                        // }
                                      },
                                      // validator: (v) {
                                      //   if (!phnValidation
                                      //       .hasMatch(v!)) {
                                      //     return "Enter valid Phone Number";
                                      //   } else {
                                      //     return null;
                                      //   }
                                      // },
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(height: 20),
                            const Align(
                                alignment: Alignment.topLeft,
                                child: Text('Proof Type')),
                            RadioListTile(
                              title: const Text("Aadhar ID"),
                              value: "Aadhar ID",
                              groupValue: typeId,
                              onChanged: (value) {
                                typeId = value.toString();
                                setState(() {});
                              },
                            ),
                            RadioListTile(
                              title: const Text("Voter ID"),
                              value: "Voter ID",
                              groupValue: typeId,
                              onChanged: (value) {
                                typeId = value.toString();
                                setState(() {});
                              },
                            ),
                            RadioListTile(
                              title: const Text("Passport"),
                              value: "Passport",
                              groupValue: typeId,
                              onChanged: (value) {
                                typeId = value.toString();
                                setState(() {});
                              },
                            ),
                            // const SizedBox(
                            //   height: 20,
                            // ),
                            typeId != null&& typeId != ""&&(url==""||urb=="")
                                ? InkWell(
                                onTap: () {
                                  showDialog(
                                      context: context,
                                      builder: (buildContext) {
                                        return UploadDoc();
                                      });
                                },
                                child: Container(
                                  height: 50,
                                  width: w * 0.9,
                                  color: Colors.blue
                                      .withOpacity(0.07),
                                  child: Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.center,
                                    children: const [
                                      Icon(Icons
                                          .add_photo_alternate_outlined),
                                      Text('Choose A File')
                                    ],
                                  ),
                                )): typeId != null&&url!=""&&urb!=""?
                            Row(
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

                                    }, child: Text('change')),
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

                                    }, child: Text('change')),

                                  ],
                                )
                              ],
                            )
                                : SizedBox(),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: mailIdController,
                              read: false,
                              label: 'Mail ID',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: fullAddressController,
                              read: false,
                              label: 'Address',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: pinCodeController,
                              read: false,
                              label: 'Pin Code',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.start,
                              children: const [
                                Text("State"),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown.search(
                                    fillColor:
                                    Colors.blue.withOpacity(0.07),
                                    borderSide: BorderSide.none,
                                    hintText: 'Select State',
                                    items: listState,
                                    controller: stateController,
                                    excludeSelected: false,
                                    onChanged: (text) {
                                      listDistrict.clear();
                                      districtController.clear();
                                      if (text == 'Kerala') {
                                        listDistrict = [
                                          'Alappuzha',
                                          'Ernakulam',
                                          'Idukki',
                                          'Kannur',
                                          'Kasaragod',
                                          'Kollam',
                                          'Kottayam',
                                          'Kozhikode',
                                          'Malappuram',
                                          'Palakkad',
                                          'Pathanamthitta',
                                          'Thiruvananthapuram',
                                          'Thrissur',
                                          'Wayanad',
                                        ];
                                      } else {
                                        listDistrict = ['Other'];
                                      }
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            Row(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: const [
                                Text('District'),
                              ],
                            ),
                            const SizedBox(height: 3),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomDropdown.search(
                                    hintText: 'Select District',
                                    fillColor:
                                    Colors.blue.withOpacity(0.07),
                                    items: listDistrict,
                                    controller: districtController,
                                    excludeSelected: false,
                                    onChanged: (text) {
                                      setState(() {});
                                    },
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            const Text(
                              'Account Details',
                              style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: acNumberController,
                              read: false,
                              label: 'Ac Number',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: acHolderNameController,
                              read: false,
                              label: 'Ac Holder Name',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: ifscCodeController,
                              read: false,
                              label: 'IFSC Code',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: panNoController,
                              read: false,
                              label: 'Pan Number',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: bankNameController,
                              read: false,
                              label: 'Bank Name',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: branchNameController,
                              read: false,
                              label: 'Branch',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: googlePayController,
                              read: false,
                              label: 'Google Pay',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: phonePayController,
                              read: false,
                              label: 'Phone Pe',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: payTmController,
                              read: false,
                              label: 'Paytm',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            TextFF(
                              ctrl: upiIdController,
                              read: false,
                              label: 'Upi id',
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    print("====+========================");
                                    print(url);
                                    print(urb);

                                    final FormState? form =
                                        formKey.currentState;
                                    if (form!.validate()) {
                                      if (nameController.text != '' &&
                                          mobileNumberController.text !=
                                              '' &&
                                          whatsappNumberController.text !=
                                              '' &&
                                          mailIdController.text !=
                                              '' &&
                                          fullAddressController.text !=
                                              '' &&
                                          pinCodeController.text !=
                                              '' &&
                                          stateController.text !=
                                              '' &&
                                          districtController.text !=
                                              '' &&
                                          acNumberController.text !=
                                              '' &&
                                          acHolderNameController
                                              .text !=
                                              '' &&
                                          ifscCodeController.text !=
                                              '' &&
                                          panNoController.text !=
                                              '' &&
                                          bankNameController.text !=
                                              '' &&
                                          branchNameController.text !=
                                              '' &&
                                          ( googlePayController.text !=
                                              '' ||
                                              phonePayController.text !=
                                                  '' ||
                                              payTmController.text !=
                                                  '') &&
                                          upiIdController.text !=
                                              '' &&url!=""&&urb !="") {
                                        showDialog(
                                            context: context,
                                            builder: (buildContext) {
                                              return AlertDialog(
                                                title: const Text(
                                                    'Update Details'),
                                                content: const Text(
                                                    'Do you want to Update Details'),
                                                actions: [
                                                  TextButton(
                                                      onPressed: () =>
                                                          Navigator.pop(
                                                              context),
                                                      child: const Text(
                                                          'Cancel')),
                                                  TextButton(
                                                      onPressed: () {
                                                        Navigator.pop(
                                                            context,
                                                            );
                                                        final userdata =
                                                        UsersModel(
                                                          accholname:
                                                          acHolderNameController
                                                              .text,
                                                          name: nameController
                                                              .text,
                                                          accno:
                                                          acNumberController
                                                              .text,
                                                          bankname:
                                                          bankNameController
                                                              .text,
                                                          branch:
                                                          branchNameController
                                                              .text,
                                                          email:
                                                          mailIdController
                                                              .text,
                                                          mobno:
                                                          mobileNumberController
                                                              .text,
                                                          paytmno:
                                                          payTmController
                                                              .text,
                                                          phonepayno:
                                                          phonePayController
                                                              .text,
                                                          ifscno:
                                                          ifscCodeController
                                                              .text,
                                                          googlepayno:
                                                          googlePayController
                                                              .text,
                                                          upiId:
                                                          upiIdController
                                                              .text,
                                                          panNo:
                                                          panNoController
                                                              .text,
                                                          address: {
                                                            'hname':
                                                            fullAddressController
                                                                .text,
                                                            'pincode':
                                                            pinCodeController
                                                                .text,
                                                            'city': districtController
                                                                .text,
                                                            'state':
                                                            stateController
                                                                .text,
                                                          },
                                                        );
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection(
                                                            'Users')
                                                            .doc(widget
                                                            .user
                                                            .uid)
                                                        // .update(userdata.toJson())
                                                            .update({
                                                          'accholname':
                                                          acHolderNameController
                                                              .text,
                                                          'name':
                                                          nameController
                                                              .text,
                                                          'accno':
                                                          acNumberController
                                                              .text,
                                                          'bankname':
                                                          bankNameController
                                                              .text,
                                                          'branch':
                                                          branchNameController
                                                              .text,
                                                          'email':
                                                          mailIdController
                                                              .text,
                                                          'mobno':
                                                          mobileNumberController
                                                              .text,
                                                          'paytmno':
                                                          payTmController
                                                              .text,
                                                          'phonepayno':
                                                          phonePayController
                                                              .text,
                                                          'ifscno':
                                                          ifscCodeController
                                                              .text,
                                                          'googlepayno':
                                                          googlePayController
                                                              .text,
                                                          'upiId':
                                                          upiIdController
                                                              .text,
                                                          'panNo':
                                                          panNoController
                                                              .text,
                                                          'whatsNO':
                                                          whatsappNumberController
                                                              .text,
                                                          'address': {
                                                            'hname':
                                                            fullAddressController
                                                                .text,
                                                            'pincode':
                                                            pinCodeController
                                                                .text,
                                                            'city': districtController
                                                                .text,
                                                            'state': stateController
                                                                .text
                                                                .toString(),
                                                          },
                                                          'type': typeId
                                                              .toString(),
                                                          'whatsappcc':
                                                          whatsappcountryCode,
                                                          'mobcc':
                                                          mobilecountryCode,
                                                          'fProof': url
                                                              .toString(),
                                                          'bProof': urb
                                                              .toString()
                                                        }).then((value) {
                                                          showSnackbar(
                                                              "Profile Successfully Updated");


                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                          Navigator.pop(context);
                                                          // Navigator.pushAndRemoveUntil(context, PageRouteBuilder(pageBuilder: (context, _, __) => Homescreen(),), (route) => false);
                                                          // // Navigator.pop(context);
                                                          // Navigator.pop(context);
                                                        });
                                                      },
                                                      child: const Text(
                                                          'Update')),
                                                ],
                                              );
                                            });
                                      } else {
                                        nameController.text == ''
                                            ? showSnackbar(
                                            "Please Enter Name")
                                            : mobileNumberController
                                            .text ==
                                            ''
                                            ? showSnackbar(
                                            "Please Enter mobile number")
                                            : whatsappNumberController
                                            .text ==
                                            ''
                                            ? showSnackbar(
                                            "Please Enter Whatsapp number")
                                            : mailIdController
                                            .text ==
                                            ''
                                            ? showSnackbar(
                                            "Please Enter Email id")
                                            : fullAddressController
                                            .text ==
                                            ''
                                            ? showSnackbar(
                                            "Please Enter Address")
                                            : pinCodeController.text ==
                                            ''
                                            ? showSnackbar(
                                            "Please Enter pincode")
                                            : stateController.text == ''
                                            ? showSnackbar("Please Enter State")
                                            : districtController.text == ''
                                            ? showSnackbar("Please Enter District")
                                            : acNumberController.text == ''
                                            ? showSnackbar("Please Enter Account number")
                                            : acHolderNameController.text == ''
                                            ? showSnackbar("Please Enter Account Holder Name")
                                            : ifscCodeController.text == ''
                                            ? showSnackbar("Please Enter IFSC code")
                                            : panNoController.text == ''
                                            ? showSnackbar("Please Enter PAN Card No")
                                            : bankNameController.text == ''
                                            ? showSnackbar("Please Enter Bank Name")
                                            : branchNameController.text == ''
                                            ? showSnackbar("Please Enter Branch Name")
                                            : googlePayController.text == ''
                                            ? showSnackbar("Please Enter Google pay number")
                                            : showSnackbar("Please Enter Google UPI Id");
                                      }
                                    }
                                  },
                                  child: const Text('Update'),
                                ),
                                SizedBox(width: 7),
                                ElevatedButton(onPressed: (){
                                  Navigator.pop(context);
                                }, child: Text('Home')),
                                 SizedBox(
                                  height: 40,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )


    ),
        );
  }

  void showSnackbar(String message) {
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text(message)));
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
//
//  void ClipBoard(){
//
// TextEditingController field = TextEditingController();
//    String pasteValue='';
//    FlutterClipboard.paste().then((value) {
//      setState(() {
//        field.text = value;
//        pasteValue = value;
//      });
//    });
//  }
  String? validateName(String value) {
    String patttern = r'(^[a-zA-Z ]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Name is Required";
    } else if (!regExp.hasMatch(value)) {
      return "Name must be a-z and A-Z";
    }
    return null;
  }
//Here, We have set 10 digits validation on mobile number.
  String? validateMobile(String value) {
    String patttern = r'(^[0-9]*$)';
    RegExp regExp = new RegExp(patttern);
    if (value.length == 0) {
      return "Mobile is Required";
    } else if(value.length != 10){
      return "Mobile number must 10 digits";
    }else if (!regExp.hasMatch(value)) {
      return "Mobile Number must be digits";
    }
    return null;
  }
  //For Email Verification we using RegEx.
  String? validateEmail(String value) {
    String pattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regExp = new RegExp(pattern);
    if (value.length == 0) {
      return "Email is Required";
    } else if(!regExp.hasMatch(value)){
      return "Invalid Email";
    }else {
      return null;
    }
  }

}
