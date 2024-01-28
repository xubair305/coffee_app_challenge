import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/l10n/l10n.dart';

class LoactionProfileRow extends StatelessWidget {
  const LoactionProfileRow({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: kHorizontalPadding, vertical: 24.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.l10n.locationText,
                style: TextStyle(
                  fontSize: 12.sp,
                  color: const Color(0xFFB7B7B7),
                ),
              ),
              Row(
                children: [
                  Text(
                    'Bilzen, Tanjungbalai',
                    style: TextStyle(
                      color: const Color(0xFFDDDDDD),
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                  const Icon(
                    Icons.expand_more_rounded,
                    color: Colors.white,
                  ),
                ],
              ),
            ],
          ),
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              image: const DecorationImage(
                image: AssetImage(AssetsPath.avatarImg),
                fit: BoxFit.cover,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
