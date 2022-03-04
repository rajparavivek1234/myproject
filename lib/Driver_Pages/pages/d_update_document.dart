// ignore_for_file: deprecated_member_use, unnecessary_const, prefer_const_constructors, use_key_in_widget_constructors, camel_case_types, duplicate_ignore

import 'package:flutter/material.dart';
import 'package:myproject/Driver_Pages/pages/driver_info.dart';
import 'package:myproject/Driver_Pages/pages/home.dart';
import 'package:myproject/Driver_Pages/pages/upload_document.dart';

class d_update_document extends StatefulWidget {
  @override
  _d_update_documentState createState() => _d_update_documentState();
}

class _d_update_documentState extends State<d_update_document> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Update Driver Document",
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
        leading: IconButton(
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
      body: Container(
        padding: const EdgeInsets.only(
          left: 16,
          top: 25,
          right: 16,
        ),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              // Center(
              //   // ignore: sized_box_for_whitespace
              //   child: Container(
              //     height: 75,
              //     padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
              //     child: RaisedButton(
              //       onPressed: () {},
              //       color: Theme.of(context).accentColor,
              //       child: Row(
              //         mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //         // ignore: prefer_const_literals_to_create_immutables
              //         children: <Widget>[
              //           Text(
              //             'Your ID \n(AdharCard)',
              //             style: TextStyle(
              //               fontSize: 20,
              //               fontWeight: FontWeight.w700,
              //               color: Colors.white,
              //             ),
              //           ),
              //           Icon(
              //             Icons.arrow_forward_ios_rounded,
              //             color: Colors.white,
              //           )
              //         ],
              //       ),
              //     ),
              //   ),
              // ),
              Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 75,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: RaisedButton(
                    onPressed: () {
                      document = 'Licence';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => upload_document()),
                      );
                    },
                    color: Theme.of(context).accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        Text(
                          'Licence',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Center(
                // ignore: sized_box_for_whitespace
                child: Container(
                  height: 75,
                  padding: EdgeInsets.fromLTRB(0, 5, 0, 5),
                  child: RaisedButton(
                    onPressed: () {
                      document = 'Address Proof';
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => upload_document()),
                      );
                    },
                    color: Theme.of(context).accentColor,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      // ignore: prefer_const_literals_to_create_immutables
                      children: <Widget>[
                        // ignore: prefer_const_constructors
                        Text(
                          'Address Proof',
                          // ignore: prefer_const_constructors
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                          ),
                        ),
                        Icon(
                          Icons.arrow_forward_ios_rounded,
                          color: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 25,
              ),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: [
              //     RaisedButton(
              //       onPressed: () {
              //         Navigator.push(context,
              //             MaterialPageRoute(builder: (context) => home()));
              //       },
              //       color: Colors.deepPurple,
              //       padding: const EdgeInsets.symmetric(horizontal: 50),
              //       elevation: 2,
              //       shape: RoundedRectangleBorder(
              //           borderRadius: BorderRadius.circular(20)),
              //       child: const Text(
              //         "BACK",
              //         style: const TextStyle(
              //             fontSize: 14,
              //             letterSpacing: 2.2,
              //             color: Colors.white),
              //       ),
              //     )
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
