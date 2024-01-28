import 'package:coffee_challenge/app/router/routes_path.dart';
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';

class HomeCoffeeGridView extends StatelessWidget {
  const HomeCoffeeGridView({super.key});

  @override
  Widget build(BuildContext context) {
    final dummyData = CoffeeShop.coffeeItems;
    return GridView.builder(
      itemCount: dummyData.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        mainAxisSpacing: 16,
        crossAxisSpacing: 8,
        crossAxisCount: 2,
        childAspectRatio: 2 / 3.1,
      ),
      padding: EdgeInsets.symmetric(
        horizontal: kHorizontalPadding,
        vertical: 24.w,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) => FadeInUp(
        child: CoffeeTile(coffeeItem: dummyData[index]),
      ),
    );
  }
}

class CoffeeTile extends StatelessWidget {
  const CoffeeTile({required this.coffeeItem, super.key});

  final CoffeeItem coffeeItem;

  @override
  Widget build(BuildContext context) {
    return Bouncing(
      onTap: () => context.pushNamed(
        Routes.coffeeDetailsName,
        extra: coffeeItem,
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        padding: EdgeInsets.all(4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                alignment: Alignment.topLeft,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(coffeeItem.image),
                    fit: BoxFit.cover,
                  ),
                  borderRadius: BorderRadius.circular(12.w),
                ),
                child: Container(
                  height: 30.w,
                  width: 52.w,
                  decoration: BoxDecoration(
                    color: Colors.black38,
                    borderRadius: BorderRadius.only(
                      bottomRight: const Radius.circular(20),
                      topLeft: Radius.circular(12.w),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.star_rounded,
                        color: Color(0xFFFBBE21),
                        size: 16,
                      ),
                      const Gap(2),
                      Text(
                        coffeeItem.rating,
                        style: TextStyle(
                          fontSize: 10.sp,
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            CustomText(coffeeItem.title),
            Text(
              coffeeItem.subTitle,
              style: TextStyle(
                color: const Color(0xFF9B9B9B),
                fontWeight: FontWeight.w400,
                fontSize: 12.sp,
              ),
            ),
            const Gap(8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '\$${coffeeItem.price}',
                  style: TextStyle(
                    color: const Color(0xFF2F4B4E),
                    fontWeight: FontWeight.w600,
                    fontSize: 18.sp,
                  ),
                ),
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    color: AppColors.appBrown,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
