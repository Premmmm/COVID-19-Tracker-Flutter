import 'package:flutter/material.dart';
import 'package:covid19tracker2/services/info.dart';
import 'package:covid19tracker2/components/total_data.dart';
import 'package:covid19tracker2/services/getting_data.dart';
import 'package:flutter/rendering.dart';
import 'package:covid19tracker2/services/constants.dart';
import 'package:google_fonts/google_fonts.dart';

class WorldScreen extends StatefulWidget {
  @override
  _WorldScreenState createState() => _WorldScreenState();
}

class _WorldScreenState extends State<WorldScreen> {
  String countryName;

  var selectedCountryName;
  var countryTotal;
  var countryNew;
  var countryTotalDeceased;
  var countryNewDeceased;
  var countryTotalRecovered;
  var countryActive;

  GettingData gettingData = GettingData();
  Info info = Info();
  GettingWorldData gettingWorldData = GettingWorldData();

  @override
  void initState() {
    super.initState();
    gettingDataTotal();
  }

  dynamic gettingDataTotal() async {
    var data = await info.getData();
    var dataWorld = await info.getWorldData();
    setState(() {
      gettingWorldData.updateUI(dataWorld);
      gettingData.updateUI(data);
    });
  }

  dynamic gettingCountryData(String countryName) async {
    var dataWorld = await info.getWorldData();
    for (int i = 0; i < 213; i++) {
      var c = dataWorld["countries_stat"][i]["country_name"];
      if (c == countryName) {
        setState(
          () {
            try {
              selectedCountryName =
                  dataWorld["countries_stat"][i]["country_name"];
              countryTotal = dataWorld["countries_stat"][i]["cases"];
              countryNew = dataWorld["countries_stat"][i]["new_cases"];
              countryTotalRecovered =
                  dataWorld["countries_stat"][i]["total_recovered"];
              countryTotalDeceased = dataWorld["countries_stat"][i]["deaths"];
              countryNewDeceased = dataWorld["countries_stat"][i]["new_deaths"];
              countryActive = dataWorld["countries_stat"][i]["active_cases"];
            } catch (e) {
              print(e);
            }
          },
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50),
        child: ListView(
          physics: BouncingScrollPhysics(),
          children: <Widget>[
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kFolderColor,
              ),
              child: TotalWorldData(gettingWorldData: gettingWorldData),
            ),
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Card(
                color: kFolderColor,
                elevation: 20,
                child: ListTile(
                  leading: Tab(
                    icon: Image.asset("images/globe.png"),
                  ),
                  title: TextField(
                    onChanged: (value) {
                      countryName = value;
                    },
                    textAlign: TextAlign.center,
                    cursorColor: Colors.white,
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                        fontWeight: FontWeight.w600),
                    decoration: InputDecoration(
                        hintText: "Country name (Eg: China, USA)",
                        hintStyle: GoogleFonts.montserrat(fontSize: 12),
                        suffixIcon: IconButton(
                            icon: Icon(Icons.send),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              setState(() {
                                gettingCountryData(countryName);
                                FocusScope.of(context).unfocus();
                              });
                            })),
                    keyboardAppearance: Brightness.dark,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 70,
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              padding: EdgeInsets.symmetric(vertical: 20),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5),
                color: kFolderColor,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    'INDIA',
                    style: GoogleFonts.montserrat(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  TotalData(
                      confirmed: gettingData.confirmed,
                      confirmedDelta: gettingData.confirmedDelta,
                      active: gettingData.active,
                      recovered: gettingData.recovered,
                      recoveredDelta: gettingData.recoveredDelta,
                      deceased: gettingData.deceased,
                      deceasedDelta: gettingData.deceasedDelta),
                  SizedBox(
                    height: 30,
                  ),
                  Text(
                    selectedCountryName == null
                        ? 'Enter Country'
                        : selectedCountryName,
                    style: GoogleFonts.montserrat(fontSize: 20),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CountryData(
                    countryNew: countryNew,
                    countryTotal: countryTotal,
                    countryActive: countryActive,
                    countryNewDeceased: countryNewDeceased,
                    countryTotalDeceased: countryTotalDeceased,
                    countryTotalRecovered: countryTotalRecovered,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TotalWorldData extends StatelessWidget {
  const TotalWorldData({
    Key key,
    @required this.gettingWorldData,
  }) : super(key: key);

  final GettingWorldData gettingWorldData;

  @override
  Widget build(BuildContext context) {
    if (gettingWorldData.total == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'CONFIRMED',
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: KTitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'ACTIVE',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300]),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'RECOVERED',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'DECEASED',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
            ],
          ),
        ],
      );
    } else
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'CONFIRMED',
                style: TextStyle(
                  letterSpacing: 1,
                  fontSize: KTitleFontSize,
                  fontWeight: FontWeight.bold,
                  color: Colors.red,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${gettingWorldData.total} ',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '[+${gettingWorldData.newCases}]',
                style: TextStyle(color: Colors.red[400], fontSize: 10),
              ),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'ACTIVE',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue[300]),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${gettingWorldData.totalActive}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(''),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'RECOVERED',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.green),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${gettingWorldData.totalRecovered}',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(''),
            ],
          ),
          Column(
            children: <Widget>[
              Text(
                'DECEASED',
                style: TextStyle(
                    letterSpacing: 1,
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '${gettingWorldData.totalDeceased}',
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '[+${gettingWorldData.newDeceased}]',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      );
  }
}

class GettingWorldData {
  var total;
  var newCases;
  var totalDeceased;
  var newDeceased;
  var totalRecovered;
  var totalActive;

  void updateUI(dynamic data) {
    if (data == null) {
      total = 0;
      newCases = 0;
      totalDeceased = 0;
      newDeceased = 0;
      totalRecovered = 0;
    } else {
      total = data["world_total"]["total_cases"];
      newCases = data["world_total"]["new_cases"];
      totalDeceased = data["world_total"]["total_deaths"];
      newDeceased = data["world_total"]["new_deaths"];
      totalRecovered = data["world_total"]["total_recovered"];
      totalActive = data["world_total"]["active_cases"];
    }
  }
}

class CountryData extends StatelessWidget {
  CountryData(
      {this.countryTotal,
      this.countryNew,
      this.countryTotalDeceased,
      this.countryNewDeceased,
      this.countryActive,
      this.countryTotalRecovered});
  final countryTotal;
  final countryNew;
  final countryTotalDeceased;
  final countryNewDeceased;
  final countryTotalRecovered;
  final countryActive;

  @override
  Widget build(BuildContext context) {
    if (countryTotal == null) {
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'CONFIRMED',
                style: GoogleFonts.montserrat(
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    letterSpacing: 1),
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
            ],
          ),
        ],
      );
    } else
      return Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          Column(
            children: <Widget>[
              Text(
                'CONFIRMED',
                style: GoogleFonts.montserrat(
                    fontSize: KTitleFontSize,
                    fontWeight: FontWeight.bold,
                    color: Colors.red,
                    letterSpacing: 1),
              ),
              SizedBox(
                height: 10.0,
              ),
              Text(
                '$countryTotal',
                style: GoogleFonts.montserrat(
                    fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '[+$countryNew]',
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
                '$countryActive',
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
                '$countryTotalRecovered',
                style: GoogleFonts.montserrat(
                    fontSize: 12, fontWeight: FontWeight.bold),
              ),
              Text(''),
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
                '$countryTotalDeceased',
                style: GoogleFonts.montserrat(
                    fontSize: 13, fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 3,
              ),
              Text(
                '[+$countryNewDeceased]',
                style: GoogleFonts.montserrat(
                  color: Colors.grey,
                  fontSize: 10,
                ),
              ),
            ],
          ),
        ],
      );
  }
}
