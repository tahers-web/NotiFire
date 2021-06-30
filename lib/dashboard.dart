import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import "constraint.dart";
import 'bottomnav.dart';
import 'search.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:intl/intl.dart';

import 'CircleProgress.dart';

class DashBoard extends StatefulWidget {
  @override
  _DashBoardState createState() => _DashBoardState();
}

class _DashBoardState extends State<DashBoard>
    with SingleTickerProviderStateMixin {
  bool isLoading = false;

  final databaseReference = FirebaseDatabase.instance.reference();
  AnimationController progressController;
  Animation<double> tempAnimation;

  Animation<double> humidityAnimation;

  final FirebaseMessaging _messaging = FirebaseMessaging.instance;
  String namecont;
  String makanicont;
  String emergencont;
  String addresscont;
  String flatorvilla;
  String phonenumcont;
  String watchmancont;
  TimeOfDay hour;
  @override
  void initState() {
    super.initState();
    hour = TimeOfDay.now();

    _messaging.getToken().then((token) {
      print(token);
    });

    databaseReference.child('Sensor').once().then((DataSnapshot snapshot) {
      double _temp = snapshot.value['temperature'];
      double _humidity = snapshot.value['humidity'];

      databaseReference
          .child(FirebaseAuth.instance.currentUser.uid.toString())
          .once()
          .then((DataSnapshot snapshot) {
        namecont = snapshot.value['Name'].toString();
        makanicont = snapshot.value['Makani'];
        emergencont = snapshot.value['Emergency'];
        addresscont = snapshot.value['address'];
        flatorvilla = snapshot.value['flatorvilla'];
        phonenumcont = snapshot.value['phone'];
        watchmancont = snapshot.value['watchman'];
      });

      isLoading = true;
      _DashboardInit(_temp, _humidity);
    });
  }

  _DashboardInit(double temp, double humid) {
    progressController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 2000)); //5s

    tempAnimation =
        Tween<double>(begin: -50, end: temp).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    humidityAnimation =
        Tween<double>(begin: 0, end: humid).animate(progressController)
          ..addListener(() {
            setState(() {});
          });

    progressController.forward();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          Container(
            height: size.height * .45,
            decoration: BoxDecoration(
              //color: Colors.blue.withOpacity(0.2),
              image: DecorationImage(
                image: AssetImage("images/back.png"),
                fit: BoxFit.fitWidth,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: size.height * 0.03,
                    ),
                    Text(
                      "DashBoard",
                      style: Theme.of(context).textTheme.display1.copyWith(
                            fontWeight: FontWeight.w900,
                            color: Colors.black,
                          ),
                    ),

                    SizedBox(height: 10),
                    // ignore: unrelated_type_equality_checks
                    Text(
                      hour.period.toString() == "DayPeriod.am"
                          ? "Good Morning".toUpperCase()
                          : "Good Evening".toUpperCase(),
                      style: TextStyle(fontSize: 22),
                    ),
                    SizedBox(height: 10),
                    Stack(
                      children: <Widget>[
                        Text(
                          (namecont == null)
                              ? "Update Database"
                              : namecont.toString().toUpperCase(),
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 30,
                              color: Colors.red),
                        ),
                        SizedBox(height: 2),
                        // Container(
                        //     child: GoogleMap(
                        //         mapType: MapType.terrain,
                        //         initialCameraPosition:
                        //             CameraPosition(target: _center, zoom: 11.0),
                        //         onMapCreated: _onMapCreated))
                      ],
                    ),
                    SizedBox(height: 5),

                    SizedBox(
                      width: size.width * .6, // it just take 60% of total width
                      child: Text(
                        makanicont == null
                            ? "Update Database"
                            : "Makani Number : " +
                                makanicont.toString().toUpperCase() +
                                "\n" "Room No : " +
                                flatorvilla.toUpperCase() +
                                "\n" "Address  : " +
                                addresscont.toUpperCase(),
                      ),
                    ),
                    SizedBox(
                      width: size.width * .5, // it just take the 50% width
                      child: SearchBar(),
                    ),
                    SizedBox(height: 5),
                    Wrap(
                      spacing: 15,
                      runSpacing: 20,
                      children: <Widget>[
                        Container(
                          child: SizedBox(
                            child: Container(
                              child: isLoading
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: <Widget>[
                                        CustomPaint(
                                          foregroundPainter: CircleProgress(
                                              tempAnimation.value, false),
                                          child: Container(
                                            width: 165,
                                            height: 175,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Temperature'),
                                                  Text(
                                                    '${tempAnimation.value.toInt()}',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '\u2103',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        CustomPaint(
                                          foregroundPainter: CircleProgress(
                                              humidityAnimation.value, false),
                                          child: Container(
                                            width: 165,
                                            height: 175,
                                            child: Center(
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Text('Humidity'),
                                                  Text(
                                                    '${humidityAnimation.value.toInt()}',
                                                    style: TextStyle(
                                                        fontSize: 25,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  Text(
                                                    '%',
                                                    style: TextStyle(
                                                        fontSize: 10,
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    )
                                  : Text(
                                      'Loading...',
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                            ),
                          ),
                        ),
                        SeassionCard(
                          seassionText: "Watch-man",
                          press: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (context) {
                                  return Container(
                                    color: Colors.transparent,
                                    height: 180,
                                    child: Container(
                                      child: buildbottomwatchman(context),
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.only(
                                            topLeft: const Radius.circular(25),
                                            topRight:
                                                const Radius.circular(25)),
                                      ),
                                    ),
                                  );
                                });
                          },
                        ),
                        SeassionCard(
                          seassionText: "Police",
                          press: () {
                            FlutterPhoneDirectCaller.callNumber("000");
                          },
                        ),
                        SeassionCard(
                          seassionText: "Fire Station",
                          press: () {
                            FlutterPhoneDirectCaller.callNumber("001");
                          },
                        ),
                        SeassionCard(
                          seassionText: "SOS",
                          press: () {
                            FlutterPhoneDirectCaller.callNumber(emergencont);
                          },
                        ),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text(
                      "Fire Safety Tips",
                      style: Theme.of(context).textTheme.title.copyWith(
                          fontWeight: FontWeight.bold, color: Colors.red),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20),
                      padding: EdgeInsets.all(10),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          //SvgPicture.asset(
                          //"assets/icons/Meditation_women_small.svg",
                          //),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Trouble Breathing in Smoke area",
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                Text(
                                    "Wet a towel and place it on ur mouth for a quick Smoke Filter")
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(5),
                            //child: SvgPicture.asset("assets/icons/Lock.svg"),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 5),
                      padding: EdgeInsets.all(5),
                      height: 90,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(13),
                        boxShadow: [
                          BoxShadow(
                            offset: Offset(0, 17),
                            blurRadius: 23,
                            spreadRadius: -13,
                            color: kShadowColor,
                          ),
                        ],
                      ),
                      child: Row(
                        children: <Widget>[
                          //SvgPicture.asset(
                          //"assets/icons/Meditation_women_small.svg",
                          //),
                          SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Trouble Breathing in Smoke area",
                                  style: Theme.of(context).textTheme.subtitle,
                                ),
                                Text(
                                    "Wet a towel and place it on ur mouth for a quick Smoke Filter")
                              ],
                            ),
                          ),

                          Padding(
                            padding: EdgeInsets.all(10),
                            //child: SvgPicture.asset("assets/icons/Lock.svg"),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _sendSMS(String message, List<String> recipents) async {
    String _result = await sendSMS(message: message, recipients: recipents)
        .catchError((onError) {
      print(onError);
    });
    print(_result);
  }

  Column buildbottomwatchman(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          leading: Icon(Icons.sms),
          title: Text('SMS for House Checkup'),
          onTap: () {
            var _temp = tempAnimation.value.toInt().toString();
            var _hum = humidityAnimation.value.toInt().toString();
            var time = DateFormat.yMEd().add_jms().format(DateTime.now());
            launchSms(
                message: "Please do my House Checkup " +
                    "\n" +
                    "Makani Number is $makanicont " +
                    "\n" +
                    "Flat No is $flatorvilla " +
                    "\n" +
                    "Temperature of room  $_temp \u2103 " +
                    "\n" +
                    "Humidity of room $_hum % " +
                    "\n" +
                    "at $time",
                number: watchmancont);

            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.sms),
          title: Text('SMS for Reset Fire-Alarm'),
          onTap: () {
            launchSms(
                message: "Flat No is $flatorvilla " +
                    "\n" +
                    "Please reset my house fire Alarm, It's a False alarm.",
                number: watchmancont);
            //
            Navigator.pop(context);
          },
        ),
        ListTile(
          leading: Icon(Icons.call_outlined),
          title: Text('CALL WATCHMAN'),
          onTap: () {
            FlutterPhoneDirectCaller.callNumber(watchmancont);
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}

class SeassionCard extends StatelessWidget {
  final String seassionText;
  final bool isDone;
  final Function press;
  const SeassionCard({
    Key key,
    this.seassionText,
    this.isDone = false,
    this.press,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return ClipRRect(
        borderRadius: BorderRadius.circular(13),
        child: Container(
          width: constraint.maxWidth / 2 - 11,
          //constraint.maxWidth provide us the available with for this widget
          padding: EdgeInsets.all(1),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                offset: Offset(0, 17),
                blurRadius: 10,
                spreadRadius: -13,
                color: kShadowColor,
              ),
            ],
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: press,
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 40,
                      width: 45,
                      decoration: BoxDecoration(
                        color: isDone ? kBlueColor : Colors.white,
                        shape: BoxShape.circle,
                        border: Border.all(color: kBlueColor),
                      ),
                      child: Icon(
                        Icons.call,
                        color: isDone ? Colors.white : Colors.black,
                      ),
                    ),
                    SizedBox(width: 10),
                    Text(
                      "$seassionText",
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    });
  }
}
