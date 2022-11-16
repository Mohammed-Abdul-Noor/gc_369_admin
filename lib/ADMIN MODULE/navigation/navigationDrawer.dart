

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../main.dart';
import '../drawer/drawerItem.dart';
import '../drawer/items.dart';
import '../pages/accountReport.dart';
import '../pages/changePassword.dart';
import '../pages/clubs.dart';
import '../pages/dashboard/dashboard.dart';
import '../pages/genIdActivate.dart';
import '../pages/layout.dart';
import '../pages/paymentRequest.dart';
import '../pages/planReport.dart';
import '../pages/rebirth_genId.dart';
import '../pages/rejectId.dart';
import '../pages/sendMessge/InboxMessage.dart';
import '../pages/sendMessge/SendMessagePage.dart';
import '../dashPages/toatalUsers.dart';
import '../pages/transactionHistory.dart';
import '../pages/userReport.dart';
import '../pages/webInfo.dart';
import '../pages/withdrawEligible.dart';
import '../routing/loginpage.dart';
import 'navigationProvider.dart';

List<Widget> _screens = [
 // DashboardPage(),
 //  TotalUsersPage(),
 //  TotalUsersPage(),
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

class NavigationDrawerWidget extends StatefulWidget {
  const NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<NavigationProvider>(context);
    final isCollapsed = provider.isCollapsed;
    return SizedBox(
        width: isCollapsed ? MediaQuery.of(context).size.width * 0.06 : 230,
        child: Drawer(
          child: Container(
            color: Colors.indigo[900],
            child: SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    color: Colors.grey,
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: buildHeader(isCollapsed),
                  ),
                  buildList(items: itemsMain, isCollapsed: isCollapsed),
                  // Spacer(),
                  // buildCollapsiveIcon(context, isCollapsed),
                  const SizedBox(height: 12),
                  isCollapsed?IconButton(onPressed: (){
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginpage(),), (route) => false);
                  }, icon:Icon (Icons.logout,color: Colors.white,))
                 : Row(
                    children: [

                      IconButton(onPressed: () async {
                        SharedPreferences prefs = await SharedPreferences.getInstance();
                        prefs.remove('userId');

                        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginpage(),), (route) => false);
                      }, icon:Icon (Icons.logout,color: Colors.white,)),
                      SizedBox(width: 23),
                      InkWell(
                          onTap: (){ Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => Loginpage(),), (route) => false);},
                          child: Text('Logout',style: TextStyle(color: Colors.white),))
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }

  // Widget buildCollapsiveIcon(BuildContext context, bool isCollapsed) {
  Widget buildHeader(bool isCollapsed) => isCollapsed
      ? const Text(
          '369',
          style: TextStyle(fontSize: 32),
        )
      : Container(
          child: Column(
            children: [
              CircleAvatar(
                radius: 24,
              ),
              Column(
                children: [
                  SizedBox(width: 20),
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                            child: Container(
                                child: Text(
                          '369 Global Club Admin',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ))),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.green),
                      ),
                      SizedBox(width: 5),
                      Text('online')
                    ],
                  )
                ],
              )
            ],
          ),
        );

  Widget buildList({
    required bool isCollapsed,
    required List<DrawerItem> items,
  }) =>
      ListView.builder(
          primary: false,
          shrinkWrap: true,
          itemCount: items.length,
          itemBuilder: (context, index) {
            final item = items[index];

            return buildMenuItem(
                isCollapsed: isCollapsed,
                text: item.title,
                icon: item.icon,
                onClicked: () {
                  setState(() {
                    test = index;
                  });
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                          builder: (context) => SiteLayout(
                                index: test,
                              )),
                      (route) => false);
                  print('/////////////////////////////');
                  print(test);
                });
          });
}

Widget buildMenuItem({
  required bool isCollapsed,
  required String text,
  required IconData icon,
  VoidCallback? onClicked,
}) {
  const color = Colors.white;
  final leading = Icon(icon, color: color);
  return Material(
    color: Colors.transparent,
    child: isCollapsed
        ? ListTile(
            title: leading,
            onTap: onClicked,
          )
        : ListTile(
            onTap: onClicked,
            leading: leading,
            title: Text(
              text,
              style: (const TextStyle(
                color: color,
                fontSize: 16,
              )),
            ),
          ),
  );
}

