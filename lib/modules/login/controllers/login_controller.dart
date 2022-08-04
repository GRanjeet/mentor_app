import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/models/student_model.dart';
import 'package:mentor_app/modules/admin/models/teacher_model.dart';
import 'package:mentor_app/utils/notification_service.dart';

import '../../../routes/app_routes.dart';
import '../../../utils/app_string.dart';

class LoginController extends GetxController {
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();

  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseFirestore cloud = FirebaseFirestore.instance;

  User? user;
  String userType = "";
  String userId = "";

  final studentData = StudentModel().obs;
  final teacherData = TeacherModel().obs;

  late final LocalNotificationService service;

  @override
  void onInit() {
    // service = LocalNotificationService();
    // service.intialize();
    // loadData();
    super.onInit();
  }

  void loadData() async {
    await service.showNotification(
      id: 0,
      title: 'Notification Title',
      body: 'Some body',
    );
  }

  void loginUser() async {
    if (formKey.currentState!.validate()) {
      isLoading.toggle();

      String email = emailTextController.text;
      String password = passwordTextController.text;
      log('Email : $email');
      log('Password : $password');

      // Comment:  login user using firbase auth.
      try {
        UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: email,
          password: password,
        );
        user = userCredential.user;
        log(user.toString());

        // Comment:  Get the user data object from database using the userId.
        var collection = cloud.collection('users');
        var docSnapshot = await collection.doc(user!.uid).get();

        if (docSnapshot.exists) {
          Map<String, dynamic>? data = docSnapshot.data();
          log('User Data in DB : $data');
          userType = data?['type'];
          userId = data?['id'] ?? '';
        }

        // Comment:  Routes the user accroding to the user type.
        if (userType == AppStrings.admin) Get.toNamed(AppRoutes.adminRoute);
        if (userType == AppStrings.teacher) getTeacherData();
        if (userType == AppStrings.student) getStudentData();

        Get.rawSnackbar(
          title: 'Success',
          message: 'Logged in successfully.',
          backgroundColor: Colors.green,
        );
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          Get.rawSnackbar(
            title: 'Error',
            message: 'No user found for that email.',
            backgroundColor: Colors.red,
          );

          print('No user found for that email.');
        } else if (e.code == 'wrong-password') {
          Get.rawSnackbar(
            title: 'Error',
            message: 'Wrong password provided.',
            backgroundColor: Colors.red,
          );

          print('Wrong password provided.');
        }
      }
    }
    isLoading.value = false;
  }

  void getStudentData() async {
    isLoading.value = true;
    final _db = FirebaseFirestore.instance.collection('students');
    try {
      await _db.doc(userId).get().then((value) {
        var data = value.data() as Map<String, dynamic>;
        log(data.toString());
        studentData.value = StudentModel.fromJson(data);
      });
      Get.toNamed(AppRoutes.studentDetail, arguments: {
        'studentData': studentData.value,
        'isStudent': true,
      });
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }

  void getTeacherData() async {
    isLoading.value = true;
    final _db = FirebaseFirestore.instance.collection('teachers');
    try {
      await _db.doc(userId).get().then((value) {
        var data = value.data() as Map<String, dynamic>;
        log(data.toString());
        teacherData.value = TeacherModel.fromJson(data);
      });
      Get.toNamed(AppRoutes.teacherDetail, arguments: {
        'teacherData': teacherData.value,
        'isTeacher': true,
      });
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }
}
