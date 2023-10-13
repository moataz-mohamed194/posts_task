
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../../core/model/user_model.dart';
import '../data/patients_data.dart';
import '../model/social_media_model.dart';

export 'package:provider/provider.dart';

class GetUnUserDataProvider extends ChangeNotifier {

  UserModel? stateOfGetDoctorMediaData;
  String? errorMessageGetDoctorMedia = '';
  bool? stateOfLoadingDoctorMedia = false;
  Future<UserModel?> getFullDoctorDataProvider({required String uid}) async {
    try {

      stateOfGetDoctorMediaData =
      await PatientsData().getDoctorDataRequest(uid: uid);
      return stateOfGetDoctorMediaData;

    } catch (e) {
      print('error:$e');
      return null;
    }
  }

  logOutProvider() async {
    await PatientsData().signOut();

  }
}
