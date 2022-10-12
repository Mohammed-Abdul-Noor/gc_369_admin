import 'package:flutter/material.dart';


import '../navigation/navigationDrawer.dart';
import '../responsiveness/responsive.dart';
import '../widgets/largeScreen.dart';
import '../widgets/smalScreen.dart';
import '../widgets/top_nav.dart';





class SiteLayout extends StatefulWidget {
   final int index;
   const SiteLayout({Key? key, required this.index}) : super(key: key);
  @override
  State<SiteLayout> createState() => _SiteLayoutState();
}

class _SiteLayoutState extends State<SiteLayout> {
  GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        appBar: topNavigationBar(context, scaffoldKey),
        drawer: const Drawer(
          child: NavigationDrawerWidget(),
        ),
       body: ResponsiveWidget(largeScreen: LargeScreen(index: widget.index,),smallScreen: SmallScreen(index: widget.index,), mediumScreen: LargeScreen(index: widget.index,))
    );
  }
}
