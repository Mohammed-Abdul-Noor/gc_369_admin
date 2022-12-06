import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import '../pages/layout.dart';
import '../pages/editUser/ProvideHelp.dart';
import '../pages/editUser/genIDModel.dart';
import '../pages/editUser/getHelp.dart';

UserModel? currentuser;
UserModel? sponsorUser1;
UserModel? sponsorUser2;
UserModel? sponsorUser3;

class UserModel {
  String? uid;
  String? name;
  DateTime? joinDate;
  String? mobno;
  Map<String, dynamic>? address;
  String? email;
  String? accno;
  String? accholname;
  String? ifscno;
  String? bankname;
  String? panNo;
  String? whatsNO;
  String? whatsappcc;
  String? mobcc;
  String? branch;
  String? googlepayno;
  String? phonepayno;
  int? sno;
  int? index;
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
  int? receiveCount;
  int? sendCount;
  bool? checkGenId;
  bool? motherId;
  int? wallet;
  bool? eligible;
  List<dynamic>? referral;
  DateTime? firstLevelJoinDate;
  GenIdModel? genId;
  GetHelpUsers? getHelpUsers;
  ProvideHelpUsers? provideHelpUsers;
  Map<String, dynamic>? getCount;
  Map<String, dynamic>? provideCount;
  Map<String, dynamic>? clubAmt;
  Map<String, dynamic>? charAmt;
  Map<String, dynamic>? upgradeAmt;
  Map<String, dynamic>? spnsrAmt1;
  Map<String, dynamic>? spnsrAmt2;
  Map<String, dynamic>? spnsrAmt3;
  Map<String, dynamic>? enteredDate;
  String? fproof;
  String? bproof;
  String? nomineeName;
  String? nomineeRelation;
  bool? customerSupport;
  int? downline1;
  int? downline2;
  int? downline3;
  List? search;
  String? type;
  int? currentPlanLevel;
  int? currentCount;

  UserModel({
    this.nomineeName,
    this.nomineeRelation,
    this.customerSupport,
    this.currentCount,
    this.currentPlanLevel,
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
    this.receiveCount,
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
    this.spnsrId3,
    this.downline1,
    this.downline2,
    this.downline3,
    this.search,
    this.type,
    this.charAmt,
    this.clubAmt,
    this.enteredDate,
    this.upgradeAmt,
    this.spnsrAmt1,
    this.spnsrAmt2,
    this.spnsrAmt3,
    this.index,
    this.mobcc,
    this.whatsappcc,
  });

