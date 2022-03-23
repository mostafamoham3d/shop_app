import 'package:shop_app1/models/shop_user_model.dart';

abstract class SignUpStates {}

class SignUpInitialState extends SignUpStates {}

class SignUpLoadingState extends SignUpStates {}

class SignUpSuccessState extends SignUpStates {
  final ShopModel shopModel;
  SignUpSuccessState(this.shopModel);
}

class SignUpFailedState extends SignUpStates {}

class SignUpShowPassState extends SignUpStates {}

class SignUpHidePassState extends SignUpStates {}
