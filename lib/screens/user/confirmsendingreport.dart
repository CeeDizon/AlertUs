import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/main.dart';
import 'package:firebasetest/map%20screens/firescreen.dart';
import 'package:firebasetest/map%20screens/hospitalscreen.dart';
import 'package:firebasetest/map%20screens/policescreen.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:location/location.dart' as loc;
import 'package:awesome_notifications/awesome_notifications.dart';

var currentUser = FirebaseAuth.instance.currentUser;
late String name;
late String phone;
enum DialogsAction { yes, cancel }

class ConfirmSendingReport {
  static Future<DialogsAction> yesCancelDialog(
    BuildContext context,
    String title,
    String body,
  ) async {
    String userid = currentUser.uid;
    final loc.Location location = loc.Location();
    StreamSubscription<loc.LocationData>? _locationSubscription;

    final action = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            title: Text(title),
            content: Text(body),
            actions: <Widget>[
              FlatButton(
                onPressed: () async {
                  if (title == "Report Sent to Fire Stations") {
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
                    Notify();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FireScreen()),
                    );
                  }
                  if (title == "Report Sent to Hospitals") {
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
                    Notify();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HospitalScreen()),
                    );
                  }
                  if (title == "Report Sent to Police Stations") {
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
                    Notify();
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => PoliceScreen()),
                    );
                  }
                },
                child: Text(
                  'OK',
                  style: TextStyle(
                      color: Colors.black, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          );
        });
    return (action != null) ? action : DialogsAction.cancel;
  }
}

void Notify() async {
  String time = await AwesomeNotifications().getLocalTimeZoneIdentifier();
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
        id: 1,
        displayOnBackground: true,
        displayOnForeground: true,
        channelKey: 'key1',
        title: 'Report Received by Authorities',
        bigPicture:
            'https://9uxfkln8zr-flywheel.netdna-ssl.com/wp-content/uploads/emergency-response-banner-1024x342.png',
        notificationLayout: NotificationLayout.BigPicture,
        body: 'Emergency Aid will arrive as soon as possible'),
    schedule:
        NotificationInterval(interval: 10, timeZone: time, repeats: false),
  );
}
