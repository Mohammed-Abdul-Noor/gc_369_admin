import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';

class SideMenu extends StatelessWidget {
  const SideMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        body: Container(
            child: const SideBar(
      items: [
        AdminMenuItem(
            title: 'Dashboard', route: 'DashboardPageRoute', icon: Icons.home),
        AdminMenuItem(
            title: 'Total Users',
            route: 'TotalUsersPageRoute',
            icon: Icons.groups),
        AdminMenuItem(
            title: 'Gen Id Activate',
            route: 'GenIdPageRoute',
            icon: Icons.circle_outlined),
        AdminMenuItem(
            title: 'Rebirth Id',
            route: 'RebirthIdPageRoute',
            icon: Icons.circle_outlined),
        AdminMenuItem(
            title: 'Reject Id',
            route: 'RejectIdPageRoute',
            icon: Icons.remove_circle_outline_rounded),
        AdminMenuItem(
            title: 'Clubs', route: 'ClubsPageRoute', icon: Icons.cloud_upload),
        AdminMenuItem(
            title: 'Payment Request',
            route: 'PaymentRequestPageRoute',
            icon: Icons.announcement_outlined),
        AdminMenuItem(
            title: 'Withdraw Eligible',
            route: 'WithdrawEligiblePageRoute',
            icon: Icons.currency_rupee),
        AdminMenuItem(
            title: 'Transaction History',
            route: 'TransactionHistoryPageRoute',
            icon: Icons.history),
        AdminMenuItem(title: 'Message', icon: Icons.email, children: [
          AdminMenuItem(
              title: 'Inbox Message',
              route: 'InboxMessagePageRoute',
              icon: Icons.email),
          AdminMenuItem(
            title: 'Send Message',
            route: 'SendMessagePageRoute',
            icon: Icons.email,
          )
        ]),
        AdminMenuItem(title: 'Report', icon: Icons.report, children: [
          AdminMenuItem(
            title: 'Plan Report',
            route: 'PlanReportPageRoute',
            icon: Icons.report,
          ),
          AdminMenuItem(
            title: 'Account Report',
            route: 'AccountReportPageRoute',
            icon: Icons.report,
          ),
          AdminMenuItem(
            title: 'User Report',
            route: 'UserReportPageRoute',
            icon: Icons.report,
          ),
        ]),
        AdminMenuItem(
          title: 'Web Info',
          route: 'WebInfoPageRoute',
          icon: Icons.info_outline,
        ),
        AdminMenuItem(
          title: 'Change Password',
          route: 'ChangePasswordPageRoute',
          icon: Icons.person,
        ),
        AdminMenuItem(
          title: 'Logout',
          route: 'AuthenticationPageRoute',
          icon: Icons.logout_sharp,
        ),
      ],
      selectedRoute: '',
    )));
  }
}
