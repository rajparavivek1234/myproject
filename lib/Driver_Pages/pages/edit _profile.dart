// ignore_for_file: camel_case_types, use_key_in_widget_constructors, non_constant_identifier_names, unused_field, prefer_final_fields, prefer_typing_uninitialized_variables, avo, file_names, prefer_const_constructors, body_might_complete_normally_nullable, avoid_print
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:myproject/Driver_Pages/pages/complete_order.dart';
import 'package:myproject/Driver_Pages/pages/profile.dart';
import 'package:myproject/Driver_Pages/pages/vahicle_info.dart';

class edit_profile extends StatefulWidget {
  @override
  _edit_profileState createState() => _edit_profileState();
}

class _edit_profileState extends State<edit_profile> {
  String? pf;
  String? pl;
  String? pa;
  String? pcity;
  String? ps;

  File? _image;
  File? pickedImage;
  bool image_pick = true;

  bool showPassword = false;
  File? imageFile;

  CollectionReference User = FirebaseFirestore.instance.collection('Driver');

  TextEditingController _FirstNamecontroller = TextEditingController();
  TextEditingController _LastNamecontroller = TextEditingController();
  TextEditingController _Addresscontroller = TextEditingController();
  TextEditingController _Citycontroller = TextEditingController();
  TextEditingController _Statecontroller = TextEditingController();

  var firebaseInstance;
  final _formKey = GlobalKey<FormState>();

  void imagePickerOption() {
    Get.bottomSheet(
      SingleChildScrollView(
        child: ClipRRect(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20.0),
            topRight: Radius.circular(20.0),
          ),
          child: Container(
            color: Colors.white,
            height: 210,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Pic Image From",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        pickImage(ImageSource.camera);
                      },
                      icon: const Icon(Icons.camera),
                      label: const Text("CAMERA"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        pickImage(ImageSource.gallery);
                      },
                      icon: const Icon(Icons.image),
                      label: const Text("GALLERY"),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                        ),
                      ),
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.close),
                      label: const Text("CANCEL"),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future cropImage(filePath) async {
    File? croppedFile = await ImageCropper().cropImage(
        sourcePath: filePath,
        aspectRatioPresets: [
          CropAspectRatioPreset.square,
          CropAspectRatioPreset.ratio3x2,
          CropAspectRatioPreset.original,
          CropAspectRatioPreset.ratio4x3,
          CropAspectRatioPreset.ratio16x9,
        ],
        androidUiSettings: const AndroidUiSettings(
          toolbarTitle: 'Crop',
          toolbarColor: Colors.deepPurple,
          toolbarWidgetColor: Colors.white,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ));
    setState(() {
      imageFile = croppedFile;
    });
    if (imageFile != null) {
      image_pick = false;
    }
    print(imageFile);
  }

  Future pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);

      cropImage(photo.path);

      setState(() {
        pickedImage = tempImage;
      });

      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Driver Details",
          style: TextStyle(
              fontSize: 25, fontWeight: FontWeight.w500, color: Colors.white),
        ),
        backgroundColor: Colors.deepPurple,
        elevation: 1,
        leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.pop(context, false);
            }),
      ),
      body: SingleChildScrollView(
        child: Form(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            const SizedBox(
              height: 20,
            ),
            Align(
              alignment: Alignment.center,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(100),
                      ),
                      boxShadow: [
                        BoxShadow(
                          spreadRadius: 4,
                          blurRadius: 20,
                          color: Colors.black.withOpacity(0.1),
                          offset: const Offset(5, 15),
                        )
                      ],
                    ),
                    child: ClipOval(
                      child: imageFile != null
                          ? Image.file(
                              imageFile!,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            )
                          : Image.network(
                              DIMG,
                              width: 130,
                              height: 130,
                              fit: BoxFit.cover,
                            ),
                    ),
                  ),
                  Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 4,
                              color: Theme.of(context).scaffoldBackgroundColor,
                            ),
                            color: Colors.deepPurple,
                          ),
                          child: IconButton(
                              icon: const Icon(Icons.edit, color: Colors.white),
                              onPressed: imagePickerOption)))
                ],
              ),
            ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: TextFormField(
            //     onChanged: (value) {
            //       pf = value;
            //     },
            //     controller: _FirstNamecontroller,
            //     decoration: const InputDecoration(
            //       labelText: "First Name",
            //     ),
            //   ),
            // ),
            // Padding(
            //   padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
            //   child: TextFormField(
            //     onChanged: (value) {
            //       pl = value;
            //     },
            //     controller: _LastNamecontroller,
            //     decoration: const InputDecoration(
            //       labelText: "Last Name ",
            //     ),

            //   ),
            // ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                onChanged: (value) {
                  pa = value;
                },
                controller: _Addresscontroller,
                decoration: const InputDecoration(
                  labelText: "Address ",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "Address Can't be Empty.";
                  }
                  Null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                onChanged: (value) {
                  pcity = value;
                },
                controller: _Citycontroller,
                decoration: const InputDecoration(
                  labelText: "City ",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "City Can't be Empty.";
                  }
                  Null;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
              child: TextFormField(
                onChanged: (value) {
                  ps = value;
                },
                controller: _Statecontroller,
                decoration: const InputDecoration(
                  labelText: "State ",
                ),
                validator: (String? value) {
                  if (value!.isEmpty) {
                    return "State Can't be Empty.";
                  }
                  Null;
                },
              ),
            ),
            SizedBox(
              height: 230,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 27, top: 30),
              child: InkWell(
                onTap: () async {
                  if (_formKey.currentState!.validate()) {
                    await FirebaseFirestore.instance
                        .collection('Driver')
                        .doc(id)
                        .update({
                      // 'First Name': pf,
                      // 'Last Name': pl,
                      'Address': pa,
                      'City': pcity,
                      'State': ps,
                    });

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => profile(),
                      ),
                    );
                  }
                },
                child: AnimatedContainer(
                  duration: const Duration(seconds: 2),
                  width: 330,
                  height: 50,
                  alignment: Alignment.center,
                  child: const Text(
                    "SUBMIT",
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
            ),
          ]),
        ),
      ),
    );
  }
}
