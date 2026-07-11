import 'package:animated_snack_bar/animated_snack_bar.dart';
import 'package:clothes/Core/Healpers/app_button.dart';
import 'package:clothes/Core/Healpers/app_colors.dart';
import 'package:clothes/Core/Healpers/app_styles.dart';
import 'package:clothes/Core/Healpers/app_toster.dart';
import 'package:clothes/Models/product_model.dart';
import 'package:flutter/material.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Details",
          style: TextStyle(color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(18),
                      child: Image.network(
                        product.firstImage,
                        width: double.infinity,
                        height: 260,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported_outlined),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      product.title ?? '',
                      style: AppStyles.kText28blackBold,
                    ),
                    const SizedBox(height: 8),
                    if (product.category?.name != null)
                      Text(
                        product.category!.name!,
                        style: TextStyle(color: Colors.grey.shade600),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      product.description ?? '',
                      style: const TextStyle(fontSize: 14, height: 1.5),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.whiteColor,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, -4),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text("Price"),
                        Text(
                          '\$${product.price ?? ''}',
                          style: AppStyles.kText28blackBold,
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: AppButton(
                      title: "Add to Cart",
                      onPressed: () {
                        showSnackBar(
                          msg: "Added to cart",
                          type: AnimatedSnackBarType.success,
                          context: context,
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
