import 'package:clothes/Models/user_model.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit() : super(LoginInitial());

  final Dio dio = Dio();
  TextEditingController userEmailControl= TextEditingController();
  TextEditingController userPasswordControl= TextEditingController();
  

  Future<void> login() async {
    try {
      emit(LoginLoading());

      final Response response = await dio.post(
        'https://api.escuelajs.co/api/v1/auth/login',
        data: {
          "email": userEmailControl.text,
          "password": userPasswordControl. text
        },
      );


      if(response.statusCode == 200 || response. statusCode == 201){
        UserModel userModel = UserModel. fromJson(response.data); 
        emit(LoginSuccess());
      }
      else {
        emit(LoginFailure('no token'));
      }




    } on DioException catch (e) {
      emit(LoginFailure(e.message ?? 'Error'));
    } catch (e) {
      emit(LoginFailure(e.toString()));
    }
  }
}