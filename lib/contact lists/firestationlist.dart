import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/map%20screens/firescreen.dart';
import 'package:firebasetest/screens/user/confirmviewmap.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart' as loc;

class FireStationList extends StatefulWidget {
  @override
  _FireStationList createState() => _FireStationList();
}

var currentUser = FirebaseAuth.instance.currentUser;

class _FireStationList extends State<FireStationList> {
  TextEditingController messageController = new TextEditingController();
  String userid = currentUser.uid;
  final loc.Location location = loc.Location();
  StreamSubscription<loc.LocationData>? _locationSubscription;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "List of Fire Stations",
        ),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: Center(
        child: new SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Angeles City Fire Station\nAddress: Rizal St, San. Nicolas, Angeles, Pampanga\nContacts: (045) 322-6758\n  \nAngeles City Central Fire Station\nAddress: Pulung Maragul, Angeles, Pampanga\nContacts: (045) 322-23332',
                style: TextStyle(
                    color: Colors.black,
                    fontSize: 25.0,
                    fontWeight: FontWeight.bold),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Center(
                child: Wrap(
                  spacing: 10,
                  runSpacing: 5.0,
                  children: <Widget>[
                    SizedBox(
                      width: 340.0,
                      height: 70.0,
                      child: Card(
                          color: Colors.redAccent[700],
                          elevation: 1.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: InkWell(
                            onTap: () async {
                              try {
                                final loc.LocationData _locationResult =
                                    await location.getLocation();
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(userid)
                                    .set({
                                  'latitude': _locationResult.latitude,
                                  'longitude': _locationResult.longitude,
                                }, SetOptions(merge: true));
                              } catch (e) {
                                print(e);
                              }
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => FireScreen()),
                              );
                            },
                            child: Center(
                                child: Padding(
                              padding: const EdgeInsets.all(1.0),
                              child: Row(
                                children: <Widget>[
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Icon(
                                      Icons.location_pin,
                                      size: 50.0,
                                      color: Colors.yellowAccent,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.center,
                                    child: FittedBox(
                                      child: Text("VIEW CLOSEST FIRE STATION",
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.yellowAccent,
                                            fontWeight: FontWeight.bold,
                                          )),
                                    ),
                                  )
                                ],
                              ),
                            )),
                          )),
                    ),
                  ],
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
