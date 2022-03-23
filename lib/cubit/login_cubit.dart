import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/constants/constant.dart';
import 'package:shop_app1/cubit/login_states.dart';
import 'package:shop_app1/dio/dio_helper.dart';
import 'package:shop_app1/models/shop_user_model.dart';

class LoginCubit extends Cubit<LoginStates> {
  LoginCubit() : super(LoginInitialState());
  static LoginCubit get(context) => BlocProvider.of(context);
  late ShopModel shopModel;
  var iconData = Icon(Icons.visibility);
  bool isObSecure = true;
  void changePassState() {
    isObSecure = !isObSecure;
    iconData = isObSecure ? Icon(Icons.visibility) : Icon(Icons.visibility_off);
    emit(LoginShowPassState());
  }

  void login({
    required String email,
    required String password,
  }) {
    emit(LoginLoadingState());
    DioHelper.sendData(url: 'login', data: {
      'email': email,
      'password': password,
    }).then((value) {
      print(value.data);
      shopModel = ShopModel.fromJson(value.data);
      token = shopModel.data!.token;
      emit(LoginSuccessState(shopModel));
    }).catchError((error) {
      emit(LoginFailedState());
      print(error.toString());
    });
  }
}
