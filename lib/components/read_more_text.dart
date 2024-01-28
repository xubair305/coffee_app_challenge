import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:coffee_challenge/l10n/l10n.dart';
import 'package:expandable_text/expandable_text.dart';

class ReadMoreTextWidget extends StatelessWidget {
  const ReadMoreTextWidget({
    required this.text,
    super.key,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return ExpandableText(
      text,
      maxLines: 3,
      expandText: context.l10n.readMoreText,
      collapseText: context.l10n.readLessText,
      animation: true,
      style: TextStyle(
        color: const Color(0xFF9B9B9B),
        fontSize: 14.sp,
        fontWeight: FontWeight.w400,
      ),
      linkStyle: const TextStyle(
        color: AppColors.appBrown,
        fontWeight: FontWeight.w600,
      ),
    );
  }
}
