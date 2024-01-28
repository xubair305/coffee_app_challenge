import 'package:coffee_challenge/app_exports.dart';

class AppDivider extends StatelessWidget {
  const AppDivider({
    super.key,
    this.thickness,
    this.height,
  });
  final double? thickness;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Divider(
      color: const Color(0xFFEAEAEA),
      thickness: thickness,
      height: height,
    );
  }
}
