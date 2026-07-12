part of 'cart_cubit.dart';

abstract class CartState {}

class CartInitial extends CartState {}

class CartLoading extends CartState {}

class CartLoaded extends CartState {
  final CartModel cart;

  CartLoaded(this.cart);
}

class CartFailure extends CartState {
  final String msg;

  CartFailure(this.msg);
}