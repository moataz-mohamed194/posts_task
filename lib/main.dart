import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'core/model/user_model.dart';
import 'core/provider/get_un_user_data_provider.dart';
import 'core/string/app_color.dart';
import 'features/home/screens/home_screen.dart';
import 'features/intro/screens/splash_intro_screen.dart';
import 'features/posts/provider/posts_data_provider.dart';
import 'features/register/provider/auth_provider.dart';
import 'features/register/provider/show_password_provider.dart';
import 'features/register/screens/login_screen.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (Platform.isAndroid) {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }else {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform,
    );
  }
  String? uid;

  await FirebaseAuth.instance
      .authStateChanges()
      .listen((user) {
    if (user != null) {
      print(user.email);
      uid = user.uid;
    }
  });

  print(uid);
  runApp(MyApp(uid:uid));
}

class MyApp extends StatelessWidget {
  final String? uid;

  const MyApp({super.key, this.uid});
  Widget _getHomeWidget(GetUnUserDataProvider auth) {
    if (uid ==null&& uid =='') return LoginScreen();
print('_getHomeWidget uid:$uid');
    return FutureBuilder<UserModel?>(
      future: auth.getFullDoctorDataProvider(uid: uid??''),
      builder: (BuildContext context, AsyncSnapshot<UserModel?> snapshot) {
        print('snapshot.connectionState:${snapshot.connectionState}');
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const SplashIntroScreen();
        }
        return (snapshot.data != null)
            ? HomeScreen(uid: uid??'',)
            : LoginScreen();
      },
    );
  }
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<ShowPasswordProvider>(
          create: (_) => ShowPasswordProvider(),
        ),
        ChangeNotifierProvider<RegisterProvider>(
          create: (_) => RegisterProvider(),
        ),
        ChangeNotifierProvider<GetUnUserDataProvider>(
          create: (_) => GetUnUserDataProvider(),
        ),
        ChangeNotifierProvider<PostsDataProvider>(
          create: (_) => PostsDataProvider(),
        ),
      ],
      child:Consumer<GetUnUserDataProvider>(
        builder: (BuildContext context, GetUnUserDataProvider auth, Widget? child) {
      return MaterialApp(
        title: 'Flutter Demo',
        // debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColor.mainColor,primary: AppColor.mainColor, background: Colors.white),
          useMaterial3: true,
        ),
        home:_getHomeWidget(auth)

      );}),

    );
  }
}