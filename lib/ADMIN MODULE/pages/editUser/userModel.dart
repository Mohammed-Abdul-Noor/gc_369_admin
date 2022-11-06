import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'ProvideHelp.dart';
import 'genIDModel.dart';
import 'getHelp.dart';

int currentUserLevel=0;


UsersModel? users;
UsersModel? sponsorUser1;
UsersModel? sponsorUser2;
UsersModel? sponsorUser3;

class UsersModel {
  String? uid;
  String? name;
  DateTime? joinDate;
  String? mobno;
  Map<String,dynamic>? address;
  String? email;
  String? accno;
  String? accholname;
  String? ifscno;
  String? bankname;
  String? panNo;
  String? whatsNO;
  String? branch;
  String? googlepayno;
  String? phonepayno;
  int? sno;
  String? paytmno;
  String? upiId;
  int? sendhelp;
  int? receivehelp;
  int? levelincome;
  int? directmember;
  int? rebirthId;
  bool? status;
  String? spnsr_Id;
  String? spnsrId2;
  String? spnsrId3;
  String? sponsoremobile;
  int? sponsorincome;
  String? mystatus;
  String? password;
  int? recCount;
  int? sendCount;
  bool? checkGenId;
  bool? motherId;
  int? wallet;
  bool? eligible;
  List<dynamic>? referral;
  DateTime? firstLevelJoinDate;
  GenIdModel? genId;
  GetHelpUsers?getHelpUsers;
  ProvideHelpUsers?provideHelpUsers;
  Map<String,dynamic>?getCount;
  Map<String,dynamic>?provideCount;
  String? fproof;
  String? bproof;




  UsersModel({
    this.whatsNO,
    this.panNo,
    this.uid,
    this.name,
    this.joinDate,
    this.mobno,
    this.address,
    this.email,
    this.accno,
    this.accholname,
    this.ifscno,
    this.bankname,
    this.branch,
    this.googlepayno,
    this.phonepayno,
    this.paytmno,
    this.upiId,
    this.sendhelp,
    this.receivehelp,
    this.levelincome,
    this.directmember,
    this.rebirthId,
    this.status,
    this.spnsr_Id,
    this.sponsoremobile,
    this.sponsorincome,
    this.mystatus,
    this.password,
    this.recCount,
    this.sendCount,
    this.sno,
    this.checkGenId,
    this.eligible,
    this.motherId,
    this.referral,
    this.wallet,
    this.firstLevelJoinDate,
    this.genId,
    this.getHelpUsers,
    this.provideHelpUsers,
    this.provideCount,
    this.getCount,
    this.fproof,
    this.bproof,
    this.spnsrId2,
    this.spnsrId3

////////////////
  });

  UsersModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? "";
    panNo = json['panNo'] ?? "";
    whatsNO = json['whatsNO'] ?? "";
    name = json['name'] ?? "";
    joinDate = json['joinDate'].toDate() ?? DateTime;
    mobno = json['mobno'] ?? "";
    address = json['address'] ?? {};
    email = json['email'] ?? "";
    accno = json['accno'] ?? "";
    accholname = json['accholname'] ?? "";
    ifscno = json['ifscno'] ?? "";
    bankname = json['bankname'] ?? "";
    branch = json['branch'] ?? "";
    googlepayno = json['googlepayno'] ?? "";
    phonepayno = json['phonepayno'] ?? "";
    paytmno = json['paytmno'] ?? "";
    upiId = json['upiId'] ?? "";
    sendhelp = json['sendhelp'] ?? 0;
    receivehelp = json['receivehelp'] ?? 0;
    levelincome = json['levelincome'] ?? 0;
    directmember = json['directmember'] ?? 0;
    rebirthId = json['rebirthId'] ?? 0;
    status = json['status'] ?? false;
    spnsr_Id = json['spnsr_Id'] ?? "";
    spnsrId2 = json[' spnsrId2'] ?? "";
    spnsrId3 = json['spnsrId3'] ?? "";
    sponsoremobile = json['sponsoremobile'] ?? "";
    sponsorincome = json['sponsorincome'] ?? 0;
    mystatus = json['mystatus'] ?? '';
    password = json['password'] ?? '';
    sno = json['sno'] ?? 0;
    recCount = json['recCount'] ?? 0;
    sendCount = json['sendCount'] ?? 0;
    checkGenId = json['checkGenId'] ?? false;
    motherId = json['motherId'] ?? true;
    wallet = json['wallet'] ?? 0;
    eligible = json['eligible'] ?? false;
    referral = json['referral'] ?? [];
    firstLevelJoinDate = json['firstLevelJoinDate'].toDate() ?? DateTime;
    genId=GenIdModel.fromJson(json['genId'] ?? {});
    getHelpUsers=GetHelpUsers.fromJson(json['getHelpUsers'] ?? {});
    provideHelpUsers=ProvideHelpUsers.fromJson(json['provideHelpUsers'] ?? {});
    provideCount=json['provideCount'] ?? {};
    getCount=json['getCount'] ?? {};
    fproof = json['fproof'] ?? "";
    fproof = json['bproof'] ?? "";


  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['uid'] = uid;
    data['whatsNo'] = whatsNO;
    data['panNo'] = panNo ?? "";
    data['name'] = name ?? "";
    data['joinDate'] = joinDate ?? DateTime;
    data['mobno'] = mobno ?? "";
    data['address'] = address??{};
    data['email'] = email ?? "";
    data['accno'] = accno ?? "";
    data['accholname'] = accholname ?? "";
    data['ifscno'] = ifscno ?? "";
    data['bankname'] = bankname ?? '';
    data['branch'] = branch ?? "";
    data['googlepayno'] = googlepayno ?? "";
    data['phonepayno'] = phonepayno ?? "";
    data['paytmno'] = paytmno ?? '';
    data['upiId'] = upiId ?? '';
    data['sendhelp'] = sendhelp ?? 0;
    data['receivehelp'] = receivehelp ?? 0;
    data['levelincome'] = levelincome ?? 0;
    data['directmember'] = directmember ?? 0;
    data['rebirthId'] = rebirthId ?? 0;
    data['status'] = status ?? false;
    data['spnsr_Id'] = spnsr_Id ?? "";
    data['spnsrId2'] = spnsrId2 ?? "";
    data['spnsrId3'] = spnsrId3 ?? "";
    data['sponsoremobile'] = sponsoremobile ?? "";
    data['sponsorincome'] = sponsorincome ?? 0;
    data['mystatus'] = mystatus ?? '';
    data['password'] = password ?? '';
    data['sno'] = sno ?? 0;
    data['recCount'] = recCount ?? 0;
    data['sendCount'] = sendCount ?? 0;
    data['checkGenId'] = checkGenId ?? false;
    data['referral'] = referral ?? [];
    data['wallet'] = wallet ?? 0;
    data['eligible'] = eligible ?? false;
    data['motherId'] = motherId ?? true;
    data['firstLevelJoinDate'] = firstLevelJoinDate ?? DateTime.now();
    data['genId'] = genId?.toJson();
    data['getHelpUsers'] = getHelpUsers?.toJson();
    data['provideHelpUsers'] = provideHelpUsers?.toJson();
    data['provideCount'] = provideCount??{};
    data['getCount'] = getCount??{};
    data['fproof'] = fproof ?? '';
    data['bproof'] = bproof ?? '';
    return data;
  }


  UsersModel.fromdocumentsnapshot(DocumentSnapshot userMap)
      : uid = userMap['uid'],
        whatsNO = userMap['whatsNO'],
        name = userMap['name'],
        joinDate = userMap['joinDate'],
        mobno = userMap['mobno'],
        address = userMap['address'],
        email = userMap['email'],
        accno = userMap['accno'],
        accholname = userMap['accholname'],
        ifscno = userMap['ifscno'],
        bankname = userMap['bankname'],
        branch = userMap['branch'],
        googlepayno = userMap['googlepayno'],
        phonepayno = userMap['phonepayno'],
        paytmno = userMap['paytmno'],
        upiId = userMap['upiId'],
        sendhelp = userMap['sendhelp'],
        receivehelp = userMap['receivehelp'],
        levelincome = userMap['levelincome'],
        directmember = userMap['directmember'],
        rebirthId = userMap['rebirthId'],
        status = userMap['status'],
        spnsr_Id = userMap['spnsr_Id']??"",
        spnsrId2 = userMap['spnsrId2']??"",
        spnsrId3 = userMap['spnsrId3']??"",
        sponsoremobile = userMap['sponsoremobile'],
        sponsorincome = userMap['sponsorincome'],
        mystatus = userMap['mystatus'],
        password = userMap['password'],
        sno = userMap['sno'],
        checkGenId = userMap['checkGenId'],
        recCount = userMap['recCount'],
        sendCount = userMap['sendCount'],
        motherId = userMap['motherId'],
        wallet = userMap['wallet'],
        eligible = userMap['eligible'],
        panNo = userMap['panNo'],
        referral = userMap['referral'],
        getHelpUsers = userMap['getHelpUsers'],
        provideHelpUsers = userMap['provideHelpUsers'],
        provideCount = userMap['provideCount'],
        getCount = userMap['getCount'],
        fproof = userMap['fproof'],
        bproof = userMap['fproof']
  ;
}


List<UsersModel> listOfUsers(QuerySnapshot userSnap) {
  List<UsersModel> usersList = [];
  for (DocumentSnapshot docs in userSnap.docs) {
    usersList.add(UsersModel.fromdocumentsnapshot(docs));
  }
  return usersList;
}

Future<List<UsersModel>> getUsers(String userId) async {
  QuerySnapshot usrs = await FirebaseFirestore.instance
      .collection('Users')
      .where('uid', isEqualTo: userId)
      .get();
  return listOfUsers(usrs);
}
StreamSubscription? Streamcurrentuser;

usersListener(String userId) {
  Streamcurrentuser = FirebaseFirestore.instance
      .collection("Users")
      .doc(userId)
      .snapshots()
      .listen((event) {
    print(event.data());
    users = UsersModel.fromJson(event.data()!);
    print("---------------------------------------------------");
    print(event.exists);
    print("---------------------------------------------------");
  });
}
