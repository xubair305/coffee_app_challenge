import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';

class AssetIconButton extends StatelessWidget {
  const AssetIconButton({
    required this.onTap,
    required this.assetPath,
    super.key,
  });
  final VoidCallback onTap;
  final String assetPath;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: onTap,
      child: Container(
        height: 44.w,
        width: 44.w,
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: AppColors.buttonBgColor,
          image: DecorationImage(
            image: AssetImage(assetPath),
            scale: 4,
          ),
        ),
      ),
    );
  }
}
