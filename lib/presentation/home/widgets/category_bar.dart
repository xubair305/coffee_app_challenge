import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';

class CategoryBar extends StatefulWidget {
  const CategoryBar({super.key});

  @override
  State<CategoryBar> createState() => _CategoryBarState();
}

class _CategoryBarState extends State<CategoryBar> {
  List<String> categories = [
    'Cappuccino',
    'Machiato',
    'Latte',
    'Americano',
  ];

  late String groupValue;

  @override
  void initState() {
    groupValue = categories.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Row(
        children: categories
            .map(
              (e) => _CategoryPill<String>(
                title: e,
                value: e,
                groupValue: groupValue,
                onChanged: (value) {
                  setState(() {
                    groupValue = value;
                  });
                },
              ),
            )
            .toList(),
      ),
    );
  }
}

class _CategoryPill<T> extends StatelessWidget {
  const _CategoryPill({
    required this.title,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });
  final String title;

  final T value;
  final T? groupValue;
  final ValueChanged<T> onChanged;

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return Bouncing(
      onTap: () => onChanged(value),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: EdgeInsets.symmetric(
          horizontal: 16.w,
          vertical: 10.w,
        ),
        margin: EdgeInsets.only(right: 8.w),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.appBrown : Colors.white,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          title,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.black,
            fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
          ),
        ),
      ),
    );
  }
}
