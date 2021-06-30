import 'dart:async';
import 'dart:developer';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:image_picker/image_picker.dart';
import "constraint.dart";
import 'bottomnav.dart';
import 'dashboard.dart';
import 'search.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';
import 'package:flutter_sms/flutter_sms.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';
import 'package:taher/profile.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'CircleProgress.dart';
import 'main.dart';

class alarm extends StatefulWidget {
  @override
  _AlarmState createState() => _AlarmState();
}

class _AlarmState extends State<alarm> with SingleTickerProviderStateMixin {
  var avatarImageFile, backgroundImageFile;
  final databaseReference = FirebaseDatabase.instance.reference();

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      backgroundColor: Colors.red.withOpacity(0.9),
      body: Stack(children: <Widget>[
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
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                      SizedBox(height: 260),
                      Text(
                        'Press STOP  if it is a FALSE ALARM \nor if the situation is brought under control',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 100),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          ElevatedButton(
                              child: Text("STOP".toUpperCase(),
                                  style: TextStyle(
                                      fontSize: 54,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              style: ButtonStyle(
                                  foregroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.transparent),
                                  backgroundColor:
                                      MaterialStateProperty.all<Color>(
                                          Colors.white),
                                  shape: MaterialStateProperty.all<
                                          RoundedRectangleBorder>(
                                      RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                          side: BorderSide(
                                              color: Colors.white)))),
                              onPressed: () async {
                                databaseReference
                                    .push()
                                    .parent()
                                    .child("AlarmStop")
                                    .set({
                                  "alarm": "stop",
                                });
                                await new Future.delayed(
                                    const Duration(seconds: 5));
                                databaseReference
                                    .push()
                                    .parent()
                                    .child("AlarmStop")
                                    .set({
                                  "alarm": "nostop",
                                });
                              }),
                        ],
                      )
                    ]))))
      ]),
    );
  }
}
