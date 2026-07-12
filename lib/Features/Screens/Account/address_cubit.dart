import 'package:clothes/Models/address_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final Dio dio = Dio();

  static const String addressUrl = "https://api.escuelajs.co/api/v1/locations";

  Future<void> getAddresses() async {
    try {
      emit(AddressLoading());

      final Response response = await dio.get(addressUrl);

      final addresses = (response.data as List)
          .map((e) => AddressModel.fromJson(e))
          .toList();

      emit(AddressLoaded(addresses));
    } on DioException catch (e) {
      emit(AddressFailure(e.message ?? 'Error'));
    } catch (e) {
      emit(AddressFailure(e.toString()));
    }
  }
}