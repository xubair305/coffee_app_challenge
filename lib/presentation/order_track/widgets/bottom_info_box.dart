import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';
import 'package:coffee_challenge/core/helper/index.dart';

class BottomInfoBox extends StatelessWidget {
  const BottomInfoBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
        decoration: BoxDecoration(
          borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
          color: Colors.white,
          boxShadow: [
            BoxShadow(color: Colors.grey.shade200, blurRadius: 12),
          ],
        ),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildHandle(),
              const CustomText('10 minutes left'),
              const Gap(6),
              const Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    'Delivery to ',
                    styleType: StyleType.paragraph,
                  ),
                  CustomText(
                    'Jl. Kpg Sutoyo',
                    styleType: StyleType.heading2,
                  ),
                ],
              ),
              const Gap(20),
              Row(
                children: [
                  _buildProgressBar(),
                  const Gap(8),
                  _buildProgressBar(),
                  const Gap(8),
                  _buildProgressBar(),
                  const Gap(8),
                  _buildProgressBar(isActive: false),
                ],
              ),
              const Gap(12),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  border: Border.all(color: const Color(0xFFEAEAEA)),
                  borderRadius: BorderRadius.circular(kBorderRadius),
                ),
                child: Row(
                  children: [
                    Image.asset(AssetsPath.scooter, scale: 4),
                    const Gap(12),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomText('Delivered your order'),
                          CustomText(
                            'We deliver your goods to you in the shortes possible time.',
                            styleType: StyleType.heading3,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              const Gap(20),
              Row(
                children: [
                  Container(
                    height: 54,
                    width: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: AssetImage(AssetsPath.avatarImg),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  const Gap(12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          'Johan Hawn',
                          styleType: StyleType.heading2,
                        ),
                        Gap(8),
                        CustomText(
                          'Personal Courier',
                          styleType: StyleType.heading3,
                        ),
                      ],
                    ),
                  ),
                  Bouncing(
                    onTap: () => context.showMaterialSnackBar(
                      'User tapped on Call button...',
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color(0xFFDEDEDE)),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Image.asset(
                        AssetsPath.phoneIcon,
                        scale: 4,
                      ),
                    ),
                  ),
                ],
              ),
              const Gap(20),
            ],
          ),
        ),
      ),
    );
  }

  Expanded _buildProgressBar({bool isActive = true}) {
    return Expanded(
      child: Container(
        height: 4,
        decoration: BoxDecoration(
          color: isActive ? const Color(0xFF36C07E) : const Color(0xFFDFDFDF),
          borderRadius: BorderRadius.circular(20),
        ),
      ),
    );
  }

  Container _buildHandle() {
    return Container(
      height: 5,
      width: 44,
      margin: EdgeInsets.only(top: 10.w, bottom: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        color: const Color(0xFFEAEAEA),
      ),
    );
  }
}
