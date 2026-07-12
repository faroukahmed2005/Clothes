import 'package:clothes/Core/Healpers/app_button.dart';
import 'package:clothes/Core/Healpers/app_colors.dart';
import 'package:clothes/Core/Healpers/app_styles.dart';
import 'package:clothes/Features/Screens/Cart/cart_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit()..getCart(),
      child: BlocBuilder<CartCubit, CartState>(
        builder: (context, state) {
          final cubit = context.read<CartCubit>();

          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            appBar: AppBar(
              backgroundColor: AppColors.whiteColor,
              elevation: 0,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.maybePop(context),
              ),
              title: const Text(
                "My Cart",
                style: TextStyle(color: Colors.black),
              ),
              centerTitle: true,
            ),
            body: Builder(
              builder: (context) {
                if (state is CartLoading || state is CartInitial) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (state is CartFailure) {
                  return Center(child: Text(state.msg));
                }

                final products = (state as CartLoaded).cart.products;

                if (products.isEmpty) {
                  return const Center(child: Text("Your cart is empty"));
                }

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.all(16),
                        itemCount: products.length,
                        separatorBuilder: (_, __) =>
                            const SizedBox(height: 16),
                        itemBuilder: (context, index) {
                          final product = products[index];

                          return Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: AppColors.whiteColor,
                              borderRadius: BorderRadius.circular(18),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.05),
                                  blurRadius: 8,
                                  offset: const Offset(0, 4),
                                ),
                              ],
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // Column 
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.network(
                                    product.thumbnail ?? '',
                                    width: 110,
                                    height: 110,
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.image_not_supported_outlined,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 12),

                                // Column 2
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Row 1
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              product.title ?? '',
                                              style:
                                                  AppStyles.kText16blackBold,
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                          IconButton(
                                            constraints:
                                                const BoxConstraints(),
                                            padding: EdgeInsets.zero,
                                            icon: const Icon(
                                              Icons.delete_outline,
                                              color: Colors.red,
                                            ),
                                            onPressed: () =>
                                                cubit.removeItem(index),
                                          ),
                                        ],
                                      ),

                                      // Row 2
                                      Text(
                                        '\$${product.price ?? ''} each',
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                      const SizedBox(height: 8),

                                      // Row 3
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            '\$${(product.total ?? 0).toStringAsFixed(2)}',
                                            style:
                                                AppStyles.kText16blackBold,
                                          ),
                                          Container(
                                            padding:
                                                const EdgeInsets.symmetric(
                                              horizontal: 8,
                                            ),
                                            child: Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                IconButton(
                                                  constraints:
                                                      const BoxConstraints(),
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.remove,
                                                    size: 18,
                                                  ),
                                                  onPressed: () =>
                                                      cubit.decrement(index),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets
                                                          .symmetric(
                                                    horizontal: 8,
                                                  ),
                                                  child: Text(
                                                      '${product.quantity}'),
                                                ),
                                                IconButton(
                                                  constraints:
                                                      const BoxConstraints(),
                                                  padding: EdgeInsets.zero,
                                                  icon: const Icon(
                                                    Icons.add,
                                                    size: 18,
                                                  ),
                                                  onPressed: () =>
                                                      cubit.increment(index),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          _summaryRow("Sub-total", cubit.subtotal),
                          _summaryRow("VAT (%)", cubit.vat),
                          _summaryRow("Shipping fee", cubit.shippingFee),
                          const Divider(height: 24),
                          _summaryRow("Total", cubit.total, isBold: true),
                          const SizedBox(height: 16),
                          AppButton(
                            title: "Go To Checkout",
                            onPressed: () {},
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _summaryRow(String label, num value, {bool isBold = false}) {
    final style = isBold
        ? AppStyles.kText16blackBold
        : TextStyle(color: Colors.grey.shade600);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: style),
          Text('\$${value.toStringAsFixed(2)}', style: style),
        ],
      ),
    );
  }
}