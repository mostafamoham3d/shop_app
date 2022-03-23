import 'package:shop_app1/models/shop_user_model.dart';
import 'package:shop_app1/models/toggle_favorite_model.dart';

abstract class ShopStates {}

class ShopInitialState extends ShopStates {}

class ShopChangeBottomNavState extends ShopStates {}

class ShopLoadingProductsState extends ShopStates {}

class ShopSuccessProductsState extends ShopStates {}

class ShopFailedProductsState extends ShopStates {}

class ShopSuccessCategoryState extends ShopStates {}

class ShopFailedCategoryState extends ShopStates {}

class ShopChangeFavoriteState extends ShopStates {}

class ShopSuccessChangeFavoriteState extends ShopStates {
  ToggleFavoriteModel model;
  ShopSuccessChangeFavoriteState(this.model);
}

class ShopFailedChangeFavoriteState extends ShopStates {}

class ShopSuccessGetFavoritesState extends ShopStates {}

class ShopFailedGetFavoritesState extends ShopStates {}

class ShopLoadingGetUserInfoState extends ShopStates {}

class GetCartLoadingState extends ShopStates {}

class GetCartSuccessState extends ShopStates {}

class GetCartErrorState extends ShopStates {}

class ToggleCartLoadingState extends ShopStates {}

class ToggleCartSuccessState extends ShopStates {}

class ToggleCartErrorState extends ShopStates {}

class DeleteCartLoadingState extends ShopStates {}

class DeleteCartSuccessState extends ShopStates {}

class DeleteCartErrorState extends ShopStates {}

class ShopSuccessUpdateUserState extends ShopStates {
  final ShopModel model;
  ShopSuccessUpdateUserState(this.model);
}

class ShopFailedUpdateUserState extends ShopStates {}

class ShopLoadingUpdateUserState extends ShopStates {}

class ShopSuccessGetUserInfoState extends ShopStates {
  final ShopModel model;
  ShopSuccessGetUserInfoState(this.model);
}

class ShopFailedGetUserInfoState extends ShopStates {}
