import 'package:flutter/material.dart';
import 'package:gc_369/ADMIN%20MODULE/Company/charityAmount.dart';
import 'package:gc_369/ADMIN%20MODULE/Company/clubAmount.dart';
import 'package:gc_369/ADMIN%20MODULE/dashPages/CustomerSupport.dart';
import 'package:gc_369/ADMIN%20MODULE/dashPages/DistrictWise.dart';
import 'package:gc_369/ADMIN%20MODULE/dashPages/PendingProvides.dart';
import 'package:gc_369/ADMIN%20MODULE/pages/editUser/password/passwordTable.dart';

import '../../main.dart';
import '../Company/create_genid.dart';
import '../dashPages/A.dart';
import '../dashPages/RegistrationReport.dart';
import '../dashPages/SendRecieveProof.dart';
import '../dashPages/SocialWelfare.dart';
import '../dashPages/TotalGenID.dart';
import '../dashPages/WalletRegistration.dart';
import '../dashPages/dialyUsers.dart';
import '../dashPages/downloadtotalusers.dart';
import '../dashPages/four.dart';
import '../dashPages/geniDS.dart';
import '../dashPages/paginated.dart';
import '../dashPages/proof_verification.dart';
import '../dashPages/seniorityLevel/sLevel.dart';
import '../dashPages/sponsorlessUsers.dart';
import '../navigation/navigationDrawer.dart';
import '../pages/dashboard/dashboard.dart';
import '../dashPages/userVerification.dart';
import '../dashPages/club_users.dart';
import '../dashPages/kyc.dart';
import '../dashPages/toatalUsers.dart';

List<Widget> _screens = [
  const DashboardPage(),
  const DownTotalUsers(),
  const TotalUsersPage(),
  const DailyUsersPage(),
  const CustomerSupport(),
  const KycPage(),
  const CharityAmountPage(),
  const ClubAmount(),
  const SocialWelfare(),
  const PasswordTable(),
  const UserVerification(),
  const WalletRegistration(),
  const GenIDS(),
  const TotalGenID(),
  const CreateGenID(),
  const ClubUsers(
    sno: 0,
  ),
  const ClubUsers(
    sno: 1,
  ),
  const ClubUsers(
    sno: 2,
  ),
  const ClubUsers(
    sno: 3,
  ),
  const ClubUsers(
    sno: 4,
  ),
  const ClubUsers(
    sno: 5,
  ),
  const SeniorityLevelT(sno: 0),
  const SeniorityLevelT(sno: 1),
  const SeniorityLevelT(sno: 2),
  const SeniorityLevelT(sno: 3),
  const SeniorityLevelT(sno: 4),
  const SeniorityLevelT(sno: 5),
  const sponsorlessUsersPage(),
  const ProofVerification(),
  const SendReceiveProof(),
  const DistrictWise(),
  const RegistrationReport(),
  const SendReceiveReport(),
  const PendingProvides(),

  // NewUsers(),
  // Changepasswords(),

  // RebirthGenIdPage(),
  // RejectIdPage(),
  // ClubsPage(),

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

class LargeScreen extends StatefulWidget {
  final int index;
  const LargeScreen({Key? key, required this.index}) : super(key: key);

  @override
  State<LargeScreen> createState() => _LargeScreenState();
}

class _LargeScreenState extends State<LargeScreen> {
  int _selectedIndex = 0;
  @override
  void initState() {
    _selectedIndex = widget.index;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    //  final provider = Provider.of<NavigationProvider>(context);
    //final isCollapsed = provider.isCollapsed;
    _selectedIndex = test;
    // print(_selectedIndex);
    //print('_selectedIndex');
    return Row(
      children: [
        const SizedBox(
          // width: 230,
          child: NavigationDrawerWidget(),
        ),
        Expanded(
          flex: 5,
          child: Scaffold(body: _screens[_selectedIndex]),
        )
      ],
    );
  }
}
