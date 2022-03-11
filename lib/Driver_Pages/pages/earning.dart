// ignore_for_file: use_key_in_widget_constructors, camel_case_types, unnecessary_const, duplicate_ignore, prefer_const_literals_to_create_immutables, prefer_const_constructors, deprecated_member_use

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Driver_Pages/pages/request_details.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';

import 'home.dart';

class earning extends StatefulWidget {
  @override
  _earningState createState() => _earningState();
}

Float Earning = 0.0 as Float;

class _earningState extends State<earning> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    calculation();
  }

  void calculation() async {
    await FirebaseFirestore.instance
        .collection("Driver")
        .doc(id)
        .collection("Payment")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        print("================${element['UserFirstName']}================");
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Earning",
        ),
        // ignore: unnecessary_const

        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => home()));
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.only(
          left: 5,
          top: 5,
          right: 5,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: 180,
                    decoration: BoxDecoration(
                        color: Colors.blueAccent,
                        borderRadius: BorderRadius.circular(12),
                        // ignore: prefer_const_literals_to_create_immutables
                        boxShadow: [
                          const BoxShadow(
                            offset: const Offset(0, 2),
                            blurRadius: 5,
                            color: Colors.blueAccent,
                          )
                        ]),
                    child: Container(
                      padding: const EdgeInsets.only(
                        left: 10,
                        top: 20,
                        right: 10,
                      ),
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                "Rs.",
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 22,
                                  height: 0,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                TotalPrice,
                                // ignore: prefer_const_constructors
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 35,
                                  height: 1.5,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                          const Text(
                            "Your Earning",
                            style: const TextStyle(
                              color: Colors.white54,
                              fontSize: 17,
                              height: 1,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(
                            height: 25,
                          ),
                          RaisedButton(
                            onPressed: () {
                              // Navigator.push(
                              //     context,
                              //     MaterialPageRoute(
                              //         builder: (context) => home()));
                            },
                            color: Colors.deepPurple,
                            padding: EdgeInsets.symmetric(horizontal: 50),
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Text(
                              "WITHDRAW",
                              style: TextStyle(
                                fontSize: 20,
                                color: Colors.white,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
