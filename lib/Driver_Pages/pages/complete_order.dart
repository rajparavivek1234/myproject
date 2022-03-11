// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, annotate_overrides, prefer_const_constructors, avoid_print, use_key_in_widget_constructors, unused_import, unnecessary_brace_in_string_interps

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:intl/intl.dart';
import 'package:myproject/Driver_Pages/drawer/DrawerHeader.dart';
import 'package:myproject/Driver_Pages/pages/driver_home.dart';
import 'package:myproject/Driver_Pages/pages/home.dart';
import 'package:myproject/Driver_Pages/pages/mapview.dart';
import 'package:myproject/Driver_Pages/pages/request_list.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'request_details.dart';

class complete_order extends StatefulWidget {
  String rid = "";
  complete_order({
    Key? key,
    required this.rid,
  }) : super(key: key);
  @override
  State<complete_order> createState() => _complete_orderState();
}

String? coid;
String FN = "";
String LN = "";
String DIMG = "";
String PaymentMethod = "";
String PaymentStatus = "";

class _complete_orderState extends State<complete_order> {
  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getdeails();
  }

  @override
  Widget build(BuildContext context) {
    var now = new DateTime.now();
    var MONTHS = [
      "Jan",
      "Feb",
      "Mar",
      "Apr",
      "May",
      "Jun",
      "Jul",
      "Aug",
      "Sep",
      "Oct",
      "Nov",
      "Dec"
    ];
    var formatter = new DateFormat('dd-MM-yyyy');
    String date = now.day.toString() +
        " " +
        MONTHS[now.month - 1] +
        " " +
        now.year.toString() +
        ", " +
        now.hour.toString() +
        ":" +
        now.minute.toString() +
        ":" +
        now.second.toString();

    CollectionReference users = FirebaseFirestore.instance
        .collection('Driver')
        .doc(id)
        .collection('Request');

// Paymentdetails() {
//   if (PaymentMethod == "COD") {
//     Text(
//       "First Receive Payment Then Handover Delivery And Press Complete Button",
//       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     );
//   } else if (PaymentMethod == "Online" && PaymentStatus == "Pending") {
//     Text(
//       "Online Payment Is Pending. Ask For Complete Payment",
//       style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//     );
//   }
// }

    return Scaffold(
      appBar: AppBar(
        title: Text("Order Complete"),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(widget.rid).get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;

            return Material(
              child: Center(
                child: Column(
                  children: [
                    SizedBox(
                      height: 30,
                    ),
                    GestureDetector(
                      onTap: () {
                        showDialogFunc(context, data["Profile pic"]);
                      },
                      child: Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                border:
                                    Border.all(color: Colors.white, width: 5),
                                borderRadius: const BorderRadius.all(
                                  Radius.circular(100),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    spreadRadius: 4,
                                    blurRadius: 20,
                                    color: Colors.black.withOpacity(0.1),
                                    offset: Offset(5, 15),
                                  )
                                ],
                              ),
                              child: ClipOval(
                                child: Image.network(
                                  data["Profile pic"],
                                  width: 130,
                                  height: 130,
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Name : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${data['First Name']} ${data['Last Name']}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "From : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${data['Starting Point']}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "To : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${data['Destination Point']}",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Distance : ",
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                          "${data['Distance']} Km",
                          style: TextStyle(fontSize: 20),
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    // Text(
                    //   "Total Cost : ${data['Total Cost']}",
                    //   style:
                    //       TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    // ),
                    // Divider(),
                    // SizedBox(
                    //   height: 10,
                    // ),
                    Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              child: Text(
                                "* Warning *",
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 350,
                              child: Text(
                                "1. If Payment Method is Cash On Delivery Then First Receive Payment Then Handover Delivery And Press Complete Button",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Container(
                              width: 350,
                              child: Text(
                                "2. If Payment Method Is Online Payment And Online Payment Is Pending. Ask For Complete Payment",
                                style: TextStyle(
                                  fontSize: 10,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    Divider(),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        //step = "0";
                        if ((PaymentMethod == "Online" &&
                            PaymentStatus == "Pending")) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content:
                                  Text("Payment Is Not Complete By Customer"),
                              backgroundColor: Colors.black,
                            ),
                          );
                        } else {
                          await FirebaseFirestore.instance
                              .collection('History')
                              .add({
                            'User ID': "${data['UserID']}",
                            'Driver ID': id,
                            'Driver Img': DIMG,
                            'User Img': "${data['Profile pic']}",
                            'User First Name': "${data['First Name']}",
                            'User Last Name': "${data['Last Name']}",
                            'Driver First Name': FN,
                            'Driver Last Name': LN,
                            'Starting Point': "${data['Starting Point']}",
                            'Destination Point': "${data['Destination Point']}",
                            'Distance': "${data['Distance']}",
                            'Total Cost': TotalPrice,
                          });

                          await FirebaseFirestore.instance
                              .collection('vehicle')
                              .doc(vid)
                              .update({
                            'On Trip': 'No',
                          });

                          await FirebaseFirestore.instance
                              .collection('Driver')
                              .doc(id)
                              .collection("Request")
                              .doc(widget.rid)
                              .update({
                            'On Trip': 'No',
                            'Order Completed': "Yes",
                          });

                          await FirebaseFirestore.instance
                              .collection('Users')
                              .doc(data['UserID'])
                              .collection('MyOrders')
                              .doc(oid)
                              .update({
                            'Status': 'Complete',
                            'Order Complete Date': date,
                            'Payment Method': PaymentMethod,
                            'Payment Status': "Complete",
                          });

                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => home()),
                          );
                        }
                      },
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        width: 330,
                        height: 50,
                        alignment: Alignment.center,
                        child: Text(
                          "COMPLETE",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        decoration: BoxDecoration(
                            color: Colors.deepPurple,
                            borderRadius: BorderRadius.circular(25)),
                      ),
                    ),
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
    );
  }
}

showDialogFunc(context, img) {
  return showDialog(
    context: context,
    builder: (context) {
      return Center(
        child: Material(
          type: MaterialType.transparency,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
            padding: EdgeInsets.all(5),
            height: 400,
            width: MediaQuery.of(context).size.width * 0.85,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: 10,
                ),
                Text(
                  "Vehicle Image",
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  height: 2,
                  width: 500,
                  color: Colors.black,
                ),
                SizedBox(
                  height: 20,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.network(
                    img,
                    width: 300,
                    height: 300,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      );
    },
  );
}

Future<void> getdeails() async {
  //CollectionReference users = FirebaseFirestore.instance.collection('Driver');
  DocumentSnapshot documentSnapshot1 =
      await FirebaseFirestore.instance.collection('Driver').doc(id).get();

  FN = documentSnapshot1['First Name'];
  print("first name ===== ${FN}");
  LN = documentSnapshot1['Last Name'];
  print("last name ===== ${LN}");
  DIMG = documentSnapshot1["Driver Image"];
  print("Driver image ===== ${DIMG}");

  DocumentSnapshot documentSnapshot2 = await FirebaseFirestore.instance
      .collection('Driver')
      .doc(id)
      .collection("Request")
      .doc(rid)
      .get();

  PaymentMethod = documentSnapshot2['Payment Method'];
  print("Payment Method ===== ${PaymentMethod}");
  PaymentStatus = documentSnapshot2['Payment Status'];
  print("Payment Status ===== ${PaymentStatus}");
}
