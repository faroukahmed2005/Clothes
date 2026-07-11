import 'package:clothes/Core/Healpers/app_category_chip.dart';
import 'package:clothes/Core/Healpers/app_colors.dart';
import 'package:clothes/Core/Healpers/app_product_card.dart';
import 'package:clothes/Core/Healpers/app_styles.dart';
import 'package:clothes/Features/Screens/Home/home_cubit.dart';
import 'package:clothes/Features/Screens/ProductDetails/product_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit()..getHomeData(),
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, state) {
          final cubit = context.read<HomeCubit>();

          return Scaffold(
            backgroundColor: AppColors.whiteColor,
            body: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      "Discover",
                      style: AppStyles.kText28blackBold,
                    ),
                    const SizedBox(height: 16),

                    TextField(
                      controller: cubit.searchController,
                      onSubmitted: (value) => cubit.search(value),
                      decoration: InputDecoration(
                        hintText: "Search for clothes...",
                        prefixIcon: const Icon(Icons.search),
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(18),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),

                    SizedBox(
                      height: 44,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        children: [
                          AppCategoryChip(
                            title: "All",
                            isSelected: cubit.selectedCategoryId == null,
                            onTap: () => cubit.filterByCategory(null),
                          ),
                          const SizedBox(width: 8),
                          ...cubit.categories.map(
                            (category) => Padding(
                              padding: const EdgeInsets.only(right: 8),
                              child: AppCategoryChip(
                                title: category.name ?? '',
                                isSelected:
                                    cubit.selectedCategoryId == category.id,
                                onTap: () =>
                                    cubit.filterByCategory(category.id),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),

                    Expanded(
                      child: Builder(
                        builder: (context) {
                          if (state is HomeLoading || state is HomeInitial) {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }

                          if (state is HomeFailure) {
                            return Center(child: Text(state.msg));
                          }

                          final products = (state as HomeSuccess).products;

                          if (products.isEmpty) {
                            return const Center(
                              child: Text("No products found"),
                            );
                          }

                          return GridView.builder(
                            itemCount: products.length,
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 12,
                              crossAxisSpacing: 12,
                              childAspectRatio: 0.7,
                            ),
                            itemBuilder: (context, index) {
                              final product = products[index];
                              return AppProductCard(
                                product: product,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ProductDetailsScreen(
                                        product: product,
                                      ),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
