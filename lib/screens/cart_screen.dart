import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/cubit/shop_cubit.dart';
import 'package:shop_app1/cubit/shop_states.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          appBar: AppBar(),
          body: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              children: [
                Expanded(
                  child: ListView.builder(
                      itemCount: cubit.cartModel != null
                          ? cubit.cartModel!.data!.cartItems!.length
                          : 0,
                      itemBuilder: (ctx, index) {
                        return Column(
                          children: [
                            buildCartItem(
                                cubit
                                    .cartModel!.data!.cartItems![index].product,
                                context),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        );
                      }),
                ),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Text('TOTAL AMOUNT : ${cubit.cartModel!.data!.total} \$'),
                    Spacer(),
                    TextButton(
                      onPressed: () {
                        cubit.deleteCart();
                      },
                      child: Text('ORDER NOW'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

Widget buildCartItem(model, context) => Container(
      height: 150,
      color: Colors.grey.withOpacity(0.2),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        //crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 150,
            height: 150,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              elevation: 4,
              margin: EdgeInsets.all(10),
              child: Column(
                children: [
                  Stack(
                    alignment: Alignment.bottomCenter,
                    children: [
                      ClipRRect(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(15),
                          topRight: Radius.circular(15),
                        ),
                        child: Image.network(
                          '${model.image}', //height: 200,
                          width: double.infinity,
                          height: 125,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(top: 30),
                  width: 150,
                  color: Colors.black.withOpacity(0.8),
                  child: Text(
                    '${model.name}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                    ),
                    softWrap: true,
                    maxLines: 5,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Spacer(),
                Container(
                  margin: EdgeInsets.only(left: 5, top: 10),
                  child: Row(
                    children: [
                      if (model.discount != 0)
                        Text(
                          '${model.price}',
                          style: TextStyle(color: Colors.blue),
                        ),
                      if (model.discount != 0)
                        SizedBox(
                          width: 8,
                        ),
                      Text(
                        '${model.oldPrice}',
                        style: TextStyle(
                            decoration: model.discount != 0
                                ? TextDecoration.lineThrough
                                : TextDecoration.none),
                      ),
                      Spacer(),
                      IconButton(
                          onPressed: () {
                            ShopCubit.get(context).toggleFavorites(model.id!);
                          },
                          icon: (ShopCubit.get(context).favorites[model.id]!)
                              ? Icon(
                                  Icons.favorite,
                                  color: Colors.red,
                                )
                              : Icon(Icons.favorite_border)),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
