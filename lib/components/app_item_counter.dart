
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';

class ItemCounter extends StatelessWidget {
  const ItemCounter({
    required this.value,
    required this.onIncrement,
    required this.onDecrement,
    super.key,
  });

  final int value;
  final VoidCallback onIncrement;
  final VoidCallback onDecrement;

  @override
  Widget build(BuildContext context) {
    final enable = value > 1;
    return Row(
      children: [
        _buildButton(
          onTap: onDecrement,
          isAddButton: false,
          enable: enable,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            '$value',
            style: TextStyle(
              fontSize: 14.sp,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF2F2D2C),
            ),
          ),
        ),
        _buildButton(onTap: onIncrement),
      ],
    );
  }

  Widget _buildButton({
    required VoidCallback onTap,
    bool isAddButton = true,
    bool enable = true,
  }) {
    return Bouncing(
      onTap: enable ? onTap : null,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: const Color(0xFFEAEAEA),
          ),
        ),
        child: Icon(
          isAddButton ? Icons.add_rounded : Icons.remove_rounded,
          color: !enable ? const Color(0xFFAAADB0) : null,
        ),
      ),
    );
  }
}
