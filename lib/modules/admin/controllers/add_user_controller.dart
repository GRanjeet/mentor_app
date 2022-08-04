import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mentor_app/modules/admin/models/subject_model.dart';
import 'package:mentor_app/modules/admin/models/teacher_model.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

import '../../../utils/app_string.dart';

class AddUserController extends GetxController {
  final isTeacher = false.obs;
  final isLoading = false.obs;

  final formKey = GlobalKey<FormState>();
  final fullNameTextController = TextEditingController();
  final phoneTextController = TextEditingController();
  final addressTextController = TextEditingController();
  final classTextController = TextEditingController();
  final teacherTextController = TextEditingController();
  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final isStudyAdvisor = false.obs;

  final teachersList = <TeacherModel>[].obs;
  final subjectsList = <SubjectModel>[].obs;
  final classList = ['FY', 'SY', 'TY'];
  final selectedClass = ''.obs;
  final selectedTeacher = TeacherModel().obs;
  final selectedSubject = SubjectModel().obs;
  final selectedSubjectList = <SubjectModel>[].obs;

  @override
  void onInit() {
    isTeacher.value = Get.arguments;
    log('isTeacher : ${isTeacher.value}');
    getSubjectsList();
    super.onInit();
  }

  void showMultiSelect(BuildContext context) async {
    var items = subjectsList.map((sub) => MultiSelectItem<SubjectModel>(sub, sub.name!)).toList();
    await showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return MultiSelectBottomSheet<SubjectModel>(
          items: items,
          initialChildSize: 0.75,
          maxChildSize: 1.0,
          initialValue: selectedSubjectList,
          onConfirm: (values) {
            selectedSubjectList.value = values;
          },
        );
      },
    );
  }

  // Comment:  Add user to the database according to the give type.
  void addUser() async {
    if (formKey.currentState!.validate()) {
      if (selectedSubjectList.length == 0 && !isTeacher.value) {
        Get.rawSnackbar(message: 'Please select at least 1 Subject to comtinue');
      } else {
        isLoading.value = true;

        User? user;
        CollectionReference users = FirebaseFirestore.instance.collection('users');
        CollectionReference collection = FirebaseFirestore.instance.collection(
          isTeacher.value ? 'teachers' : 'students',
        );
        // Comment:  1st Create the given user in the firebase auth.
        try {
          UserCredential userCredential =
              await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailTextController.text.trim(),
            password: passwordTextController.text.trim(),
          );

          log('User Created : ${userCredential.toString()}');

          user = userCredential.user;

          // Comment:  Set the profile data.

          Map<String, dynamic> profileData = {
            "id": user?.uid,
            "email": emailTextController.text.trim(),
            "type": isTeacher.value ? AppStrings.teacher : AppStrings.student
          };

          // Comment:  Set the user data.
          List<String> subsIds = [];
          selectedSubjectList.forEach((element) {
            subsIds.add(element.code!);
          });

          Map<String, dynamic> userData = {
            "id": user?.uid,
            "fullName": fullNameTextController.text.trim(),
            "phone": phoneTextController.text.trim(),
            "email": emailTextController.text.trim(),
            if (isTeacher.value) "isAdvisor": isStudyAdvisor.value,
            if (isTeacher.value && !isStudyAdvisor.value) "subject": selectedSubject.value.toJson(),
            if (!isTeacher.value) "subjectsId": subsIds,
            if (!isTeacher.value) "address": addressTextController.text,
            if (!isTeacher.value) "year": selectedClass.value,
            if (!isTeacher.value) "attendence": [],
            if (!isTeacher.value) "exams": [],
          };

          log('User Data : $userData');

          //  Comment:  2nd Add the user data to the database according to the type.

          await users
              .doc(user?.uid)
              .set(profileData)
              .then((value) => log("Profile Added"))
              .catchError((error) => log("Failed to add profile: $error"));

          await collection
              .doc(user?.uid)
              .set(userData)
              .then((value) => log("User Added"))
              .catchError((error) => log("Failed to add user: $error"));

          if (!isTeacher.value) {
            for (int i = 0; i < selectedSubjectList.length; i++) {
              Map<String, dynamic> data = selectedSubjectList[i].toJson();
              await collection
                  .doc(user?.uid)
                  .collection('subjects')
                  .doc()
                  .set(data)
                  .then((value) => log("Subjects Added"))
                  .catchError((error) => log("Failed to add subjects : $error"));
            }
          }

          Get.back();

          Get.rawSnackbar(
              title: 'Success',
              message:
                  "${isTeacher.value ? AppStrings.teacher : AppStrings.student} created successfully",
              backgroundColor: Colors.green);
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
    }
  }

  void getTeachersList() async {
    isLoading.value = true;
    log('Getting teachers list...');
    final _db = FirebaseFirestore.instance.collection('teachers');
    await _db.get().then((value) {
      value.docs.forEach((doc) {
        var data = doc.data();
        teachersList.add(TeacherModel.fromJson(data));
      });
    });
    isLoading.value = false;
  }

  void getSubjectsList() async {
    isLoading.value = true;
    log('Getting subjects list...');
    final _db = FirebaseFirestore.instance.collection('subjects');
    try {
      await _db.get().then((value) {
        value.docs.forEach((doc) {
          var data = doc.data();
          log(jsonEncode(data).toString());
          subjectsList.add(SubjectModel.fromJson(data));
        });
      });
    } catch (e) {
      log(e.toString());
    }
    isLoading.value = false;
  }
}
