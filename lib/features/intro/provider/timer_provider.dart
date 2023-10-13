import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../data/validation_email_and_user_data_request.dart';

class TimerProvider extends ChangeNotifier {
  int _totalSeconds = 90; // Total countdown time in seconds (1 min 30 sec)
  int _seconds = 90; // Current countdown time in seconds
  late Timer _timer;

  int get seconds => _seconds;

  TimerProvider() {
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        _seconds--;
        notifyListeners();
      } else {
        _timer.cancel();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String? stateOfSendingMailLoading = '';
  String? stateOfUserId = '';
  User? stateOfUserData;

  sendMailProvider() async {
    try {
      stateOfSendingMailLoading = null;
      notifyListeners();
      stateOfSendingMailLoading = await ValidationEmailAndUserDataRequest().startTimer();
      stateOfUserData = await ValidationEmailAndUserDataRequest().checkValidation();
    } catch (e) {
      stateOfSendingMailLoading = e.toString();
    }
    notifyListeners();
  }

  checkValidationProvider() async {
    try {
      stateOfUserData = await ValidationEmailAndUserDataRequest().checkValidation();
    } catch (e) {
      stateOfSendingMailLoading = e.toString();
    }
    notifyListeners();
  }

}
