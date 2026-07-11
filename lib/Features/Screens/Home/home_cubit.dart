import 'package:clothes/Models/category_model.dart';
import 'package:clothes/Models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitial());

  final Dio dio = Dio();
  TextEditingController searchController = TextEditingController();

  List<CategoryModel> categories = [];
  List<ProductModel> allProducts = [];
  int? selectedCategoryId;

  Future<void> getHomeData() async {
    try {
      emit(HomeLoading());

      final Response categoriesResponse =
          await dio.get('https://api.escuelajs.co/api/v1/categories');

      final Response productsResponse =
          await dio.get('https://api.escuelajs.co/api/v1/products');

      categories = (categoriesResponse.data as List)
          .map((e) => CategoryModel.fromJson(e))
          .toList();

      allProducts = (productsResponse.data as List)
          .map((e) => ProductModel.fromJson(e))
          .toList();

      emit(HomeSuccess(allProducts));
    } on DioException catch (e) {
      emit(HomeFailure(e.message ?? 'Error'));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }

  void filterByCategory(int? categoryId) {
    selectedCategoryId = categoryId;

    if (categoryId == null) {
      emit(HomeSuccess(allProducts));
    } else {
      emit(
        HomeSuccess(
          allProducts.where((p) => p.category?.id == categoryId).toList(),
        ),
      );
    }
  }

  Future<void> search(String title) async {
    if (title.trim().isEmpty) {
      emit(HomeSuccess(allProducts));
      return;
    }

    try {
      emit(HomeLoading());

      final Response response = await dio.get(
        'https://api.escuelajs.co/api/v1/products/?title=$title',
      );

      final products =
          (response.data as List).map((e) => ProductModel.fromJson(e)).toList();

      emit(HomeSuccess(products));
    } on DioException catch (e) {
      emit(HomeFailure(e.message ?? 'Error'));
    } catch (e) {
      emit(HomeFailure(e.toString()));
    }
  }
}
