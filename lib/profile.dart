import 'dart:async';
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:taher/dashboard.dart';

import 'bottomnav.dart';

class EditProfile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new EditProfileScreen(),
      backgroundColor: Colors.transparent,
    );
  }
}

class EditProfileScreen extends StatefulWidget {
  @override
  State createState() => new EditProfileScreenState();
}

class EditProfileScreenState extends State<EditProfileScreen> {
  var avatarImageFile, backgroundImageFile;
  final databaseReference = FirebaseDatabase.instance.reference();
  String sex;
  TextEditingController namecont = TextEditingController();
  TextEditingController makanicont = TextEditingController();
  TextEditingController addresscont = TextEditingController();
  TextEditingController sexcont = TextEditingController();
  TextEditingController flatorvilla = TextEditingController();
  TextEditingController phonenumcont = TextEditingController();
  TextEditingController emergencont = TextEditingController();
  TextEditingController watchmancont = TextEditingController();

  Future getImage(bool isAvatar) async {
    var result = await ImagePicker().getImage(source: ImageSource.gallery);
    setState(() {
      if (isAvatar) {
        avatarImageFile = result;
      } else {
        backgroundImageFile = result;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    timeDilation = 1.0;
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                      new Container(
                        color: Colors.white,
                        child: new Stack(
                          children: <Widget>[
                            // Background
                            (backgroundImageFile == null)
                                ? new Image.asset(
                                    'images/bg_uit.jpg',
                                    width: double.infinity,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  )
                                : new Image.file(
                                    backgroundImageFile,
                                    width: double.infinity,
                                    height: 150.0,
                                    fit: BoxFit.cover,
                                  ),

                            // Button change background
                            new Positioned(
                              child: new Material(
                                child: new IconButton(
                                  icon: new Image.asset(
                                    'images/ic_camera.png',
                                    width: 30.0,
                                    height: 30.0,
                                    fit: BoxFit.cover,
                                  ),
                                  // onPressed: () => getImage(false),
                                  padding: new EdgeInsets.all(0.0),
                                  highlightColor: Colors.black,
                                  iconSize: 30.0, onPressed: () {},
                                ),
                                borderRadius: new BorderRadius.all(
                                    new Radius.circular(30.0)),
                                color: Colors.grey.withOpacity(0.5),
                              ),
                              right: 5.0,
                              top: 5.0,
                            ),

                            // Avatar and button
                            new Positioned(
                              child: new Stack(
                                children: <Widget>[
                                  (avatarImageFile == null)
                                      ? new Image.asset(
                                          'images/ic_avatar.png',
                                          width: 70.0,
                                          height: 70.0,
                                        )
                                      : new Material(
                                          child: new Image.file(
                                            avatarImageFile,
                                            width: 70.0,
                                            height: 70.0,
                                            fit: BoxFit.cover,
                                          ),
                                          borderRadius: new BorderRadius.all(
                                              new Radius.circular(40.0)),
                                        ),
                                  new Material(
                                    child: new IconButton(
                                      icon: new Image.asset(
                                        'images/ic_camera.png',
                                        width: 40.0,
                                        height: 40.0,
                                        fit: BoxFit.cover,
                                      ),
                                      onPressed: () => getImage(true),
                                      padding: new EdgeInsets.all(0.0),
                                      highlightColor: Colors.black,
                                      iconSize: 70.0,
                                    ),
                                    borderRadius: new BorderRadius.all(
                                        new Radius.circular(40.0)),
                                    color: Colors.grey.withOpacity(0.5),
                                  ),
                                ],
                              ),
                              top: 115.0,
                              left: MediaQuery.of(context).size.width / 2 -
                                  70 / 2,
                            )
                          ],
                        ),
                        width: double.infinity,
                        height: 200.0,
                      ),
                      Container(
                        color: Colors.white,
                        child: new Column(
                          children: <Widget>[
                            // Username
                            new Container(
                              child: new Text(
                                'Name',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, bottom: 5.0, top: 10.0),
                            ),
                            new Container(
                              child: new TextFormField(
                                controller: namecont,
                                decoration: new InputDecoration(
                                    labelText: namecont.text.isEmpty
                                        ? "Enter Your Name"
                                        : namecont.text.toString(),
                                    hintText: 'Enter Your Name',
                                    border: new UnderlineInputBorder(),
                                    contentPadding: new EdgeInsets.all(5.0),
                                    hintStyle:
                                        new TextStyle(color: Colors.black54)),
                              ),
                              margin:
                                  new EdgeInsets.only(left: 30.0, right: 30.0),
                            ),
                            new Container(
                              child: new Text(
                                'Sex',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, top: 30.0, bottom: 5.0),
                            ),
                            new Container(
                              child: new DropdownButton<String>(
                                items: <String>['Male', 'Female']
                                    .map((String value) {
                                  return new DropdownMenuItem<String>(
                                    value: value,
                                    child: new Text(value),
                                  );
                                }).toList(),
                                onChanged: (value) {
                                  setState(() {
                                    sex = value;
                                  });
                                },
                                hint: sex == null
                                    ? new Text('Male')
                                    : new Text(
                                        sex,
                                        style:
                                            new TextStyle(color: Colors.black),
                                      ),
                                style: new TextStyle(color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(left: 50.0),
                            ),

                            // Country
                            new Container(
                              child: new Text(
                                'Makani Number',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, top: 30.0, bottom: 5.0),
                            ),
                            new Container(
                              child: new TextFormField(
                                controller: makanicont,
                                decoration: new InputDecoration(
                                    hintText: 'eg . 3688698000',
                                    border: new UnderlineInputBorder(),
                                    contentPadding: new EdgeInsets.all(5.0),
                                    hintStyle:
                                        new TextStyle(color: Colors.black54)),
                                keyboardType: TextInputType.number,
                              ),
                              margin:
                                  new EdgeInsets.only(left: 30.0, right: 30.0),
                            ),
                            new Container(
                              child: new Text(
                                'Flat or villa Number',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, top: 30.0, bottom: 5.0),
                            ),
                            new Container(
                              child: new TextFormField(
                                controller: flatorvilla,
                                decoration: new InputDecoration(
                                    hintText: 'eg . 1102 or 32',
                                    border: new UnderlineInputBorder(),
                                    contentPadding: new EdgeInsets.all(5.0),
                                    hintStyle:
                                        new TextStyle(color: Colors.black54)),
                                keyboardType: TextInputType.number,
                              ),
                              margin:
                                  new EdgeInsets.only(left: 30.0, right: 30.0),
                            ),

                            // Address
                            new Container(
                              child: new Text(
                                'Address',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, top: 30.0, bottom: 5.0),
                            ),
                            new Container(
                              child: new TextFormField(
                                controller: addresscont,
                                decoration: new InputDecoration(
                                    hintText:
                                        'Street 5, Nahda 2, 1102 Pond View',
                                    border: new UnderlineInputBorder(),
                                    contentPadding: new EdgeInsets.all(5.0),
                                    hintStyle:
                                        new TextStyle(color: Colors.black54)),
                              ),
                              margin:
                                  new EdgeInsets.only(left: 30.0, right: 30.0),
                            ),

                            // About me
                            new Container(
                              child: new Text(
                                'Phone Number',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, top: 30.0, bottom: 5.0),
                            ),
                            new Container(
                              child: new TextFormField(
                                controller: phonenumcont,
                                decoration: new InputDecoration(
                                    hintText: 'eg . 0506563036',
                                    border: new UnderlineInputBorder(),
                                    contentPadding: new EdgeInsets.all(5.0),
                                    hintStyle:
                                        new TextStyle(color: Colors.black54)),
                                keyboardType: TextInputType.number,
                              ),
                              margin:
                                  new EdgeInsets.only(left: 30.0, right: 30.0),
                            ),

                            // About me
                            new Container(
                              child: new Text(
                                'Emergency Phone Number',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, top: 30.0, bottom: 5.0),
                            ),
                            new Container(
                              child: new TextFormField(
                                controller: emergencont,
                                decoration: new InputDecoration(
                                    hintText: '050 1234567',
                                    border: new UnderlineInputBorder(),
                                    contentPadding: new EdgeInsets.all(5.0),
                                    hintStyle:
                                        new TextStyle(color: Colors.black54)),
                                keyboardType: TextInputType.number,
                              ),
                              margin:
                                  new EdgeInsets.only(left: 30.0, right: 30.0),
                            ),
                            new Container(
                              child: new Text(
                                'Watchman Phone Number',
                                style: new TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.0,
                                    color: Colors.black),
                              ),
                              margin: new EdgeInsets.only(
                                  left: 10.0, top: 30.0, bottom: 5.0),
                            ),
                            new Container(
                              child: new TextFormField(
                                controller: watchmancont,
                                decoration: new InputDecoration(
                                    hintText: '050 1234567',
                                    border: new UnderlineInputBorder(),
                                    contentPadding: new EdgeInsets.all(5.0),
                                    hintStyle:
                                        new TextStyle(color: Colors.black54)),
                                keyboardType: TextInputType.number,
                              ),
                              margin:
                                  new EdgeInsets.only(left: 30.0, right: 30.0),
                            ),

                            // Sex
                          ],
                          crossAxisAlignment: CrossAxisAlignment.start,
                        ),
                      ),
                      Container(
                        color: Colors.transparent,
                        padding: EdgeInsets.symmetric(vertical: 25.0),
                        width: double.infinity,
                        child: RaisedButton(
                          elevation: 5.0,
                          onPressed: () => {
                            // userSetup("Tahir Saifi")
                            //
                            // // context.read<authservice>().signIn(
                            // //     emailController.text.trim(), passwordController.text.trim())
                            databaseReference
                                .push()
                                .parent()
                                .child(FirebaseAuth.instance.currentUser.uid
                                    .toString())
                                .set({
                              "Name": namecont.value.text,
                              "Sex": sex,
                              "Makani": makanicont.value.text,
                              "flatorvilla": flatorvilla.value.text,
                              "address": addresscont.value.text,
                              "Emergency": emergencont.value.text,
                              "watchman": watchmancont.value.text,
                              "phone": phonenumcont.value.text
                            }),
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DashBoard())),
                          },
                          padding: EdgeInsets.all(15.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30.0),
                          ),
                          color: Colors.black,
                          child: Text(
                            'Save',
                            style: TextStyle(
                              color: Colors.orange,
                              letterSpacing: 1.5,
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'OpenSans',
                            ),
                          ),
                        ),
                      )
                    ]))))
      ]),
    );
  }
}
// Future<void> userSetup(String displayName) async {
//   //firebase auth instance to get uuid of user
//   String auth = FirebaseAuth.instance.currentUser.uid;

//   //now below I am getting an instance of firebaseiestore then getting the user collection
//   //now I am creating the document if not already exist and setting the data.
//   FirebaseFirestore.instance
//       .collection('Users')
//       .doc(auth)
//       .set({'displayName': displayName, 'uid': auth});

//   return;
// }