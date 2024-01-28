import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';

class SizeSelectionButton<T> extends StatelessWidget {
  const SizeSelectionButton({
    required this.size,
    required this.value,
    required this.groupValue,
    required this.onChanged,
    super.key,
  });
  final String size;
  final T value;
  final T? groupValue;
  final ValueChanged<T> onChanged;
  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return Expanded(
      child: Bouncing(
        onTap: () => onChanged(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: 44.w,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(
              color: isSelected ? AppColors.appBrown : const Color(0xFFDEDEDE),
              width: isSelected ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: isSelected ? const Color(0xFFFFF5EE) : Colors.white,
          ),
          child: Text(
            size,
            style: TextStyle(
              color: isSelected ? AppColors.appBrown : Colors.black,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }
}
