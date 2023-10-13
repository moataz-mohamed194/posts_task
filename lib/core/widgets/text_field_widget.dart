import 'package:flutter/material.dart';

import '../string/app_color.dart';

class TextFieldWidget extends StatelessWidget {
  final String hintText;
  final TextEditingController? controler;
  final Widget? rightWidget;
  final Widget? leftWidget;
  final bool? obscureText;
  final int? maxLines;
  final Color? borderColor;
  final Color? bgColor;
  final EdgeInsetsGeometry? contentPadding;
  final double? borderRadius;
  final double? height;
  final String? oldData;
  final bool? readOnly;
  final ValueChanged<String>? onChanged;
  final GestureTapCallback? onTap;
  final TextInputType? keyboardType;
  final FormFieldValidator? validatorTextField;

  const TextFieldWidget(
      {super.key, this.rightWidget,
      this.obscureText,
      this.oldData,
      this.leftWidget,
        this.contentPadding,
        this.onTap,
        this.borderColor,
        this.readOnly,
        this.onChanged,
        this.bgColor,
        this.borderRadius,
      this.keyboardType,
        this.height,
        this.maxLines,
      required this.hintText,
      this.controler,
      this.validatorTextField});
  @override
  Widget build(BuildContext context) {
    return Column(
      // crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height:height?? 57,
          child: TextFormField(
            readOnly:readOnly??false ,
              controller: controler,
              keyboardType: keyboardType,
              initialValue: oldData,
              validator: (val) => validatorTextField!(val),
              onChanged: onChanged,
              maxLines: maxLines,
              onTap:onTap ,
              decoration: InputDecoration(
                  contentPadding: contentPadding?? const EdgeInsets.symmetric(horizontal: 15, vertical: 0),

                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius??65.0),
                    borderSide:  BorderSide(color:borderColor?? AppColor.mainColor),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(borderRadius??65.0),
                    borderSide:  BorderSide(color:borderColor?? Colors.transparent),
                  ),
                  suffixIcon: rightWidget,
                  filled: true,
                  prefixIcon: leftWidget,
                  fillColor: bgColor??Colors.white,
                  hintText: hintText,
                  // label: Text(hintText),
                  labelStyle:const TextStyle(color: AppColor.mainTextColor, fontSize: 15) ,
                  hintStyle: const TextStyle(color: AppColor.mainTextColor, fontSize: 15)),
              obscureText: obscureText ?? false),
        ),
      ],
    );
  }
}
