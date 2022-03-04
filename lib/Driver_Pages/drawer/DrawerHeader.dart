// ignore_for_file: prefer_const_constructors, file_names, unused_local_variable, unused_import, non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Driver_Pages/pages/request_details.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';

String? driver_img;

Widget createDrawerHeader() {
  CollectionReference users = FirebaseFirestore.instance.collection('Driver');
  return DrawerHeader(
    margin: EdgeInsets.zero,
    padding: EdgeInsets.zero,
    child: FutureBuilder<DocumentSnapshot>(
      future: users.doc(id).get(),
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          Map<String, dynamic> data =
              snapshot.data!.data() as Map<String, dynamic>;
          driver_img = data["Driver Image"];

          return Material(
            child: Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 20,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialogFunc(context, data["Driver Image"]);
                    },
                    child: Align(
                      alignment: Alignment.center,
                      child: Stack(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.white, width: 5),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(30),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  spreadRadius: 0,
                                  blurRadius: 20,
                                  color: Colors.black.withOpacity(0),
                                  offset: Offset(5, 15),
                                )
                              ],
                            ),
                            child: ClipOval(
                              child: Image.network(
                                data["Driver Image"],
                                width: 60,
                                height: 60,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${data['First Name']} ${data['Last Name']}",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text("${data['Email']}",
                      style: TextStyle(
                        fontSize: 9,
                      ))
                ],
              ),
            ),
          );
        }

        return Center(
          child: CircularProgressIndicator(),
        );
      },
    ),
    //Stack(
    //   children: <Widget>[
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.center,
    //       children: [
    //         Column(
    //           // ignore: prefer_const_literals_to_create_immutables
    //           children: [
    //             SizedBox(
    //               height: 20,
    //             ),
    //             CircleAvatar(
    //               backgroundColor: Colors.black,
    //               radius: 25,
    //               child: Icon(
    //                 Icons.person,
    //                 size: 35,
    //               ),
    //             ),
    //             SizedBox(
    //               height: 10,
    //             ),
    //             Text(
    //               "Abcd",
    //               style: TextStyle(fontSize: 20),
    //             ),
    //             SizedBox(
    //               height: 5,
    //             ),
    //             Text("abcd@gmail.com")
    //           ],
    //         ),
    //       ],
    //     ),
    //   ],
    // ),
  );
}
