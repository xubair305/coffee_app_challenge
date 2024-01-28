import 'package:bloc/bloc.dart';
import 'package:coffee_challenge/presentation/order_checkout/view/order_checkout_page.dart';
import 'package:meta/meta.dart';

part 'order_checkout_state.dart';

class CupertinoSegmentCubit extends Cubit<OrderType> {
  CupertinoSegmentCubit() : super(OrderType.deliver);

  void onSegmentChange(OrderType type) => emit(type);
}

class OrderCounterCubit extends Cubit<(int, double)> {
  OrderCounterCubit(this.price) : super((1, price + 2.5));
  double deliveryFee = 3.5;
  double discountedDeliveryFee = 2.5;
  final double price;

  void onIncrementChange() {
    final itemQuantity = state.$1 + 1;
    final totalPay = (price * itemQuantity) + discountedDeliveryFee;
    final roundTotal = double.parse(totalPay.toStringAsFixed(2));
    emit((itemQuantity, roundTotal));
  }

  void onDecrementChange() {
    final itemQuantity = state.$1 - 1;
    final totalPay = (price * itemQuantity) + discountedDeliveryFee;
    final roundTotal = double.parse(totalPay.toStringAsFixed(2));
    emit((itemQuantity, roundTotal));
  }
}
