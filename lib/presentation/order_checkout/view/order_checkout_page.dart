import 'package:coffee_challenge/app/router/routes_path.dart';
import 'package:coffee_challenge/app_exports.dart';
import 'package:coffee_challenge/components/app_item_counter.dart';
import 'package:coffee_challenge/components/index.dart';
import 'package:coffee_challenge/components/outlined_button_with_icon.dart';
import 'package:coffee_challenge/core/helper/bouncing_button.dart';
import 'package:coffee_challenge/core/helper/index.dart';
import 'package:coffee_challenge/core/theme/app_colors.dart';
import 'package:coffee_challenge/l10n/l10n.dart';
import 'package:coffee_challenge/presentation/home/model/coffee_item_model.dart';
import 'package:coffee_challenge/presentation/order_checkout/cubit/order_checkout_cubit.dart';
import 'package:flutter/cupertino.dart';

enum OrderType { deliver, pickUp }

class OrderCheckoutPage extends StatelessWidget {
  const OrderCheckoutPage({required this.coffeeItem, super.key});

  final CoffeeItem? coffeeItem;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CupertinoSegmentCubit>(
          create: (context) => CupertinoSegmentCubit(),
        ),
        BlocProvider<OrderCounterCubit>(
          create: (context) =>
              OrderCounterCubit(double.parse(coffeeItem!.price)),
        ),
      ],
      child: OrderCheckout(coffeeItem: coffeeItem),
    );
  }
}

class OrderCheckout extends StatelessWidget {
  const OrderCheckout({required this.coffeeItem, super.key});

