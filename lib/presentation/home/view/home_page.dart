import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/presentation/home/widgets/index.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const ClampingScrollPhysics(),
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  width: context.width,
                  height: context.height * 0.35,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF313131),
                        Color(0xFF131313),
                      ],
                    ),
                  ),
                ),
                const SafeArea(
                  bottom: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoactionProfileRow(),
                      HomeSearchField(),
                      HomeBannerWidget(),
                    ],
                  ),
                ),
              ],
            ),
            Gap(16.w),
            const CategoryBar(),
            const HomeCoffeeGridView(),
          ],
        ),
      ),
    );
  }
}
