// ignore_for_file: unused_field, unused_import, file_names, use_key_in_widget_constructors, non_constant_identifier_names, prefer_final_fields, prefer_const_constructors, avoid_print, duplicate_ignore, body_might_complete_normally_nullable, import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:myproject/All_User_Pages/Login_Page/Login_Page.dart';
import 'package:myproject/All_User_Pages/Phone_Auth/Phone_Number.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';
import 'package:myproject/Utils/routes.dart';
import 'package:progress_dialog/progress_dialog.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUp extends StatefulWidget {
  @override
  State<SignUp> createState() => _SignUpState();
}

String password = "";
String eMail = "";
String firstname = "";
String lastname = "";
String? loginid;

class _SignUpState extends State<SignUp> {
  String conformpassword = "";

  bool PassShow = true;
  bool confirmPassShow = true;
  bool clickSignUpButton = false;
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  final _formkey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  _showPassword() {
    setState(() {
      PassShow = !PassShow;
    });
  }

  _confirmShowPass() {
    setState(() {
      confirmPassShow = !confirmPassShow;
    });
  }

  Registration(BuildContext context) async {
    ProgressDialog pr = ProgressDialog(context);
    if (password == conformpassword) {
      try {
        UserCredential userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: eMail, password: password);
        print(userCredential);

        String DriverAuthID = FirebaseAuth.instance.currentUser!.uid;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("DriverAuthID", DriverAuthID);
        await prefs.setString("Firstname", firstname);
        await prefs.setString("Lastname", lastname);
        setState(() {
          clickSignUpButton = true;
        });

        FirebaseFirestore.instance.collection("Driver").doc(DriverAuthID).set({
          'First Name': firstname,
          'Last Name': lastname,
          'Email': eMail,
        });

        await Future.delayed(Duration(seconds: 2));
        pr.hide().whenComplete(() {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (BuildContext context) => Phone_Number(),
            ),
          );
        });

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Registration Successfully and logged in"),
            backgroundColor: Colors.orangeAccent,
          ),
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Password is too weak.",
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              backgroundColor: Colors.blueGrey,
            ),
          );
        } else if (e.code == 'email-already-in-use') {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Account already exist."),
              backgroundColor: Colors.blueGrey,
            ),
          );
        }
      } catch (e) {
        print(e);
      }
    } else {
      print("pass not match");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Password and Confirm Password must be same."),
          backgroundColor: Colors.blueGrey,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(
                height: 70,
              ),
              Text(
                "Sign up",
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.bold,
                  color: Colors.deepPurple,
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 10),
                child: TextFormField(
                  onChanged: (value) {
                    firstname = value;
                  },
                  controller: _firstNameController,
                  decoration: InputDecoration(
                    labelText: "Firstname",
                    hintText: "Enter Firstname",
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Firstname can't be empty";
                    }
                    null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  onChanged: (value) {
                    lastname = value;
                  },
                  controller: _lastNameController,
                  decoration: InputDecoration(
                    labelText: "Lastname",
                    hintText: "Enter Lastname",
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Lastname can't be empty";
                    }
                    null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  onChanged: (value) {
                    eMail = value;
                  },
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: "Email",
                    hintText: "Enter Email",
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Email can't be empty";
                    }
                    null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  onChanged: (value) {
                    password = value;
                  },
                  controller: _passwordController,
                  obscureText: PassShow,
                  decoration: InputDecoration(
                    labelText: "Password",
                    hintText: "Enter Password",
                    suffixIcon: InkWell(
                      onTap: _showPassword,
                      child: Icon(
                        PassShow ? Icons.visibility : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Password can't be empty";
                    }
                    null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                child: TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: confirmPassShow,
                  decoration: InputDecoration(
                    labelText: "Confirm Password",
                    hintText: "Enter Confirm Password",
                    suffixIcon: InkWell(
                      onTap: _confirmShowPass,
                      child: Icon(
                        confirmPassShow
                            ? Icons.visibility
                            : Icons.visibility_off,
                      ),
                    ),
                  ),
                  validator: (String? value) {
                    if (value!.isEmpty) {
                      return "Confirm Password can't be empty.";
                    }
                    null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () async {
                  if (_formkey.currentState!.validate()) {
                    setState(() {
                      eMail = _emailController.text;
                      password = _passwordController.text;
                      conformpassword = _confirmPasswordController.text;
                    });
                    Registration(context);
                  }
                },
                child: AnimatedContainer(
                  duration: Duration(seconds: 2),
                  width: clickSignUpButton ? 50 : 330,
                  height: 50,
                  alignment: Alignment.center,
                  child: clickSignUpButton
                      ? Icon(
                          Icons.done,
                          color: Colors.white,
                        )
                      : Text(
                          "Register",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                  decoration: BoxDecoration(
                      color: Colors.deepPurple,
                      borderRadius:
                          BorderRadius.circular(clickSignUpButton ? 25 : 10)),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              RichText(
                  text: TextSpan(children: [
                TextSpan(
                  text: "Already have account?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
                TextSpan(
                    text: "Login",
                    style: TextStyle(
                      color: Colors.blue,
                      fontSize: 15,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.pushNamed(context, MyRoutes.loginRoute);
                      }),
              ]))
            ],
          ),
        ),
      ),
    ));
  }
}
