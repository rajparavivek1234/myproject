// ignore_for_file: prefer_const_constructors, avoid_print, camel_case_types, use_key_in_widget_constructors, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Driver_Pages/pages/accept_request.dart';
import 'package:myproject/Driver_Pages/pages/complete_order.dart';
import 'package:myproject/Driver_Pages/pages/driver_info.dart';
import 'package:myproject/Driver_Pages/pages/home.dart';
import 'package:myproject/Driver_Pages/pages/mapview.dart';
import 'package:myproject/Driver_Pages/pages/request_details.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';

class request_list extends StatefulWidget {
  @override
  State<request_list> createState() => _request_listState();
}

String rid = "";

class _request_listState extends State<request_list> {
  final db = FirebaseFirestore.instance;

  String url = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Request",
          // ignore: unnecessary_const
        ),
        leading: IconButton(
          // ignore: prefer_const_constructors
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home()));
          },
        ),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream:
            db.collection('Driver').doc(id).collection('Request').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.data!.size == 0) {
            return Scaffold(body: Center(child: Text("No Request")));
          } else {
            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListView(
                children: snapshot.data!.docs
                    .map(
                      (doc) => Padding(
                        padding:
                            const EdgeInsets.only(left: 10, right: 10, top: 8),
                        child: Card(
                          borderOnForeground: true,
                          elevation: 4,
                          child: ListTile(
                            title: Text(doc["First Name"] ?? ""),
                            leading: CircleAvatar(
                              radius: 25.0,
                              backgroundImage: NetworkImage(doc["Profile pic"]),
                              backgroundColor: Colors.transparent,
                            ),
                            onTap: () {
                              step = 1;
                              rid = doc.id;
                              print(rid);
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                    builder: (context) => request_details(
                                          rid: rid,
                                        )),
                              );
                            },
                            subtitle: Text(
                                '${doc['Starting Point']} ~> ${doc['Destination Point']}'),
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            );
          }
        },
      ),
    );
  }
}
