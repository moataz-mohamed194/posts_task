import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../core/string/app_color.dart';
import '../../../core/widgets/alert.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../../register/provider/show_password_provider.dart';
import '../provider/auth_provider.dart';
import 'login_screen.dart';

class RegisterScreen extends StatelessWidget {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController userNameController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  RegisterScreen({super.key});
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColor.greyColor,
        elevation: 0,
      ),
      backgroundColor: AppColor.greyColor,
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 23),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  const Text(
                    'Create Account  ',
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
                    hintText: 'User Name',
                    controler: userNameController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Enter Email Address ',
                    controler: emailController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFieldWidget(
                    keyboardType: TextInputType.text,
                    hintText: 'Enter Mobile Number',
                    controler: phoneNumberController,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<ShowPasswordProvider>(builder: (context, cart, child) {
                    return TextFieldWidget(
                      hintText: 'Password',
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
                      controler: passwordController,
                      maxLines: 1,
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                  Consumer<ShowPasswordProvider>(builder: (context, cart, child) {
                    return TextFieldWidget(
                      hintText: 'Confirm Password',
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
                      controler: confirmPasswordController,
                    );
                  }),
                  const SizedBox(
                    height: 15,
                  ),
                ],
              ),
            ),

            SizedBox(height: 10,),
            Consumer<RegisterProvider>(
                builder: (context, cart, child) {
                  return cart.stateOfRegister!=null? ButtonWidget(
                    textColor: Colors.white,
                    boarderColor: AppColor.mainColor,
                    text: 'Create',
                    marginHeight: 15,
                    marginWidth: 0,
                    paddingHorizontal: 20,
                    action: () async {
                      await cart.createAdminAccount(emailAddress: emailController.text, password: passwordController.text, userName: userNameController.text, phoneNumber: phoneNumberController.text, confirmPassword: confirmPasswordController.text);
                      if (cart.stateOfRegister=='success'){
                        // Navigator.of(context).push(
                        //   MaterialPageRoute(
                        //     builder: (context) =>
                        //     const SplashScreenOfCreate(),
                        //   ),
                        // );
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Text("Created Success"),
                        ));
                        Navigator.pop(context);
                      }else{
                        globalAlertWidget(context: context, message: cart.stateOfRegister.toString() );
                      }
                    },
                    backgroundColor: AppColor.mainColor,
                  ):const Center(child: CircularProgressIndicator(color: AppColor.mainColor,));}),
            // Spacer(),

            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Already have account "),
                InkWell(
                  onTap: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) {
                          return LoginScreen();
                        }));
                  },
                  child: Text('Login', style: TextStyle(color: Colors.blue),),
                ),
              ],
            ),
            SizedBox(height: 50,),
          ],
        )


      ),
    );
  }
}
