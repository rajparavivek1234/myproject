// ignore_for_file: camel_case_types, must_be_immutable, non_constant_identifier_names, annotate_overrides, prefer_const_constructors, avoid_print, unused_import, unnecessary_brace_in_string_interps, use_key_in_widget_constructors, prefer_final_fields, unused_element

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:myproject/Driver_Pages/pages/home.dart';
import 'package:myproject/Driver_Pages/pages/request_list.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';
import 'package:myproject/Driver_Pages/pages/verifydelivery.dart';
import 'package:url_launcher/url_launcher.dart';

class accept_request extends StatelessWidget {
  String _url = "";
  Widget build(BuildContext context) {
    CollectionReference users = FirebaseFirestore.instance
        .collection('Driver')
        .doc(id)
        .collection('Request');
    return Scaffold(
      appBar: AppBar(
        title: Text("Ride Request"),
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => home()));
            }),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc(rid).get(),
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
                      height: 5,
                    ),
                    Divider(),
                    SizedBox(
                      height: 5,
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
                    SizedBox(
                      height: 10,
                    ),
                    Divider(),
                    SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        InkWell(
                          onTap: () {
                            _url =
                                "tel:${data['Receiver Code Digit']} ${data['Receiver Mob. No.']}";
                            _launchURL();
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 2),
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.call,
                              color: Colors.white,
                              size: 30,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.green,
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            _url = "smsto:${[
                              'Receiver Code Digit'
                            ]} ${data['Receiver Mob. No.']}";
                            _launchURL();
                          },
                          child: AnimatedContainer(
                            duration: Duration(seconds: 2),
                            width: 50,
                            height: 50,
                            alignment: Alignment.center,
                            child: Icon(
                              Icons.message,
                              color: Colors.white,
                              size: 30,
                            ),
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(25)),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    //   children: [
                    //     InkWell(
                    //       onTap: () async {},
                    //       child: AnimatedContainer(
                    //         duration: Duration(seconds: 2),
                    //         width: 150,
                    //         height: 40,
                    //         alignment: Alignment.center,
                    //         child: Text("Reciving point",
                    //             style: TextStyle(
                    //                 fontSize: 14,
                    //                 letterSpacing: 2.2,
                    //                 color: Colors.white)),
                    //         decoration: BoxDecoration(
                    //             color: Colors.deepPurple,
                    //             borderRadius: BorderRadius.circular(30)),
                    //       ),
                    //     ),
                    //     InkWell(
                    //       onTap: () async {},
                    //       child: AnimatedContainer(
                    //         duration: Duration(seconds: 2),
                    //         width: 150,
                    //         height: 40,
                    //         alignment: Alignment.center,
                    //         child: Text("Delivery point",
                    //             style: TextStyle(
                    //                 fontSize: 14,
                    //                 letterSpacing: 2.2,
                    //                 color: Colors.white)),
                    //         decoration: BoxDecoration(
                    //             color: Colors.deepPurple,
                    //             borderRadius: BorderRadius.circular(30)),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                    SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => verifydelivery(
                                  phone: data['Receiver Mob. No.'],
                                  codeDigits: data['Receiver Code Digit'])),
                        );
                      },
                      child: AnimatedContainer(
                        duration: Duration(seconds: 2),
                        width: 330,
                        height: 50,
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [
                            Text(
                              "Verify Delivery",
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            Icon(
                              Icons.arrow_forward_ios_rounded,
                              color: Colors.white,
                              size: 30,
                            ),
                          ],
                        ),
                        decoration: BoxDecoration(
                            color: Colors.red,
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

  void _launchURL() async {
    if (!await launch(_url)) throw 'Could Not Lounch $_url';
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


// ignore_for_file: file_names
// // ignore_for_file: deprecated_member_use, prefer_const_constructors, camel_case_types, must_be_immutable, file_names, use_key_in_widget_constructors, avoid_print, unnecessary_brace_in_string_interps, annotate_overrides, unused_local_variable, unused_element

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:testing/pages/driver_info.dart';
// import 'package:testing/pages/vahicle_info.dart';
// import 'package:url_launcher/url_launcher.dart';

// String? aid;
// String? did;
// String? image;
// String? fn;
// String? ln;
// String? vt;
// String? vy;
// String? vn;
// String? vrcbook;
// String? vpuc;
// String? vip;
// String? vrd;

// class accept_request extends StatelessWidget {
//   Widget build(BuildContext context) {
//     CollectionReference vahicle = FirebaseFirestore.instance.collection('');
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("User Detail"),
//       ),
//       body: FutureBuilder<DocumentSnapshot>(
//         future: vahicle.doc('EdpKWJjuQeLMfgdnKilR').get(),
//         builder:
//             (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
//           if (snapshot.connectionState == ConnectionState.done) {
//             Map<String, dynamic> data =
//                 snapshot.data!.data() as Map<String, dynamic>;

//             return Material(
//               child: Center(
//                 child: Column(
//                   children: [
//                     SizedBox(
//                       height: 30,
//                     ),
//                     GestureDetector(
//                       onTap: () async {
//                         did = "${data['Driver Id']}";
//                         image = "${data['Vehicle Image']}";
//                         fn = "${data['First Name']}";
//                         ln = "${data['Last Name']}";
//                         vt = "${data['Vehicle Name']}";
//                         vy = "${data['Year of Model']}";
//                         vn = "${data['Vehicle No']}";
//                         vrcbook = "${data['RC Book']}";
//                         vpuc = "${data['PUC']}";
//                         vip = "${data['Insurance Policy']}";
//                         vrd = "${data['Ragistration Document']}";
//                       },
//                     ),
//                   ],
//                 ),
//               ),
//             );
//           }

//           return Center(
//             child: CircularProgressIndicator(),
//           );
//         },
//       ),
//     );
//   }
// }
