import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback? action;
  final Color backgroundColor;
  final double? paddingVertical;
  final Color textColor;
  final TextStyle? textStyle;
  final Widget? bodyButton;
  final double? height;
  final double marginWidth;
  final EdgeInsetsGeometry? padding;
  final double? paddingHorizontal;
  final double marginHeight;
  final bool? notFlex;
  final Color boarderColor;

  const ButtonWidget(
      {super.key,
      required this.textColor,
      required this.boarderColor,
      this.bodyButton,
      this.textStyle,
      this.padding,
      this.height,
      required this.text,
      this.paddingHorizontal,
      this.paddingVertical,
      this.notFlex,
      required this.marginHeight,
      required this.marginWidth,
      this.action,
      required this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 57,
      margin:
          EdgeInsets.symmetric(horizontal: marginWidth, vertical: marginHeight),
      padding: EdgeInsets.symmetric(
          vertical: paddingVertical ?? 0, horizontal: paddingHorizontal ?? 0),
      decoration: BoxDecoration(
        color: backgroundColor,
        border: Border.all(
          color: boarderColor,
          width: 1,
        ),
        borderRadius: const BorderRadius.all(
          Radius.circular(500.0),
        ),
      ),
      child: bodyButton != null
          ? GestureDetector(
              onTap: action,
              child: bodyButton,
            )
          : TextButton(
              onPressed: action,
// style: ButtonStyle(
//   padding: EdgeInsets.zero,
// ),
              style: TextButton.styleFrom(
                padding: padding ?? EdgeInsets.zero,
              ),
              child: Container(
                alignment: notFlex == true ? null : Alignment.center,
                child: Text(
                  text,
                  style: textStyle ?? TextStyle(color: textColor, fontSize: 15),
                ),
              )),
    );
  }
}
