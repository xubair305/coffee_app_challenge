import 'package:coffee_challenge/app/router/routes_path.dart';
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:coffee_challenge/l10n/l10n.dart';

class HomeSearchField extends StatelessWidget {
  const HomeSearchField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Container(
        height: 52,
        // width: context.width,
        decoration: BoxDecoration(
          color: const Color(0xFF313131),
          borderRadius: BorderRadius.circular(kBorderRadius),
        ),
        child: Row(
          children: [
            Gap(16.w),
            Image.asset(
              AssetsPath.searchIcon,
              scale: 4,
            ),
            Gap(8.w),
            Expanded(
              child: TextField(
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration.collapsed(
                  hintText: context.l10n.serachFieldHintText,
                  hintStyle: const TextStyle(
                    color: Color(0xFF989898),
                  ),
                ),
                readOnly: true,
                onTap: () => context.pushNamed(Routes.searchName),
              ),
            ),
            const Gap(8),
            Container(
              height: 44,
              width: 44,
              decoration: BoxDecoration(
                color: AppColors.appBrown,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(
                AssetsPath.filterIcon,
                scale: 4,
              ),
            ),
            const Gap(4),
          ],
        ),
      ),
    );
  }
}
