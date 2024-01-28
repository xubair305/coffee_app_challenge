import 'package:coffee_challenge/app/router/routes_path.dart';
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:coffee_challenge/l10n/l10n.dart';
import 'package:coffee_challenge/presentation/coffee_details/cubit/coffee_details_cubit.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:like_button/like_button.dart';

class CoffeeDetailsPage extends StatelessWidget {
  const CoffeeDetailsPage({required this.coffeeItem, super.key});
  final CoffeeItem? coffeeItem;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CoffeeDetailsCubit()..checkFavoriteAddedOrNot(coffeeItem!.id),
      child: CoffeeDetails(coffeeItem: coffeeItem),
    );
  }
}

class CoffeeDetails extends StatelessWidget {
  const CoffeeDetails({required this.coffeeItem, super.key});
  final CoffeeItem? coffeeItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: _buildAppBar(context),
      body: coffeeItem != null
          ? ListView(
              padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
              children: [
                const Gap(8),
                _buildBanner(),
                const Gap(20),
                _buildMiddleSection(context),
                const Gap(20),
                const AppDivider(),
                const Gap(20),
                _buildDescriptionSection(context),
                const Gap(20),
                _buildSizeSelectionRow(context),
              ],
            )
          : const CustomText('Something went wrong!'),
      bottomNavigationBar: _buildBuyNowBar(context),
    );
  }

  Widget _buildBuyNowBar(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: kHorizontalPadding,
            vertical: 12,
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      context.l10n.priceText,
                      styleType: StyleType.paragraph,
                    ),
                    Text(
                      '\$${coffeeItem!.price}',
                      style: TextStyle(
                        color: AppColors.appBrown,
                        fontWeight: FontWeight.w600,
                        fontSize: 18.sp,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 2,
                child: ShakeX(
                  from: 4,
                  child: Bouncing(
                    onTap: () => context.pushNamed(
                      Routes.orderCheckoutName,
                      extra: coffeeItem,
                    ),
                    child: Container(
                      height: 60,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.appBrown,
                        borderRadius: BorderRadius.circular(kBorderRadius),
                      ),
                      child: Text(
                        context.l10n.buyNow,
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSizeSelectionRow(BuildContext context) {
    return BlocBuilder<CoffeeDetailsCubit, CoffeeDetailsState>(
      buildWhen: (previous, current) =>
          current is CoffeeDetailsSizeChange && previous != current,
      builder: (context, state) {
        final selectedValue =
            context.watch<CoffeeDetailsCubit>().state is CoffeeDetailsSizeChange
                ? (context.read<CoffeeDetailsCubit>().state
                        as CoffeeDetailsSizeChange)
                    .value
                : 1;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomText(context.l10n.sizeText),
            const Gap(12),
            Row(
              children: [
                SizeSelectionButton(
                  size: 'S',
                  value: 1,
                  groupValue: selectedValue,
                  onChanged: (value) => _onSizeChange(value, context),
                ),
                const Gap(12),
                SizeSelectionButton(
                  size: 'M',
                  value: 2,
                  groupValue: selectedValue,
                  onChanged: (value) => _onSizeChange(value, context),
                ),
                const Gap(12),
                SizeSelectionButton(
                  size: 'L',
                  value: 3,
                  groupValue: selectedValue,
                  onChanged: (value) => _onSizeChange(value, context),
                ),
              ],
            ),
          ],
        );
      },
    );
  }

  void _onSizeChange(int value, BuildContext context) {
    context.read<CoffeeDetailsCubit>().changeSize(value);
  }

  Column _buildDescriptionSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CustomText(context.l10n.descriptionText),
        const Gap(12),
        ReadMoreTextWidget(text: coffeeItem!.description),
      ],
    );
  }

  Column _buildMiddleSection(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          coffeeItem!.title,
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const Gap(4),
        CustomText(
          coffeeItem!.subTitle,
          styleType: StyleType.paragraph,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.star_rounded,
                  color: AppColors.yellowStar,
                  size: 24,
                ),
                RichText(
                  text: TextSpan(
                    text: coffeeItem!.rating,
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                      fontFamily: 'Sora',
                    ),
                    children: [
                      TextSpan(
                        text: ' (230)',
                        style: TextStyle(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF808080),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Row(
              children: [
                AssetIconButton(
                  onTap: () => context
                      .showMaterialSnackBar('User tapped on Bean button...'),
                  assetPath: AssetsPath.beansIcon,
                ),
                const Gap(12),
                AssetIconButton(
                  onTap: () => context
                      .showMaterialSnackBar('User tapped on Milk button...'),
                  assetPath: AssetsPath.milkIcon,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  Container _buildBanner() {
    return Container(
      height: 220.w,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(kBorderRadius),
        image: DecorationImage(
          image: AssetImage(coffeeItem!.image),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      title: Text(context.l10n.detailText),
      actions: [
        BlocBuilder<CoffeeDetailsCubit, CoffeeDetailsState>(
          buildWhen: (previous, current) =>
              current is CoffeeDetailsChecked && previous != current,
          builder: (context, state) {
            return state is CoffeeDetailsChecked
                ? LikeButton(
                    isLiked: state.isAdded,
                    likeBuilder: (isLiked) {
                      return Icon(
                        isLiked
                            ? Icons.favorite_rounded
                            : Icons.favorite_outline_rounded,
                        color: isLiked ? Colors.redAccent : Colors.black,
                      );
                    },
                    circleColor: const CircleColor(
                      start: Colors.black,
                      end: AppColors.appBrown,
                    ),
                    bubblesColor: const BubblesColor(
                      dotPrimaryColor: Colors.blue,
                      dotSecondaryColor: Colors.amberAccent,
                    ),
                    onTap: (liked) => _onFavTap(context, liked),
                  )
                : Container();
          },
        ),
        const Gap(12),
      ],
    );
  }

  Future<bool?> _onFavTap(BuildContext context, bool liked) async {
    if (!liked) {
      await context.read<CoffeeDetailsCubit>().addToFavorites(coffeeItem!);
    } else {
      await context.read<CoffeeDetailsCubit>().removeFavorites(coffeeItem!.id);
    }
    return true;
  }
}
