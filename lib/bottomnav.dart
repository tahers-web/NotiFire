import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:taher/alarm.dart';
import 'package:taher/dashboard.dart';
import 'package:taher/main.dart';
import 'package:taher/profile.dart';
import 'constraint.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 70, vertical: 5),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.black,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          BottomNavItem(
            title: "Log-out",
            svgScr: "assets/icons/calendar.svg",
            press: () {
              showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text("Are you sure ? "),
                        content: Text(""),
                        actions: [
                          FlatButton(
                            onPressed: () {
                              FirebaseAuth.instance.signOut();
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginScreen()));
                            },
                            child: Text("Logout"),
                          ),
                        ],
                        elevation: 24.0);
                    // backgroundColor: Colors.lightBlue);
                  }).then(
                (value) => Navigator.pop(context),
              );
            },
          ),
          BottomNavItem(
              title: "Dashboard",
              svgScr: "images/dashboard.svg",
              isActive: true,
              press: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashBoard()));
              }),
          BottomNavItem(
            title: "Profile",
            svgScr: "assets/icons/Settings.svg",
            press: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => EditProfile()));
            },
          ),
          BottomNavItem(
              title: "Alarm",
              svgScr: "assets/icons/gym.svg",
              isActive: true,
              press: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => alarm()));
              }),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  final String svgScr;
  final String title;
  final Function press;
  final bool isActive;
  const BottomNavItem({
    Key key,
    this.svgScr,
    this.title,
    this.press,
    this.isActive = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(color: isActive ? kActiveIconColor : kTextColor),
          ),
        ],
      ),
    );
  }
}
