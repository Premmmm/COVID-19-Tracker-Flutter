import 'package:flutter/material.dart';
import 'package:covid19tracker2/services/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class InfoScreen extends StatelessWidget {
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
                'Version 1.0.10',
                style: GoogleFonts.montserrat(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
            ),
            SizedBox(
              height: 15,
            ),
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
            SizedBox(
              height: 300,
            ),
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
