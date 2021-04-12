import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:covid19tracker2/services/info.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:covid19tracker2/components/total_data.dart';
import 'package:covid19tracker2/services/getting_data.dart';
import 'package:covid19tracker2/services/constants.dart';
import 'package:vibration/vibration.dart';

class DataScreen extends StatefulWidget {
  @override
  _DataScreenState createState() => _DataScreenState();
}

class _DataScreenState extends State<DataScreen> {
  var data;
  List stateUt = [];
  List confirm = [];
  List confirmDelta = [];
  List decease = [];
  List deceaseDelta = [];
  List recovered = [];
  List recoveredDelta = [];

  Info info = Info();
  GettingData gettingData = GettingData();

  @override
  void initState() {
    super.initState();
    getReportData();
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "Updated till ${gettingData.updatedTill}",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 2,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 14);
  }

  dynamic getReportData() async {
    var data = await info.getData();
    setState(() {
      gettingData.updateUI(data);
      stateUt = gettingData.statesUt;
      confirm = gettingData.confirm;
      confirmDelta = gettingData.confirmDelta;
      decease = gettingData.decease;
      deceaseDelta = gettingData.deceDelta;
      recovered = gettingData.rec;
      recoveredDelta = gettingData.recDelta;
    });
    showToast();
  }

  @override
  Widget build(BuildContext context) {
    if (confirm.length == 0) {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Vibration.vibrate(duration: 10);
            getReportData();
          },
          child: const Icon(Icons.autorenew_rounded, size: 25),
        ),
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Center(
                child: CircularProgressIndicator(),
              )
            ],
          ),
        ),
      );
    } else {
      return Scaffold(
        backgroundColor: kBackgroundColor,
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Vibration.vibrate(duration: 10);
            getReportData();
          },
          child: const Icon(Icons.autorenew_rounded, size: 25),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
            child: Container(
              margin: EdgeInsets.only(top: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    height: 90,
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kFolderColor,
                    ),
                    child: TotalData(
                      confirmed: gettingData.confirmed,
                      confirmedDelta: gettingData.confirmedDelta,
                      active: gettingData.active,
                      recovered: gettingData.recovered,
                      recoveredDelta: gettingData.recoveredDelta,
                      deceased: gettingData.deceased,
                      deceasedDelta: gettingData.deceasedDelta,
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                    padding: EdgeInsets.only(top: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: kFolderColor,
                    ),
                    child: Column(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Text(
                                'States',
                                style: GoogleFonts.montserrat(
                                  fontSize: 15,
                                  color: Colors.tealAccent,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Container(
                                child: Row(
                                  children: <Widget>[
                                    Text(
                                      'Confirmed',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: Colors.redAccent,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    Text(
                                      'Deceased',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: Colors.grey,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      'Recovered',
                                      style: GoogleFonts.montserrat(
                                        fontSize: 15,
                                        color: Colors.green,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        const Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8.0, vertical: 10),
                          child: Divider(thickness: 3),
                        ),
                        DetailList(
                          stateUt: stateUt,
                          confirm: confirm,
                          confirmDelta: confirmDelta,
                          decease: decease,
                          deceaseDelta: deceaseDelta,
                          recovered: recovered,
                          recoveredDelta: recoveredDelta,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      );
    }
  }
}

class DetailList extends StatefulWidget {
  DetailList(
      {this.stateUt,
      this.confirm,
      this.confirmDelta,
      this.decease,
      this.recoveredDelta,
      this.recovered,
      this.deceaseDelta});
  final List stateUt;
  final List confirm;
  final List confirmDelta;
  final List decease;
  final List deceaseDelta;
  final List recovered;
  final List recoveredDelta;

  @override
  _DetailListState createState() => _DetailListState();
}

class _DetailListState extends State<DetailList> {
  GettingData gettingData = GettingData();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .65,
      child: Scrollbar(
        child: ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemExtent: 40,
          itemCount: widget.stateUt.length,
          physics:
              BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Table(
                columnWidths: {
                  0: FractionColumnWidth(.25),
                  1: FractionColumnWidth(.19),
                  2: FractionColumnWidth(.19),
                  3: FractionColumnWidth(.2),
                },
                children: [
                  TableRow(
                    children: [
                      Text(
                        '${index + 1}. ${widget.stateUt[index]}',
                        style: GoogleFonts.montserrat(fontSize: 11),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '↑${widget.confirmDelta[index]}   ',
                            style: GoogleFonts.montserrat(
                                fontSize: 9, color: Colors.red),
                          ),
                          Text(
                            '${widget.confirm[index]}',
                            style: GoogleFonts.montserrat(fontSize: 11),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '↑${widget.deceaseDelta[index]}   ',
                            style: GoogleFonts.montserrat(
                                fontSize: 9, color: Colors.red),
                          ),
                          Text(
                            '${widget.decease[index]}',
                            style: GoogleFonts.montserrat(fontSize: 11),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text(
                            '↑${widget.recoveredDelta[index]}   ',
                            //textAlign: TextAlign.end,
                            style: GoogleFonts.montserrat(
                                fontSize: 9, color: Colors.red),
                          ),
                          Text(
                            '${widget.recovered[index]}',
                            //textAlign: TextAlign.values[1],
                            style: GoogleFonts.montserrat(
                              fontSize: 11,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

// Padding(
//   padding: const EdgeInsets.only(top: 20.0),
//   child: Align(
//     alignment: Alignment.topCenter,
//     child: Text(
//       '${gettingData.updatedTill}',
//       textAlign: TextAlign.center,
//       style: GoogleFonts.montserrat(
//         fontWeight: FontWeight.w500,
//         color: Colors.white,
//       ),
//     ),
//   ),
// ),

//                  Row(
//                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                    children: <Widget>[
//                      Container(
//                        decoration: BoxDecoration(
//                            color: Colors.grey[400],
//                            borderRadius: BorderRadius.circular(5)),
//                        padding: EdgeInsets.all(5),
//                        child: Text(
//                          'STATE/UT',
//                          style: TextStyle(
//                              fontSize: 18,
//                              fontWeight: FontWeight.w600,
//                              color: Colors.black),
//                        ),
//                      ),
//                      SizedBox(
//                        width: 10,
//                      ),
////                      Container(
////                        decoration: BoxDecoration(
////                            color: Colors.grey[400],
////                            borderRadius: BorderRadius.circular(5)),
////                        padding: EdgeInsets.all(5),
////                        child: Text(
////                          'Confirmed/Deceased',
////                          style: TextStyle(
////                              fontSize: 18,
////                              fontWeight: FontWeight.w600,
////                              color: Colors.black),
////                        ),
////                      ),
//                    ],
//                  ),

//            ListTile(
//            contentPadding: EdgeInsets.only(left: 28, right: 30),
//            leading: Text(
//              '${index + 1}. ${widget.stateUt[index]}',
//              style: TextStyle(fontSize: 14),
//            ),
//            title: Row(
//              mainAxisAlignment: MainAxisAlignment.end,
//              children: <Widget>[
//                Text(
//                  '↑${widget.confirmDelta[index]}   ',
//                  //textAlign: TextAlign.end,
//                  style: TextStyle(fontSize: 12, color: Colors.red),
//                ),
//                Text(
//                  '${widget.confirm[index]}  /  ${widget.decease[index]}',
//                  //textAlign: TextAlign.values[1],
//                  style: TextStyle(fontSize: 14),
//                ),
//              ],
//            ),
//          );
