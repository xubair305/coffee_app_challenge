import 'package:flutter/material.dart';

extension AppBuildContext on BuildContext {
  AppBar materialYouAppBar(
    String title, {
    List<Widget>? actions,
    Widget? leadingWidget,
  }) =>
      AppBar(
        leading: leadingWidget,
        title: Text(title),
        titleTextStyle: Theme.of(this)
            .textTheme
            .titleLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        actions: actions ?? [],
      );

  void showMaterialSnackBar(
    String content, {
    Color? backgroundColor,
    Color? color,
  }) =>
      ScaffoldMessenger.of(this)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
            content: Text(
              content,
              style: TextStyle(
                color: color ?? Theme.of(this).colorScheme.onSurfaceVariant,
              ),
            ),
            behavior: SnackBarBehavior.floating,
            backgroundColor:
                backgroundColor ?? Theme.of(this).colorScheme.surfaceVariant,
          ),
        );
}

extension BuildContextExtensions on BuildContext {
  ThemeData get theme => Theme.of(this);

  TextTheme get textTheme => theme.textTheme;

  ColorScheme get colorScheme => theme.colorScheme;

  // AppColors get colors => theme.extension<AppColors>()!;

  double get width => MediaQuery.of(this).size.width;

  double get height => MediaQuery.of(this).size.height;
}
