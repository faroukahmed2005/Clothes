import 'package:clothes/Models/cart_item_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());

  final Dio dio = Dio();

  Future<void> getCart({int userId = 1}) async {
    try {
      emit(CartLoading());

      final Response response =
          await dio.get('https://dummyjson.com/carts/user/$userId');

      final List cartsJson = response.data['carts'];

      final CartModel cart = cartsJson.isNotEmpty
          ? CartModel.fromJson(cartsJson.first)
          : CartModel.empty();

      emit(CartLoaded(cart));
    } on DioException catch (e) {
      emit(CartFailure(e.message ?? 'Error'));
    } catch (e) {
      emit(CartFailure(e.toString()));
    }
  }

  void increment(int index) {
    if (state is! CartLoaded) return;
    final cart = (state as CartLoaded).cart;

    final product = cart.products[index];
    product.quantity = (product.quantity ?? 0) + 1;
    _recalculate(product);

    emit(CartLoaded(cart));
  }

  void decrement(int index) {
    if (state is! CartLoaded) return;
    final cart = (state as CartLoaded).cart;

    final product = cart.products[index];

    if ((product.quantity ?? 0) > 1) {
      product.quantity = (product.quantity ?? 0) - 1;
      _recalculate(product);
    } else {
      cart.products.removeAt(index);
    }

    emit(CartLoaded(cart));
  }

  void removeItem(int index) {
    if (state is! CartLoaded) return;
    final cart = (state as CartLoaded).cart;

    cart.products.removeAt(index);
    emit(CartLoaded(cart));
  }

  void _recalculate(CartProductModel product) {
    final price = product.price ?? 0;
    final quantity = product.quantity ?? 0;
    final discountPercentage = product.discountPercentage ?? 0;

    product.total = price * quantity;
    product.discountedTotal =
        product.total! - (product.total! * discountPercentage / 100);
  }

  num get subtotal {
    if (state is! CartLoaded) return 0;
    final cart = (state as CartLoaded).cart;
    return cart.products.fold(0, (sum, p) => sum + (p.total ?? 0));
  }

  num get vat => 0;

  num get shippingFee {
    if (state is! CartLoaded) return 0;
    final cart = (state as CartLoaded).cart;
    return cart.products.isEmpty ? 0 : 80;
  }

  num get total => subtotal + vat + shippingFee;
}