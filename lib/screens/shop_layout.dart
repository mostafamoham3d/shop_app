import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/cubit/shop_cubit.dart';
import 'package:shop_app1/cubit/shop_states.dart';
import 'package:shop_app1/screens/cart_screen.dart';
import 'package:shop_app1/screens/search_Screen.dart';

class ShopMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('Salla'),
            actions: [
              (cubit.currentIndex == 0 ||
                      cubit.currentIndex == 1 ||
                      cubit.currentIndex == 2)
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => SearchScreen()));
                            },
                            icon: Icon(Icons.search),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => CartScreen()));
                            },
                            child: Badge(
                              animationType: BadgeAnimationType.scale,
                              badgeContent: Text(
                                  '${cubit.cartModel != null ? cubit.cartModel!.data!.cartItems!.length : 0}'),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              // badgeColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              cubit.logOut(context);
                            },
                            icon: Icon(Icons.exit_to_app),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (ctx) => CartScreen()));
                            },
                            child: Badge(
                              animationType: BadgeAnimationType.scale,
                              badgeContent: Text(
                                  '${cubit.cartModel != null ? cubit.cartModel!.data!.cartItems!.length : 0}'),
                              child: Icon(
                                Icons.shopping_cart,
                                color: Colors.white,
                              ),
                              //badgeColor: Colors.black,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeIndex(index);
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.grid_on_outlined),
                label: 'Categories',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.favorite),
                label: 'Favorites',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: 'Settings',
              ),
            ],
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
