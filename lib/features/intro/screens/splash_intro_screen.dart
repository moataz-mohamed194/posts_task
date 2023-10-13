import 'dart:async';

import 'package:flutter/material.dart';
import '../../../core/provider/get_un_user_data_provider.dart';
import '../../../core/string/app_images.dart';
import '../../home/screens/home_screen.dart';
import '../../register/screens/login_screen.dart';

class SplashIntroScreen extends StatefulWidget {
  final String? uid;
  const SplashIntroScreen({super.key, this.uid});

  @override
  State<StatefulWidget> createState() {
    return _SplashIntroScreen();
  }
}
class _SplashIntroScreen extends State<SplashIntroScreen>{
  @override
  // void initState() {
  //   // TODO: implement initState
  //   super.initState();
  //   Timer(const Duration(seconds: 1), () async {
  //     Navigator.pushReplacement(
  //       context,
  //       MaterialPageRoute(
  //         builder: (context) => widget.uid !=null&& widget.uid !='' ? HomeScreen(
  //           uid: widget.uid??'',) : LoginScreen(),
  //       ),
  //     );
  //   });
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        alignment: Alignment.center,
        margin: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppImages.iconLogo),
          ],
        ),
      ),
    );
  }
}
