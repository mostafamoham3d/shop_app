import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app1/constants/constant.dart';
import 'package:shop_app1/cubit/shop_states.dart';
import 'package:shop_app1/dio/dio_helper.dart';
import 'package:shop_app1/models/category_model.dart';
import 'package:shop_app1/models/favorites_model.dart';
import 'package:shop_app1/models/get_cart_model.dart';
import 'package:shop_app1/models/home_model.dart';
import 'package:shop_app1/models/shop_user_model.dart';
import 'package:shop_app1/models/toggle_cart_item.dart';
import 'package:shop_app1/models/toggle_favorite_model.dart';
import 'package:shop_app1/screens/categories_screen.dart';
import 'package:shop_app1/screens/favorites_screen.dart';
import 'package:shop_app1/screens/home_screen.dart';
import 'package:shop_app1/screens/log_in_screen.dart';
import 'package:shop_app1/screens/settings_screen.dart';
import 'package:shop_app1/shared_prefs/shared_prefernces.dart';

class ShopCubit extends Cubit<ShopStates> {
  ShopCubit() : super(ShopInitialState());

  static ShopCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List<Widget> screens = [
    ShopHomeScreen(),
    CategoriesScreen(),
    FavoritesScreen(),
    SettingsScreen(),
  ];

  void changeIndex(index) {
    currentIndex = index;
    emit(ShopChangeBottomNavState());
  }

  Map<int?, bool?> favorites = {};
  Map<int?, bool?> cart = {};
  HomeModel? homeModel;
  CategoryModel? categoryModel;
  ToggleFavoriteModel? toggleFavoriteModel;
  void getProducts() {
    emit(ShopLoadingProductsState());
    DioHelper.getData(url: 'home', token: token).then((value) {
      emit(ShopSuccessProductsState());
      homeModel = HomeModel.fromJson(value.data);
      homeModel!.data!.products!.forEach((element) {
        favorites.addAll({element.id: element.inFavorites});
        cart.addAll({element.id: element.inCart});
      });
      print(favorites.toString());
      print(homeModel.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFailedProductsState());
    });
  }

  CartModel? cartModel;
  FavoritesModel? favoritesModel;
  void getCategory() {
    DioHelper.getData(url: 'categories').then((value) {
      emit(ShopSuccessCategoryState());
      categoryModel = CategoryModel.fromJson(value.data);
      print(homeModel.toString());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFailedCategoryState());
    });
  }

  void getCart() {
    emit(GetCartLoadingState());
    DioHelper.getData(url: 'carts', token: token).then((value) {
      emit(GetCartSuccessState());
      cartModel = CartModel.fromJson(value.data);
    }).catchError((error) {
      print(error);
      emit(GetCartErrorState());
    });
  }

  void getFavorites() {
    DioHelper.getData(url: 'favorites', token: token).then((value) {
      favoritesModel = FavoritesModel.fromJson(value.data);
      print(favoritesModel.toString());
      emit(ShopSuccessGetFavoritesState());
    }).catchError((error) {
      print(error.toString());
      emit(ShopFailedGetFavoritesState());
    });
  }

  void toggleFavorites(int productId) {
    favorites[productId] = !favorites[productId]!;
    emit(ShopChangeFavoriteState());
    DioHelper.sendData(
      url: 'favorites',
      data: {'product_id': productId},
      token: token,
    ).then((value) {
      toggleFavoriteModel = ToggleFavoriteModel.fromJson(value.data);
      if (!toggleFavoriteModel!.status!) {
        favorites[productId] = !favorites[productId]!;
      } else {
        getFavorites();
      }
      emit(ShopSuccessChangeFavoriteState(toggleFavoriteModel!));
    }).catchError((error) {
      favorites[productId] = !favorites[productId]!;
      emit(ShopFailedChangeFavoriteState());
    });
  }

  ShopModel? userModel;
  void getUserData() {
    emit(ShopLoadingGetUserInfoState());
    DioHelper.getData(url: 'profile', token: token).then((value) {
      userModel = ShopModel.fromJson(value.data);
      emit(ShopSuccessGetUserInfoState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopFailedGetUserInfoState());
    });
  }

  ToggleCartItem? toggleCartItem;
  void toggleCart(int? id) {
    cart[id] = !cart[id]!;
    emit(ToggleCartLoadingState());
    DioHelper.sendData(url: 'carts', data: {'product_id': id}, token: token)
        .then((value) {
      toggleCartItem = ToggleCartItem.fromJson(value.data);
      if (!toggleCartItem!.status!) {
        cart[id] = !cart[id]!;
      } else {
        getCart();
      }
      emit(ToggleCartSuccessState());
    }).catchError((error) {
      print(error);
      cart[id] = !cart[id]!;
      emit(ToggleCartErrorState());
    });
  }

  void deleteCart() {
    emit(DeleteCartLoadingState());
    DioHelper.deleteData(url: 'carts/2', token: token).then((value) {
      Fluttertoast.showToast(
          msg: "Items Have Been Purchased",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.CENTER,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
      emit(DeleteCartSuccessState());
    }).catchError((error) {
      emit(DeleteCartErrorState());
    });
  }

  void updateUserInfo({
    required String name,
    required String email,
    required String phone,
  }) {
    emit(ShopLoadingUpdateUserState());
    DioHelper.putData(url: 'update-profile', token: token, data: {
      'name': name,
      'email': email,
      'phone': phone,
    }).then((value) {
      if (value.data['status']) {
        userModel = ShopModel.fromJson(value.data);
      } else {
        Fluttertoast.showToast(
            msg: "${value.data['message']}",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            timeInSecForIosWeb: 1,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0);
      }
      emit(ShopSuccessUpdateUserState(userModel!));
    }).catchError((error) {
      print(error.toString());
      emit(ShopFailedUpdateUserState());
    });
  }

  void logOut(context) {
    SharedPrefs.removeData('token').then((value) {
      Navigator.of(context)
          .pushReplacement(MaterialPageRoute(builder: (ctx) => LogInScreen()));
      currentIndex = 0;
    });
  }
}
