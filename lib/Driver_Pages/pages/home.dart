// ignore_for_file: camel_case_types, use_key_in_widget_constructors, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, duplicate_ignore, avoid_print, import_of_legacy_library_into_null_safe, non_constant_identifier_names

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/google_sign_in/google_sign_in.dart';
import 'package:myproject/Driver_Pages/drawer/DrawerHeader.dart';
import 'package:myproject/Driver_Pages/drawer/DrawerItem.dart';
import 'package:myproject/Driver_Pages/pages/accept_request.dart';
import 'package:myproject/Driver_Pages/pages/complete_order.dart';
import 'package:myproject/Driver_Pages/pages/driver_home.dart';
import 'package:myproject/Driver_Pages/pages/request_details.dart';
import 'package:myproject/Driver_Pages/pages/request_list.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class home extends StatefulWidget {
  @override
  _homeState createState() => _homeState();
}

class _homeState extends State<home> {
  // int _currentState = 0;

  // final tabs = [home_page(), request_list()];

  // void _onItemTapped(int index) {
  //   setState(() {
  //     _currentState = index;
  //   });
  // }

  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text(
        "Cancel",
        style: TextStyle(color: Colors.deepPurple),
      ),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
      child: Text(
        "Continue",
        style: TextStyle(color: Colors.deepPurple),
      ),
      onPressed: () async {
        print(isGoogle);
        if (isGoogle == null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove("isDetailsAdded");
          await prefs.remove("isMobileAdded");
          await prefs.remove("Firstname");
          await prefs.remove("Lastname");
          FirebaseAuth.instance.signOut();
          Navigator.pushNamed(context, MyRoutes.initialRoute);
        } else if (isGoogle != null) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.remove("isDetailsAdded");
          await prefs.remove("isMobileAdded");
          await prefs.remove("Firstname");
          await prefs.remove("Lastname");
          final provider =
              Provider.of<GoogleSignInProvider>(context, listen: false);
          provider.Logout();
          Navigator.pushNamed(context, MyRoutes.initialRoute);
        }
      },
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Logout"),
      content: Text("Are you sure?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  String? MyVehicleId;
  String? MyDriverID;
  String? isGoogle;
  void getUserCredentioals() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      MyDriverID = prefs.getString("DriverAuthID");
      id = MyDriverID;
      isGoogle = prefs.getString("isGoogle");
    });
  }

  @override
  void initState() {
    // ignore: todo
    // TODO: implement initState
    super.initState();
    getUserCredentioals();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("E-Transportation "),
        //backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        elevation: 1,
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            createDrawerHeader(),
            Divider(),
            createDrawerBodyItem(
              icon: Icons.home,
              text: 'Home',
              onTap: () =>
                  Navigator.pushReplacementNamed(context, MyRoutes.homeRoute),
            ),
            createDrawerBodyItem(
              icon: Icons.account_circle,
              text: 'Profile',
              onTap: () => Navigator.pushReplacementNamed(
                  context, MyRoutes.profileRoute),
            ),

            createDrawerBodyItem(
              icon: Icons.document_scanner,
              text: 'Driver Document',
              onTap: () => Navigator.pushReplacementNamed(
                  context, MyRoutes.d_update_documentRoute),
            ),
            //Divider(),
            createDrawerBodyItem(
              icon: Icons.document_scanner,
              text: 'Vehicle Document',
              onTap: () => Navigator.pushReplacementNamed(
                  context, MyRoutes.v_update_documentRoute),
            ),
            createDrawerBodyItem(
              icon: Icons.wallet_giftcard,
              text: 'Earning',
              onTap: () => Navigator.pushReplacementNamed(
                  context, MyRoutes.earningRoute),
            ),
            createDrawerBodyItem(
              icon: Icons.history,
              text: 'History',
              onTap: () => Navigator.pushReplacementNamed(
                  context, MyRoutes.historyRoute),
            ),
            createDrawerBodyItem(
              icon: Icons.add_box_rounded,
              text: 'About us',
              onTap: () => Navigator.pushReplacementNamed(
                  context, MyRoutes.about_usRoute),
            ),
            createDrawerBodyItem(
              icon: Icons.contact_page,
              text: 'Contact Us',
              onTap: () => Navigator.pushReplacementNamed(
                  context, MyRoutes.contact_usRoute),
            ),
            createDrawerBodyItem(
                icon: Icons.logout,
                text: 'Log Out',
                onTap: () {
                  showAlertDialog(context);
                }),
            // createDrawerBodyItem(
            //   icon: Icons.exit_to_app,
            //   text: 'Logout',
            //   onTap: () => showAlertDialog(context),
            // ),
            SizedBox(
              height: 250,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: ListTile(
                title: Text('App version 1.0.0'),
                onTap: () {},
              ),
            ),
          ],
        ),
      ),
      //     child: Container(
      //   color: Colors.blueAccent,
      //   child: ListView(
      //     padding: EdgeInsets.zero,
      //     children: <Widget>[
      //       const SizedBox(
      //         height: 48,
      //       ),
      //       DrawerHeader(
      //         child: Row(
      //           children: [
      //             Icon(
      //               Icons.person,
      //               color: Colors.red,
      //               size: 50,
      //             ),
      //             SizedBox(
      //               width: 20,
      //             ),
      //             Text(
      //               "Name",
      //               style: TextStyle(
      //                 color: Colors.amber,
      //                 fontSize: 35,
      //               ),
      //             ),
      //           ],
      //         ),
      //         decoration: BoxDecoration(color: Colors.black),
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.person),
      //         title: Text("Profile"),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => profile()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.car_rental),
      //         title: Text("Update Vahicle Document"),
      //         onTap: () {
      //           Navigator.push(
      //               context,
      //               MaterialPageRoute(
      //                   builder: (context) => v_update_document()));
      //         },
      //       ),
      //       ListTile(
      //           leading: Icon(Icons.document_scanner),
      //           title: Text("Update Driver Document"),
      //           onTap: () {
      //             Navigator.push(
      //                 context,
      //                 MaterialPageRoute(
      //                     builder: (context) => d_update_document()));
      //           }),
      //       ListTile(
      //         leading: Icon(Icons.wallet_travel),
      //         title: Text("Earning"),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => earning()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.history),
      //         title: Text("History"),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => history()));
      //         },
      //       ),
      //       // ListTile(
      //       //   leading: Icon(Icons.settings),
      //       //   title: Text("Setting"),
      //       // ),
      //       ListTile(
      //         leading: Icon(Icons.connect_without_contact_sharp),
      //         title: Text("Contect us"),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => contact_us()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.adb_rounded),
      //         title: Text("About us"),
      //         onTap: () {
      //           Navigator.push(context,
      //               MaterialPageRoute(builder: (context) => about_us()));
      //         },
      //       ),
      //       ListTile(
      //         leading: Icon(Icons.logout),
      //         title: Text("Log Out"),
      //       ),
      //     ],
      //   ),
      // )),

      body: home_page(),

      //tabs[_currentState],

      // //     Center(
      // //   child: _widgetOptions.elementAt(_selectedIndex),
      // // ),
      // bottomNavigationBar: BottomNavigationBar(
      //   items: const <BottomNavigationBarItem>[
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //       // backgroundColor: Colors.red,
      //     ),
      //     BottomNavigationBarItem(
      //       icon: Icon(Icons.business),
      //       label: 'Request',
      //       // backgroundColor: Colors.green,
      //     ),
      //   ],
      //   currentIndex: _currentState,
      //   // selectedItemColor: Colors.amber[800],
      //   onTap: _onItemTapped,
      // ),
    );
  }
}
