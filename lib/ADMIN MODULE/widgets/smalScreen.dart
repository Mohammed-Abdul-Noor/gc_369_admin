import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/Company/charityAmount.dart';
import 'package:gc_369/ADMIN%20MODULE/Company/clubAmount.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/editUser/kyc/kyc.dart';
import 'package:gc_369/ADMIN%20MODULE/widgets/changePassword.dart';

import '../../main.dart';
import '../pages/accountReport.dart';
import '../pages/changePassword.dart';
import '../pages/clubs.dart';
import '../pages/dashboard/dashboard.dart';
import '../pages/dashboard/userVerification.dart';
import '../pages/editUser/club_users.dart';
import '../pages/editUser/password/passwordTable.dart';
import '../pages/paymentRequest.dart';
import '../pages/planReport.dart';
import '../pages/rebirth_genId.dart';
import '../pages/rejectId.dart';
import '../pages/sendMessge/InboxMessage.dart';
import '../pages/sendMessge/SendMessagePage.dart';
import '../pages/toatalUsers.dart';
import '../pages/transactionHistory.dart';
import '../pages/userReport.dart';
import '../pages/webInfo.dart';
import '../pages/withdrawEligible.dart';

List<Widget> _pages =[
  DashboardPage(),
  TotalUsersPage(),
  KycPage(),
  CharityAmountPage(),
  NewUsers(),
  PasswordTable(),
  UserVerification(),
  ClubUsers(sno: 0,),
  ClubUsers(sno: 1,),
  ClubUsers(sno: 2,),
  ClubUsers(sno: 3,),
  ClubUsers(sno: 4,),
  ClubUsers(sno: 5,),
 // Changepasswords(),
  // RebirthGenIdPage(),
  // RejectIdPage(),
  // ClubsPage(),
  // PaymentRequestPage(),
  // WithdrawEligiblePage(),
  // TransactionHistoryPage(),
  // InboxMessagePage(),
  // SendMessagePage(),
  // PlanReportPage(),
  // UserReportPage(),
  // AccountReportPage(),
  // WebInfoPage(),
  // ChangePasswordPage()
];


class SmallScreen extends StatefulWidget {
  final int index;
  const SmallScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<SmallScreen> createState() => _SmallScreenState();
}

class _SmallScreenState extends State<SmallScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    var w =MediaQuery.of(context).size.width;
    _selectedIndex=test;
    return Scaffold(
      body: Container(
        //constraints: BoxConstraints.expand(),
        child: _pages[_selectedIndex],
      ),
    );
  }
}


