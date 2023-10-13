import 'package:flutter/material.dart';

import '../../../core/provider/get_un_user_data_provider.dart';
import '../../../core/string/app_color.dart';
import '../../../core/string/app_images.dart';
import '../provider/posts_data_provider.dart';

itemOfAddComment({required context, required String uid, required String postId}) {
  TextEditingController controller = TextEditingController();

  return Container(
    alignment: Alignment.center,
    width: MediaQuery.of(context).size.width,
    height:  70,
    decoration: const BoxDecoration(
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(30), topLeft: Radius.circular(30)),
      color: AppColor.textFieldColor,
    ),
    child: Row(
      children: [
        const SizedBox(
          width: 10,
        ),
        Expanded(
          child:
              SizedBox(
                height: 42,
                child: TextFormField(
                  controller: controller,
                  decoration: InputDecoration(

                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 0.0, horizontal: 10),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(65.0),
                        borderSide:
                        const BorderSide(color: AppColor.mainColor),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(65.0),
                        borderSide:
                        const BorderSide(color: Colors.transparent),
                      ),
                      suffixIcon: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                        // padding: EdgeInsets.all(5),
                        height: 35,
                        width: 25,
                        decoration: BoxDecoration(
                          color: Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(500.0),
                        ),
                        child: GestureDetector(
                          child: Icon(
                            Icons.send,
                            color: Colors.black.withOpacity(.4),
                            size: 15,
                          ),
                          onTap: () {
                            Provider.of<PostsDataProvider>(context, listen: false)
                                .addCommentProvider(uid: uid, idPost: postId, comment: controller.text,);
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      filled: true,
                      fillColor: Colors.white,
                      hintText: 'Message',
                      labelStyle: const TextStyle(
                          color: AppColor.mainTextColor, fontSize: 15),
                      hintStyle: const TextStyle(
                        color: AppColor.mainTextColor,
                        fontSize: 15,
                      )),
                ),
              ),
        ),
        const SizedBox(
          width: 10,
        ),
        GestureDetector(child: Image.asset(AppImages.iconGallery), onTap:(){
        }),
        const SizedBox(
          width: 20,
        ),
      ],
    ),
  );
}
