import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebasetest/screens/emergency%20unit/reportoptiondialog.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class FakeFireReports extends StatefulWidget {
  FirebaseFirestore _firestore = FirebaseFirestore.instance;
  @override
  _FakeFireReports createState() => _FakeFireReports();
}

class _FakeFireReports extends State<FakeFireReports> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text("Fraudulent Reports"),
        backgroundColor: Colors.redAccent[700],
      ),
      backgroundColor: Colors.orange[200],
      body: StreamBuilder<QuerySnapshot>(
        stream: widget._firestore.collection('fake fire reports').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Text('Loading..');
          }

          return ListView.builder(
            itemCount: snapshot.data!.docs.length,
            itemBuilder: (context, index) {
              String itemTitle = snapshot.data!.docs[index]['Report'];
              String itemSubtitle =
                  snapshot.data!.docs[index]['Completed on'].toString();
              return CardItem(
                itemTitle: itemTitle,
                itemSubtitle: itemSubtitle,
              );
            },
          );
        },
      ),
    );
  }
}

class CardItem extends StatefulWidget {
  String itemTitle;
  String itemSubtitle;
  CardItem({required this.itemTitle, required this.itemSubtitle});
  @override
  _CardItem createState() => _CardItem(itemTitle, itemSubtitle);
}

class _CardItem extends State<CardItem> {
  String itemTitle;
  String itemSubtitle;
  _CardItem(this.itemTitle, this.itemSubtitle);
  late String yourUid;
  bool isChecked = false;
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow[800],
      child: ListTile(
        title: Text(
          widget.itemTitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text(
          widget.itemSubtitle,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
