import 'package:coffee_challenge/app/router/routes.dart';
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:coffee_challenge/core/utils/index.dart';
import 'package:coffee_challenge/l10n/l10n.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return GestureDetector(
          onTap: () => KeyboardUtil.hideKeyboard(context),
          child: MaterialApp.router(
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            // ==== Uncomment below line to change localization to Spanish =====
            // locale: const Locale('es'),
            theme: ThemeData(
              textTheme: ThemeData.light().textTheme.apply(fontFamily: 'Sora'),
              primaryColor: AppColors.appBrown,
              scaffoldBackgroundColor: const Color(0xFFF9F9F9),
              appBarTheme: AppBarTheme(
                centerTitle: true,
                color: const Color(0xFFF9F9F9),
                titleTextStyle: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF2F2D2C),
                ),
              ),
            ),
            debugShowCheckedModeBanner: false,
            routeInformationProvider: goRouter.routeInformationProvider,
            routeInformationParser: goRouter.routeInformationParser,
            routerDelegate: goRouter.routerDelegate,
            onGenerateTitle: (BuildContext context) => context.l10n.appName,
          ),
        );
      },
    );
  }
}
