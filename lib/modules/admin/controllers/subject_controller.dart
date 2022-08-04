import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../models/subject_model.dart';

class SubjectController extends GetxController {
  final _isLoading = false.obs;
  get isLoading => this._isLoading.value;

  final subjectsList = <SubjectModel>[].obs;
  final fySubjectsList = <SubjectModel>[].obs;
  final sySubjectsList = <SubjectModel>[].obs;
  final tySubjectsList = <SubjectModel>[].obs;

  final isFyExpanded = false.obs;
  final isSyExpanded = false.obs;
  final isTyExpanded = false.obs;

  @override
  void onInit() {
    getSubjectsList();
    super.onInit();
  }

  void getSubjectsList() async {
    _isLoading.value = true;
    subjectsList.value = [];
    fySubjectsList.value = [];
    sySubjectsList.value = [];
    tySubjectsList.value = [];
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

      subjectsList.forEach((sub) {
        if (sub.year == 'FY') {
          fySubjectsList.add(sub);
        } else if (sub.year == 'SY') {
          sySubjectsList.add(sub);
        } else if (sub.year == 'TY') {
          tySubjectsList.add(sub);
        }
      });
    } catch (e) {
      log(e.toString());
    }

    _isLoading.value = false;
  }
}
