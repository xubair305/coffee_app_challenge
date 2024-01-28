import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/index.dart';

class OutlinedButtonWithIcon extends StatelessWidget {
  const OutlinedButtonWithIcon({
    required this.title,
    this.iconAssetPath,
    this.onTap,
    super.key,
  });
  final String title;
  final String? iconAssetPath;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 6,
        ),
        decoration: BoxDecoration(
          border: Border.all(color: const Color(0xFFDEDEDE)),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Row(
          children: [
            Image.asset(iconAssetPath ?? AssetsPath.penIcon, scale: 3),
            const Gap(6),
            Text(
              title,
              style: TextStyle(
                color: const Color(0xFF303336),
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
