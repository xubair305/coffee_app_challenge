import 'package:coffee_challenge/app_exports.dart';

import 'package:coffee_challenge/core/helper/index.dart';

class HomeBannerWidget extends StatelessWidget {
  const HomeBannerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.fromLTRB(kHorizontalPadding, 16.w, kHorizontalPadding, 0),
      child: Container(
        height: 140.w,
        width: context.width,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(kBorderRadius),
          image: const DecorationImage(
            image: AssetImage(AssetsPath.homeBanner),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
