import 'package:coffee_challenge/app_exports.dart';

class CustomText extends StatelessWidget {
  const CustomText(
    this.text, {
    this.styleType,
    this.fontWeight,
    this.decoration,
    super.key,
  });
  final String text;
  final StyleType? styleType;
  final FontWeight? fontWeight;
  final TextDecoration? decoration;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: getStyle,
    );
  }

  TextStyle get getStyle {
    switch (styleType) {
      case StyleType.heading1:
        return TextStyle(
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: 16.sp,
          color: const Color(0xFF2F2D2C),
          decoration: decoration,
        );
      case StyleType.heading2:
        return TextStyle(
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: 14.sp,
          color: const Color(0xFF303336),
          decoration: decoration,
        );
      case StyleType.heading3:
        return TextStyle(
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: 12.sp,
          color: const Color(0xFF808080),
          decoration: decoration,
        );
      case StyleType.paragraph:
        return TextStyle(
          fontWeight: fontWeight ?? FontWeight.w400,
          fontSize: 14.sp,
          color: const Color(0xFF9B9B9B),
          decoration: decoration,
        );
      default:
        return TextStyle(
          fontWeight: fontWeight ?? FontWeight.w600,
          fontSize: 16.sp,
          color: const Color(0xFF2F2D2C),
          decoration: decoration,
        );
    }
  }
}

enum StyleType { heading1, heading2, heading3, paragraph }