  UserModel.fromJson(Map<String, dynamic> json) {
    uid = json['uid'] ?? "";
    nomineeName = json['nomineeName'] ?? "";
    nomineeRelation = json['nomineeRelation'] ?? "";
    customerSupport = json['customerSupport'] ?? false;
    panNo = json['panNo'] ?? "";
    whatsNO = json['whatsNO'] ?? "";
    whatsappcc = json['whatsappcc'] ?? "";
    mobcc = json['mobcc'] ?? "";
    name = json['name'] ?? "";
    joinDate =
        json['joinDate'] == null ? DateTime.now() : json['joinDate'].toDate();
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
    index = json['index'] ?? 0;
    receiveCount = json['recCount'] ?? 0;
    sendCount = json['sendCount'] ?? 0;
    checkGenId = json['checkGenId'] ?? false;
    motherId = json['motherId'] ?? true;
    wallet = json['wallet'] ?? 0;
    eligible = json['eligible'] ?? false;
    referral = json['referral'] ?? [];
    search = json['search'] ?? [];
    firstLevelJoinDate = json['firstLevelJoinDate'] == null
        ? DateTime.now()
        : json['firstLevelJoinDate'].toDate();
    genId = GenIdModel.fromJson(json['genId'] ?? {});
    getHelpUsers = GetHelpUsers.fromJson(json['getHelpUsers'] ?? {});
    provideHelpUsers =
        ProvideHelpUsers.fromJson(json['provideHelpUsers'] ?? {});
    provideCount = json['provideCount'] ?? {};
    getCount = json['getCount'] ?? {};
    clubAmt = json['clubAmt'] ?? {};
    charAmt = json['charAmt'] ?? {};
    enteredDate = json['enteredDate'] ?? {};
    fproof = json['fProof'] ?? "";
    bproof = json['bProof'] ?? "";
    whatsappcc = json['whatsappcc'] ?? "";
    type = json['type'] ?? "";
    downline1 = json['downline1'] ?? 0;
    downline2 = json['downline2'] ?? 0;
    downline3 = json['downline3'] ?? 0;
    currentPlanLevel = json['currentPlanLevel'] ?? 0;
    currentCount = json['currentCount'] ?? 0;
    upgradeAmt = json['upgradeAmt'] ?? {};
    spnsrAmt1 = json['spnsrAmt1'] ?? {};
    spnsrAmt2 = json['spnsrAmt2'] ?? {};
    spnsrAmt3 = json['spnsrAmt3'] ?? {};
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();

    data['uid'] = uid;
    data['nomineeName'] = nomineeName;
    data['nomineeRelation'] = nomineeRelation;
    data['customerSupport'] = customerSupport;

    data['whatsNo'] = whatsNO;

    data['whatsappcc'] = whatsappcc;

    data['panNo'] = panNo ?? "";

    data['name'] = name ?? "";

    data['joinDate'] = joinDate ?? DateTime.now();

    data['mobno'] = mobno ?? "";

    data['mobcc'] = mobcc ?? "";

    data['address'] = address ?? {};

    data['email'] = email ?? "";

    data['accno'] = accno ?? "";

    data['accholname'] = accholname ?? "";

    data['ifscno'] = ifscno ?? "";

    data['bankname'] = bankname ?? '';

    data['branch'] = branch ?? "";

    data['type'] = type ?? "";

    data['googlepayno'] = googlepayno ?? "";

    data['phonepayno'] = phonepayno ?? "";

    data['paytmno'] = paytmno ?? '';

    data['upiId'] = upiId ?? '';
    data['sendhelp'] = sendhelp ?? 0;
    data['index'] = index ?? 0;
    data['currentPlanLevel'] = currentPlanLevel ?? 0;
    data['currentCount'] = currentCount ?? 0;
    data['receivehelp'] = receivehelp ?? 0;
    data['levelincome'] = levelincome ?? 0;
    data['directmember'] = directmember ?? 0;
    data['rebirthId'] = rebirthId ?? 0;
    data['status'] = status ?? false;
    data['spnsr_Id'] = spnsr_Id ?? "";
    data['spnsrId2'] = spnsrId2 ?? "";
    data['spnsrId3'] = spnsrId3 ?? "";
    data['whatsappcc'] = whatsappcc ?? "";
    data['sponsoremobile'] = sponsoremobile ?? "";
    data['sponsorincome'] = sponsorincome ?? 0;
    data['mystatus'] = mystatus ?? '';
    data['password'] = password ?? '';
    data['sno'] = sno ?? 0;
    data['recCount'] = receiveCount ?? 0;
    data['sendCount'] = sendCount ?? 0;
    data['checkGenId'] = checkGenId ?? false;
    data['referral'] = referral ?? [];
    data['search'] = search ?? [];
    data['wallet'] = wallet ?? 0;
    data['eligible'] = eligible ?? false;
    data['motherId'] = motherId ?? true;
    data['firstLevelJoinDate'] = firstLevelJoinDate ?? DateTime.now();
    data['genId'] = genId?.toJson();
    data['getHelpUsers'] = getHelpUsers?.toJson();
    data['provideHelpUsers'] = provideHelpUsers?.toJson();
    data['provideCount'] = provideCount ?? {};
    data['getCount'] = getCount ?? {};
    data['clubAmt'] = clubAmt ?? {};
    data['charAmt'] = charAmt ?? {};
    data['enteredDate'] = enteredDate ?? {};
    data['fProof'] = fproof ?? '';
    data['bProof'] = bproof ?? '';
    data['downline1'] = downline1 ?? 0;
    data['downline2'] = downline2 ?? 0;
    data['downline3'] = downline3 ?? 0;
    data['upgradeAmt'] = upgradeAmt ?? {};
    data['spnsrAmt1'] = spnsrAmt1 ?? {};
    data['spnsrAmt2'] = spnsrAmt2 ?? {};
    data['spnsrAmt3'] = spnsrAmt3 ?? {};
    return data;
  }

