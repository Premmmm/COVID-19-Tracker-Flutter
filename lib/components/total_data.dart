import 'package:flutter/material.dart';
import 'package:covid19tracker2/services/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class TotalData extends StatelessWidget {
  const TotalData({
    Key key,
    @required this.confirmed,
    @required this.confirmedDelta,
    @required this.active,
    @required this.recovered,
    @required this.recoveredDelta,
    @required this.deceased,
    @required this.deceasedDelta,
  }) : super(key: key);

  final confirmed;
  final confirmedDelta;
  final active;
  final recovered;
  final recoveredDelta;
  final deceased;
  final deceasedDelta;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'CONFIRMED',
                style: GoogleFonts.montserrat(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '$confirmed ',
                style: GoogleFonts.montserrat(
                    fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '[+$confirmedDelta]',
                style: GoogleFonts.montserrat(
                    color: Colors.red[400], fontSize: 10),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'ACTIVE',
                style: GoogleFonts.montserrat(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300]),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '$active',
                style: GoogleFonts.montserrat(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(''),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'RECOVERED',
                style: GoogleFonts.montserrat(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '$recovered ',
                style: GoogleFonts.montserrat(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '[+$recoveredDelta]',
                style: GoogleFonts.montserrat(
                    color: Colors.green[600], fontSize: 10),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'DECEASED',
                style: GoogleFonts.montserrat(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '$deceased ',
                style: GoogleFonts.montserrat(
                    fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '[+$deceasedDelta]',
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
