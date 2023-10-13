import 'package:flutter/material.dart';
import '../../../core/string/app_color.dart';


itemOfHome(
    {required context,
    String? icon,
    required String title,
    required GestureTapCallback onTap,
    int? countOfNotification}) {
  return GestureDetector(
    onTap: onTap,
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      height: 140,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Badge(
                  label: Text(
                    countOfNotification.toString(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w700),
                  ),isLabelVisible:countOfNotification!=null?true:false,
              backgroundColor: AppColor.redColor,
                  child: icon != null ? Image.asset(icon) : const SizedBox(),
              ),
          const SizedBox(
            height: 8,
          ),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          )
        ],
      ),
    ),
  );
}
