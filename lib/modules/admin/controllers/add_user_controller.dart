import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../utils/app_string.dart';

class AddUserController extends GetxController {
  final isTeacher = false.obs;
  final isLoading = false.obs;

  final fullNameTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final classTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  @override
  void onInit() {
    isTeacher.value = Get.arguments;
    log('isTeacher : ${isTeacher.value}');
    super.onInit();
  }

  // Comment:  Add user to the database according to the give type.
  void addUser() async {
    isLoading.value = true;

    User? user;
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    CollectionReference collection = FirebaseFirestore.instance.collection(
      isTeacher.value ? 'teachers' : 'students',
    );
    // Comment:  1st Create the given user in the firebase auth.
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailTextController.text.trim(),
        password: passwordTextController.text.trim(),
      );

      log('User Created : ${userCredential.toString()}');

      user = userCredential.user;

      // Comment:  Set the profile data.

      Map<String, dynamic> profileData = {
        "id": user!.uid,
        "email": emailTextController.text.trim(),
        "type": isTeacher.value ? AppStrings.teacher : AppStrings.student
      };

      // Comment:  Set the user data.

      Map<String, dynamic> userData = {
        "id": user.uid,
        "fullName": fullNameTextController.text.trim(),
        "phone": phoneTextController.text.trim(),
        "email": emailTextController.text.trim(),
        if (!isTeacher.value) "address": addressTextController.text.trim(),
        if (!isTeacher.value) "year": classTextController.text.trim(),
      };

      log('User Data : $userData');

      // Comment:  2nd Add the user data to the database according to the type.
      await users
          .doc(user.uid)
          .set(profileData)
          .then((value) => log("Profile Added"))
          .catchError((error) => log("Failed to add profile: $error"));

      await collection
          .doc(user.uid)
          .set(userData)
          .then((value) => log("User Added"))
          .catchError((error) => log("Failed to add user: $error"));

      Get.back();

      Get.rawSnackbar(
          title: 'Success',
          message:
              "${isTeacher.value ? AppStrings.teacher : AppStrings.student} created successfully",
          backgroundColor: Colors.green);
      addSubjects(user);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.rawSnackbar(
          title: 'Error',
          message: 'The password provided is too weak.',
        );
      } else if (e.code == 'email-already-in-use') {
        Get.rawSnackbar(
          title: 'Error',
          message: 'The account already exists for that email.',
        );
      }
    } catch (e) {
      log(e.toString());
      Get.rawSnackbar(
        title: 'Error',
        message: 'Something went wrong!',
      );
    }
    isLoading.value = false;
  }

  void addSubjects(User user) async {
    CollectionReference collection = FirebaseFirestore.instance.collection('students');
    List<Subject> fySubData = [
      Subject(code: 'FY0101', name: 'Maths-1', year: 'FY', sem: '1'),
      Subject(code: 'FY0102', name: 'English-1', year: 'FY', sem: '1'),
      Subject(code: 'FY0201', name: 'Science-1', year: 'FY', sem: '2'),
      Subject(code: 'FY0202', name: 'History-1', year: 'FY', sem: '2'),
    ];
    List<Subject> sySubData = [
      Subject(code: 'SY0401', name: 'Maths-2', year: 'SY', sem: '4'),
      Subject(code: 'SY0402', name: 'English-2', year: 'SY', sem: '4'),
      Subject(code: 'SY0501', name: 'Science-2', year: 'SY', sem: '5'),
      Subject(code: 'SY0502', name: 'History-2', year: 'SY', sem: '5'),
    ];
    List<Subject> tySubData = [
      Subject(code: 'TY0501', name: 'Maths-3', year: 'TY', sem: '5'),
      Subject(code: 'TY0502', name: 'English-3', year: 'TY', sem: '5'),
      Subject(code: 'TY0601', name: 'Science-3', year: 'TY', sem: '6'),
      Subject(code: 'TY0602', name: 'History-3', year: 'TY', sem: '6'),
    ];
    int i;
    for (i = 0; i < fySubData.length; i++) {
      Map<String, dynamic> data = fySubData[i].toMap();
      await collection
          .doc(user.uid)
          .collection('subjects')
          .doc()
          .set(data)
          .then((value) => log("Subjects Added"))
          .catchError((error) => log("Failed to add subjects : $error"));
    }
  }
}

// List yourItemList = [];
// for (int i = 0; i < itemName.length; i++)
//   yourItemList.add({
//     "name": itemName.toList()[i],
//     "price": rate.toList()[i],
//     "quantity": quantity.toList()[i]
//   });

// _fireStore.collection('notifyseller').document().updateData({
//   'Customer': userName,
//   "address": controller.text,
//   "mobile": mobileNumber,
//   "Item": FieldValue.arrayUnion(yourItemList),
// });

class Subject {
  String? code;
  String? name;
  String? year;
  String? sem;

  Subject({
    this.code,
    this.name,
    this.year,
    this.sem,
  });

  Map<String, dynamic> toMap() {
    return {
      'code': code,
      'name': name,
      'year': year,
      'sem': sem,
    };
  }

  factory Subject.fromMap(Map<String, dynamic> map) {
    return Subject(
      code: map['code'],
      name: map['name'],
      year: map['year'],
      sem: map['sem'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Subject.fromJson(String source) => Subject.fromMap(json.decode(source));
}
