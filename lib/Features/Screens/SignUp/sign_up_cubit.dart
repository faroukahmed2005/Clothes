import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'sign_up_state.dart';

class SignUpCubit extends Cubit<SignUpState> {
  SignUpCubit() : super(SignUpInitial());

  final Dio dio = Dio();

  TextEditingController fullNameControl = TextEditingController();
  TextEditingController userEmailControl = TextEditingController();
  TextEditingController userPasswordControl = TextEditingController();
  TextEditingController confirmPasswordControl = TextEditingController();

  Future<void> signUp() async {
    if (userPasswordControl.text != confirmPasswordControl.text) {
      emit(SignUpFailure('Passwords do not match'));
      return;
    }

    try {
      emit(SignUpLoading());

      final Response response = await dio.post(
        'https://api.escuelajs.co/api/v1/users/',
        data: {
          "name": fullNameControl.text,
          "email": userEmailControl.text,
          "password": userPasswordControl.text,
          "avatar": "https://i.imgur.com/LDOO4Qs.jpg",
        },
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        emit(SignUpSuccess());
      } else {
        emit(SignUpFailure('Something went wrong'));
      }
    } on DioException catch (e) {
      emit(SignUpFailure(e.message ?? 'Error'));
    } catch (e) {
      emit(SignUpFailure(e.toString()));
    }
  }
}