  final CoffeeItem? coffeeItem;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.orderText)),
      body: ListView(
        children: [
          _buildDeliverySegmentedControl(context),
          _buildDeliveryAddressSection(context),
          _buildCoffeeItemSection(coffeeItem!),
          const AppDivider(thickness: 4, height: 0),
          _buildDiscountSection(),
          _buildPaymentSummarySection(context, coffeeItem!),
        ],
      ),
      bottomNavigationBar: _buildBuyNowBar(context),
    );
  }

  Container _buildBuyNowBar(BuildContext context) {
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
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Image.asset(AssetsPath.cashIcon, scale: 4),
                  const Gap(12),
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF6F6F6),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: AppColors.appBrown,
                          ),
                          child: Text(
                            'Cash',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w400,
                              fontSize: 12.sp,
                            ),
                          ),
                        ),
                        const Gap(8),
                        BlocBuilder<OrderCounterCubit, (int, double)>(
                          builder: (context, state) {
                            return CustomText(
                              '\$${state.$2}',
                              styleType: StyleType.heading2,
                              fontWeight: FontWeight.w400,
                            );
                          },
                        ),
                        const Gap(14),
                      ],
                    ),
                  ),
                  const Spacer(),
                  const CircleAvatar(
                    radius: 12,
                    backgroundColor: Color(0xFF808080),
                    child: Icon(
                      Icons.more_horiz_rounded,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              const Gap(16),
              ShakeX(
                from: 4,
                child: Bouncing(
                  onTap: () => context.pushNamed(Routes.orderTrackName),
                  child: Container(
                    height: 60,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: AppColors.appBrown,
                      borderRadius: BorderRadius.circular(kBorderRadius),
                    ),
                    child: Text(
                      context.l10n.orderText,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
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

  Widget _buildDeliverySegmentedControl(BuildContext context) {
    return BlocBuilder<CupertinoSegmentCubit, OrderType>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CupertinoSlidingSegmentedControl<OrderType>(
                  backgroundColor: const Color(0xFFF2F2F2),
                  thumbColor: AppColors.appBrown,
                  groupValue: state,
                  padding: const EdgeInsets.all(4),
                  onValueChanged: (value) {
                    if (value != null) {
                      context
                          .read<CupertinoSegmentCubit>()
                          .onSegmentChange(value);
                    }
                  },
                  children: <OrderType, Widget>{
                    OrderType.deliver: _buildSegmentedControlChild(
                      context.l10n.deliverText,
                      state == OrderType.deliver,
                    ),
                    OrderType.pickUp: _buildSegmentedControlChild(
                      context.l10n.pickUpText,
                      state == OrderType.pickUp,
                    ),
                  },
                ),
              ),
              const Gap(24),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSegmentedControlChild(String text, bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 36,
        vertical: 12,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: isSelected ? Colors.white : Colors.black,
        ),
      ),
    );
  }

  Widget _buildDeliveryAddressSection(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.l10n.deliveryAddText,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 16.sp,
            ),
          ),
          const Gap(16),
          Text(
            'Jl. Kpg Sutoyo',
            style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14.sp,
              color: const Color(0xFF303336),
            ),
          ),
          const Gap(8),
          Text(
            'Kpg. Sutoyo No. 620, Bilzen, Tanjungbalai.',
            style: TextStyle(
              fontWeight: FontWeight.w400,
              fontSize: 12.sp,
              color: const Color(0xFF808080),
            ),
          ),
          const Gap(16),
          Row(
            children: [
              OutlinedButtonWithIcon(
                title: context.l10n.editAddressText,
                iconAssetPath: AssetsPath.penIcon,
                onTap: () {
                  // Handle edit address action
                },
              ),
              const Gap(8),
              OutlinedButtonWithIcon(
                title: context.l10n.addNoteText,
                iconAssetPath: AssetsPath.noteIcon,
                onTap: () {
                  // Handle add note action
                },
              ),
            ],
          ),
          const Gap(20),
          const AppDivider(height: 0),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildCoffeeItemSection(CoffeeItem coffeeItem) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                height: 54.w,
                width: 54.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  image: DecorationImage(
                    image: AssetImage(coffeeItem.image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      coffeeItem.title,
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF2F2D2C),
                      ),
                    ),
                    const Gap(4),
                    Text(
                      coffeeItem.subTitle,
                      style: TextStyle(
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                        color: const Color(0xFF9B9B9B),
                      ),
                    ),
                  ],
                ),
              ),
              BlocBuilder<OrderCounterCubit, (int, double)>(
                builder: (context, value) {
                  return ItemCounter(
                    value: value.$1,
                    onIncrement: () =>
                        context.read<OrderCounterCubit>().onIncrementChange(),
                    onDecrement: () =>
                        context.read<OrderCounterCubit>().onDecrementChange(),
                  );
                },
              ),
            ],
          ),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildDiscountSection() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Gap(20),
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              border: Border.all(color: const Color(0xFFEAEAEA)),
              borderRadius: BorderRadius.circular(kBorderRadius),
            ),
            child: Row(
              children: [
                Image.asset(
                  AssetsPath.percentIcon,
                  scale: 4,
                ),
                const Gap(12),
                Expanded(
                  child: Text(
                    '1 Discount is applied',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 20,
                ),
              ],
            ),
          ),
          const Gap(20),
        ],
      ),
    );
  }

  Widget _buildPaymentSummarySection(
    BuildContext context,
    CoffeeItem coffeeItem,
  ) {
    final deliveryFee =
        context.read<OrderCounterCubit>().deliveryFee.toString();
    final discountedDeliveryFee =
        context.read<OrderCounterCubit>().discountedDeliveryFee.toString();
    return BlocBuilder<OrderCounterCubit, (int, double)>(
      builder: (context, value) {
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: kHorizontalPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(context.l10n.paymentSummary),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    context.l10n.priceText,
                    styleType: StyleType.heading2,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    '\$${coffeeItem.price}',
                    styleType: StyleType.heading2,
                  ),
                ],
              ),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    context.l10n.deliveryFeeText,
                    styleType: StyleType.heading2,
                    fontWeight: FontWeight.w400,
                  ),
                  const Spacer(),
                  CustomText(
                    '\$$deliveryFee',
                    styleType: StyleType.heading2,
                    decoration: TextDecoration.lineThrough,
                    fontWeight: FontWeight.w400,
                  ),
                  const Gap(8),
                  CustomText(
                    '\$$discountedDeliveryFee',
                    styleType: StyleType.heading2,
                  ),
                ],
              ),
              const Gap(16),
              const AppDivider(height: 0),
              const Gap(16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CustomText(
                    context.l10n.totalPaymentText,
                    styleType: StyleType.heading2,
                    fontWeight: FontWeight.w400,
                  ),
                  CustomText(
                    '\$${value.$2}',
                    styleType: StyleType.heading2,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
