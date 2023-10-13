import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/user_auth.dart';

export 'package:provider/provider.dart';

class RegisterProvider extends ChangeNotifier {
  String? stateOfLogin = '';
  User? userData ;

  addLogin({required String emailAddress, required String password}) async {
    try {
      stateOfLogin = null;
      notifyListeners();
      if(emailAddress == '' || password == ''){
        stateOfLogin = 'need to enter your data';
        notifyListeners();
      }else {
        stateOfLogin = await UserAuth()
            .loginRequest(emailAddress: emailAddress, password: password);
        userData = await UserAuth()
            .checkUserData(emailAddress: emailAddress);
      }
    } catch (e) {
      stateOfLogin = e.toString();
    }
    notifyListeners();
  }

  String? stateOfRegister = '';

  createAdminAccount(
      {required String emailAddress,
        required String password,
        required String userName,
        required String phoneNumber,
        required String confirmPassword}) async {
    try {
      stateOfRegister = null;
      notifyListeners();
      if(emailAddress == '' || password == '' || userName == '' || phoneNumber == '' || confirmPassword == ''){
        stateOfRegister = 'need to enter your data';
        notifyListeners();
      }else
      if (password != confirmPassword) {
        stateOfRegister = 'password not same';
        notifyListeners();
      } else {
        stateOfRegister = await UserAuth().createAccountRequest(
            emailAddress: emailAddress,
            password: password,
            userName: userName,
            phoneNumber: phoneNumber);
      }
    } catch (e) {
      stateOfRegister = e.toString();
    }
    notifyListeners();
  }

}
