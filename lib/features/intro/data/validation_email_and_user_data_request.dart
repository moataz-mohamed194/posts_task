import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ValidationEmailAndUserDataRequest {


  Future<String> startTimer() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user != null && !user.emailVerified) {
        await user.sendEmailVerification();
        return 'success';
      } else {
        return 'User is already verified or not signed in.';
      }
    } catch (error) {
    return 'Error sending verification email: $error';
    }
  }

  Future<User?> checkValidation() async {
      User? user = FirebaseAuth.instance.currentUser;
      return user;
  }

}
