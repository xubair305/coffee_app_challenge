import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class FlashyTabBar extends StatelessWidget {
  const FlashyTabBar({
    required this.items,
    required this.onItemSelected,
    super.key,
    this.selectedIndex = 0,
    this.animationDuration = const Duration(milliseconds: 250),
    this.animationCurve = Curves.linear,
  });

  final Curve animationCurve;
  final Duration animationDuration;
  final List<FlashyTabBarItem> items;
  final ValueChanged<int> onItemSelected;
  final int selectedIndex;

  @override
  Widget build(BuildContext context) {
    const height = 60.0;
    const iconSize = 30.0;
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 20,
          ),
        ],
        borderRadius: BorderRadius.circular(16),
      ),
      child: SafeArea(
        child: Container(
          width: double.infinity,
          height: height + iconSizeEffectCalculator(iconSize),
          padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: items.map((item) {
              final index = items.indexOf(item);
              return Expanded(
                child: GestureDetector(
                  onTap: () => onItemSelected(index),
                  child: _FlashTabBarItem(
                    item: item,
                    tabBarHeight: height,
                    iconSize: iconSize,
                    isSelected: index == selectedIndex,
                    backgroundColor: Colors.white,
                    animationDuration: animationDuration,
                    animationCurve: animationCurve,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  double iconSizeEffectCalculator(double size) => size > 30
      ? size * 1.2
      : size > 10
          ? size * .6
          : 0;
}

class FlashyTabBarItem {
  FlashyTabBarItem({required this.unSelectedIcon, required this.selectedIcon});

  final Widget unSelectedIcon;
  final Widget selectedIcon;
}

class _FlashTabBarItem extends StatelessWidget {
  const _FlashTabBarItem({
    required this.item,
    required this.isSelected,
    required this.tabBarHeight,
    required this.backgroundColor,
    required this.animationDuration,
    required this.animationCurve,
    required this.iconSize,
  });

  final Curve animationCurve;
  final Duration animationDuration;
  final Color backgroundColor;
  final double iconSize;
  final bool isSelected;
  final FlashyTabBarItem item;
  final double tabBarHeight;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor,
      height: double.maxFinite,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          AnimatedAlign(
            duration: animationDuration,
            alignment: isSelected ? Alignment.topCenter : Alignment.center,
            child: AnimatedOpacity(
              opacity: isSelected ? 1.0 : 1.0,
              duration: animationDuration,
              child: IconTheme(
                data: IconThemeData(
                  size: iconSize,
                  color: isSelected ? AppColors.appBrown : Colors.transparent,
                ),
                child: isSelected ? item.selectedIcon : item.unSelectedIcon,
              ),
            ),
          ),
          AnimatedPositioned(
            curve: animationCurve,
            duration: animationDuration,
            top: isSelected ? -2.0 * iconSize : tabBarHeight / 4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  width: iconSize,
                  height: iconSize,
                ),
                CustomPaint(
                  painter: _CustomPath(backgroundColor, iconSize),
                  child: SizedBox(
                    width: 80,
                    height: iconSize,
                  ),
                ),
              ],
            ),
          ),
          AnimatedAlign(
            alignment: isSelected ? Alignment.center : Alignment.bottomCenter,
            duration: animationDuration,
            curve: animationCurve,
            child: AnimatedOpacity(
              opacity: isSelected ? 1.0 : 0.0,
              duration: animationDuration,
              child: isSelected ? item.selectedIcon : item.unSelectedIcon,
            ),
          ),
          Positioned(
            bottom: 0,
            child: CustomPaint(
              painter: _CustomPath(backgroundColor, iconSize),
              child: SizedBox(
                width: 80,
                height: iconSize,
              ),
            ),
          ),

          /// This is the selected item indicator
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedOpacity(
              duration: animationDuration,
              opacity: isSelected ? 1.0 : 0.0,
              child: Container(
                width: 12,
                height: 5,
                alignment: Alignment.bottomCenter,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFFEDAB81), Color(0xFFC67C4E)],
                  ),
                  borderRadius: BorderRadius.circular(2.5),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CustomPath extends CustomPainter {
  _CustomPath(this.backgroundColor, this.iconSize);

  final Color backgroundColor;
  final double iconSize;

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();
    final paint = Paint();

    path
      ..lineTo(0, 0)
      ..lineTo(0, (iconSize * .2) * size.height)
      ..lineTo(1.0 * size.width, (iconSize * .2) * size.height)
      ..lineTo(1.0 * size.width, 1.0 * size.height)
      ..lineTo(0, 0)
      ..close();

    paint.color = backgroundColor;
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return oldDelegate != this;
  }
}