  UserModel.fromdocumentsnapshot(DocumentSnapshot userMap)
      : uid = userMap['uid'],
        nomineeName = userMap['nomineeName'],
        nomineeRelation = userMap['nomineeRelation'],
        customerSupport = userMap['customerSupport'],
        whatsNO = userMap['whatsNO'],
        name = userMap['name'],
        joinDate = userMap['joinDate'].toDate(),
        mobno = userMap['mobno'],
        address = userMap['address'],
        email = userMap['email'],
        accno = userMap['accno'],
        accholname = userMap['accholname'],
        ifscno = userMap['ifscno'],
        bankname = userMap['bankname'],
        whatsappcc = userMap['whatsappcc'],
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
        index = userMap['index'],
        currentPlanLevel = userMap['currentPlanLevel'],
        currentCount = userMap['currentCount'],
        spnsr_Id = userMap['spnsr_Id'] ?? "",
        spnsrId2 = userMap['spnsrId2'] ?? "",
        spnsrId3 = userMap['spnsrId3'] ?? "",
        sponsoremobile = userMap['sponsoremobile'],
        sponsorincome = userMap['sponsorincome'],
        mystatus = userMap['mystatus'],
        password = userMap['password'],
        sno = userMap['sno'],
        checkGenId = userMap['checkGenId'],
        receiveCount = userMap['recCount'],
        sendCount = userMap['sendCount'],
        motherId = userMap['motherId'],
        wallet = userMap['wallet'],
        eligible = userMap['eligible'],
        panNo = userMap['panNo'],
        referral = userMap['referral'],
        search = userMap['search'],
        getHelpUsers = userMap['getHelpUsers'],
        provideHelpUsers = userMap['provideHelpUsers'],
        provideCount = userMap['provideCount'],
        getCount = userMap['getCount'],
        clubAmt = userMap['clubAmt'],
        charAmt = userMap['charAmt'],
        enteredDate = userMap['enteredDate'],
        upgradeAmt = userMap['upgradeAmt'],
        spnsrAmt1 = userMap['spnsrAmt1'],
        spnsrAmt2 = userMap['spnsrAmt2'],
        spnsrAmt3 = userMap['spnsrAmt3'],
        fproof = userMap['fProof'],
        type = userMap['type'],
        bproof = userMap['bProof'],
        downline1 = userMap['downline1'],
        downline2 = userMap['downline2'],
        downline3 = userMap['downline3'];

  fromJson(data) {}
}

List<UserModel> listOfUsers(QuerySnapshot userSnap) {
  List<UserModel> usersList = [];
  for (DocumentSnapshot docs in userSnap.docs) {
    usersList.add(UserModel.fromdocumentsnapshot(docs));
  }
  return usersList;
}

Future<List<UserModel>> getUsers(String userId) async {
  QuerySnapshot usrs = await FirebaseFirestore.instance
      .collection('Users')
      .where('uid', isEqualTo: userId)
      .get();
  return listOfUsers(usrs);
}

StreamSubscription? Streamcurrentuser;

currentUserListener(String userId) {
  Streamcurrentuser = FirebaseFirestore.instance
      .collection("Users")
      .doc(userId)
      .snapshots()
      .listen((event) {
    print(event.data());
    currentuser = UserModel.fromJson(event.data()!);
    currentUserLevel = event['sno'];
    print("---------------------------------------------------");
    print(event.exists);
    print("---------------------------------------------------");
  });
}

// GC2502694     0
// GC9462971     1
// GC5132990     z
// GC8922992     5
