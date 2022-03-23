import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/constants/constant.dart';
import 'package:shop_app1/cubit/signup_states.dart';
import 'package:shop_app1/dio/dio_helper.dart';
import 'package:shop_app1/models/shop_user_model.dart';

class SignUpCubit extends Cubit<SignUpStates> {
  SignUpCubit() : super(SignUpInitialState());
  static SignUpCubit get(context) => BlocProvider.of(context);
  late ShopModel signUpModel;
  var iconData = Icon(Icons.visibility);
  bool isObSecure = true;
  void changePassState() {
    isObSecure = !isObSecure;
    iconData = isObSecure ? Icon(Icons.visibility) : Icon(Icons.visibility_off);
    emit(SignUpShowPassState());
  }

  void signUp({
    required String name,
    required String email,
    required String password,
    required String phone,
  }) {
    emit(SignUpLoadingState());
    DioHelper.sendData(url: 'register', data: {
      'name': name,
      'email': email,
      'password': password,
      'phone': phone,
    }).then((value) {
      print(value.data);
      signUpModel = ShopModel.fromJson(value.data);
      token = signUpModel.data!.token;
      emit(SignUpSuccessState(signUpModel));
    }).catchError((error) {
      emit(SignUpFailedState());
      print(error.toString());
    });
  }
}
