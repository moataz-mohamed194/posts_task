import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import '../../../core/string/app_color.dart';
import '../../../core/widgets/alert.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../home/screens/home_screen.dart';
import '../provider/auth_provider.dart';
import '../provider/show_password_provider.dart';
import 'register_screen.dart';

class LoginScreen extends StatelessWidget {
  TextEditingController emailController = TextEditingController(text: kDebugMode?'moataz@test.com':'');
  TextEditingController passwordController = TextEditingController(text: kDebugMode?'password':'');

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.greyColor,
      appBar: AppBar(

        backgroundColor: AppColor.greyColor,
        elevation: 0,
        leading: const SizedBox(),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child:  Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            // mainAxisSize: MainAxisSize.max,
            children: [
              Expanded(
                flex: 8,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Welcome',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFieldWidget(
                        keyboardType: TextInputType.text,
                        hintText: 'Enter Username',
                        controler: emailController,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Consumer<ShowPasswordProvider>(
                          builder: (context, cart, child) {
                        return TextFieldWidget(
                          hintText: 'Password',
                          controler: passwordController,
                          maxLines: 1,
                          rightWidget: GestureDetector(
                            child: cart.state == true
                                ? const Icon(
                                    CupertinoIcons.eye,
                                    color: AppColor.mainTextColor,
                                  )
                                : const Icon(
                                    CupertinoIcons.eye_slash,
                                    color: AppColor.mainTextColor,
                                  ),
                            onTap: () {
                              cart.changeState();
                            },
                          ),
                          obscureText: cart.state,
                        );
                      }),
                      const SizedBox(
                        height: 15,
                      ),

                    ],
                  ),
                ),
              ),
Spacer(),
              Consumer<RegisterProvider>(
                  builder: (context, cart, child) {
                    return cart.stateOfLogin!=null? ButtonWidget(
                      textColor: Colors.white,
                      boarderColor: AppColor.mainColor,
                      text: 'Sign In',
                      marginHeight: 15,
                      marginWidth: 0,
                      paddingHorizontal: 20,
                      action: () async {
                        await cart.addLogin(emailAddress: emailController.text, password: passwordController.text);
                        if (cart.stateOfLogin=='success'){
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  HomeScreen(uid: cart.userData!.uid,),
                            ),
                          );
                        }else{
                          globalAlertWidget(context: context, message: cart.stateOfLogin.toString() );
                        }
                      },
                      backgroundColor: AppColor.mainColor,
                    ):const Center(child: CircularProgressIndicator(color: AppColor.mainColor,));
                  }),
              Spacer(),

              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Dont't have account "),
                  InkWell(
                    onTap: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) {
                            return RegisterScreen();
                          }));
                    },
                    child: Text('Sign up', style: TextStyle(color: Colors.blue),),
                  ),
                ],
              ),
              Spacer(),

            ],
          ),

      ),
    );
  }
}
