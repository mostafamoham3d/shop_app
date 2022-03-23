import 'package:shop_app1/models/shop_user_model.dart';

abstract class LoginStates {}

class LoginInitialState extends LoginStates {}

class LoginLoadingState extends LoginStates {}

class LoginSuccessState extends LoginStates {
  final ShopModel shopModel;
  LoginSuccessState(this.shopModel);
}

class LoginFailedState extends LoginStates {}

class LoginShowPassState extends LoginStates {}

class LoginHidePassState extends LoginStates {}
