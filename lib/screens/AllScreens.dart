import 'package:covid19tracker2/screens/data_screen.dart';
import 'package:covid19tracker2/screens/info_screen.dart';
import 'package:covid19tracker2/screens/world_screen.dart';
import 'package:covid19tracker2/services/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AllScreens extends StatefulWidget {
  @override
  _AllScreensState createState() => _AllScreensState();
}

class _AllScreensState extends State<AllScreens> {
  PageController _pageController =
      PageController(initialPage: 0, keepPage: true);
  String text = 'COVID\'19  TRACKER';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          text,
          style: GoogleFonts.montserrat(),
        ),
        backgroundColor: kBackgroundColor,
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.grey[900],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: kBackgroundColor,
                ),
                child: Container(
                  padding: EdgeInsets.only(bottom: 20),
                  alignment: Alignment.bottomLeft,
                  width: MediaQuery.of(context).size.width,
                  child: Text("COVID'19 TRACKER",
                      style: GoogleFonts.montserrat(fontSize: 20)),
                ),
              ),
              ListTile(
                leading: Icon(Icons.home),
                title: Text('Local Data',
                    style: GoogleFonts.montserrat(fontSize: 19)),
                onTap: () {
                  _pageController.jumpToPage(0);
                  setState(() {
                    text = 'COVID\'19  TRACKER';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.public),
                title: Text('World Data',
                    style: GoogleFonts.montserrat(fontSize: 19)),
                onTap: () {
                  _pageController.jumpToPage(1);
                  setState(() {
                    text = 'WORLD DATA';
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                leading: Icon(Icons.info_outline_rounded),
                title:
                    Text('About', style: GoogleFonts.montserrat(fontSize: 19)),
                onTap: () {
                  _pageController.jumpToPage(2);
                  setState(() {
                    text = 'ABOUT';
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: PageView(
          physics: ScrollPhysics(parent: NeverScrollableScrollPhysics()),
          controller: _pageController,
          children: [
            DataScreen(),
            WorldScreen(),
            InfoScreen(),
          ],
        ),
      ),
    );
  }
}
