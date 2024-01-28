import 'package:coffee_challenge/app/router/routes_path.dart';
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/presentation/favorites/cubit/favorites_cubit.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:flutter/cupertino.dart';

class FavoriteCoffeeTile extends StatelessWidget {
  const FavoriteCoffeeTile({
    required this.item,
    required this.index,
    this.showDelete = true,
    super.key,
  });
  final CoffeeItem item;
  final int index;
  final bool showDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(kBorderRadius),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => context.pushNamed(
                Routes.coffeeDetailsName,
                extra: item,
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 54.w,
                    width: 54.w,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(item.image),
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  const Gap(12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomText(
                          item.title,
                          styleType: StyleType.heading2,
                        ),
                        const Gap(4),
                        CustomText(
                          item.subTitle,
                          styleType: StyleType.heading3,
                        ),
                        const Gap(8),
                        CustomText('\$${item.price}'),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (showDelete)
            IconButton(
              iconSize: 18,
              onPressed: () async {
                // await PreferencesService.removeFavorite(item.id);
                await context
                    .read<FavoritesCubit>()
                    .removeFavorites(item, index);
              },
              icon: const Icon(
                CupertinoIcons.trash,
                color: Colors.red,
              ),
            ),
        ],
      ),
    );
  }
}
