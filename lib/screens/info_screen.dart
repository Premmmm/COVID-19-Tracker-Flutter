import 'package:flutter/material.dart';
import 'package:covid19tracker2/services/constants.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:package_info/package_info.dart';

class InfoScreen extends StatefulWidget {
  @override
  _InfoScreenState createState() => _InfoScreenState();
}

class _InfoScreenState extends State<InfoScreen> {
  String version;

  @override
  void initState() {
    super.initState();
    getInfo();
  }

  Future<void> getInfo() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    setState(() {
      version = packageInfo.version;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SafeArea(
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            SizedBox(height: 150),
            Center(
              child: Text(
                'Version $version',
                style: GoogleFonts.montserrat(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            const SizedBox(height: 15),
            Column(
              children: <Widget>[
                Center(
                  child: Text(
                    'New Material Design',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    'Added World data',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.white),
                  ),
                ),
                Center(
                  child: Text(
                    'Added Comparison of Country method',
                    style: GoogleFonts.montserrat(
                        fontSize: 18, color: Colors.white),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 300),
            Center(
                child: Text(
              'From\nS.PREM RAJ',
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                  fontSize: 20,
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2),
            )),
          ],
        ),
      ),
    );
  }
}
