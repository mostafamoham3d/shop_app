import 'dart:math' as math;

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shop_app1/cubit/shop_cubit.dart';
import 'package:shop_app1/cubit/shop_states.dart';
import 'package:shop_app1/models/category_model.dart';
import 'package:shop_app1/models/home_model.dart';
import 'package:shop_app1/screens/product_detail_screen.dart';

class ShopHomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {
        if (state is ShopSuccessChangeFavoriteState) {
          if (!state.model.status!) {
            Fluttertoast.showToast(
                msg: "${state.model.message}",
                toastLength: Toast.LENGTH_LONG,
                gravity: ToastGravity.CENTER,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.red,
                textColor: Colors.white,
                fontSize: 16.0);
          }
        }
      },
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          body: (cubit.homeModel != null && cubit.categoryModel != null)
              ? buildHomeScreen(cubit.homeModel, cubit.categoryModel)
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }
}

Widget buildHomeScreen(HomeModel? model, CategoryModel? categoryModel) {
  return SingleChildScrollView(
    physics: BouncingScrollPhysics(),
    child: Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          CarouselSlider(
            items: model!.data!.banners!.map((e) {
              return Image(
                image: NetworkImage('${e.image}'),
                fit: BoxFit.cover,
                width: double.infinity,
              );
            }).toList(),
            options: CarouselOptions(
                height: 200,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: true,
                autoPlayInterval: Duration(seconds: 3),
                autoPlayAnimationDuration: Duration(seconds: 1),
                autoPlayCurve: Curves.fastOutSlowIn,
                scrollDirection: Axis.horizontal,
                viewportFraction: 1),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            'Categories',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Container(
            height: 100,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: categoryModel!.data!.data!.length,
              itemBuilder: (context, index) {
                return buildCategoryItem(categoryModel.data!.data![index]);
              },
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            'New Products',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: model.data!.products!.length,
            itemBuilder: (context, index) {
              return buildCardItem(model.data!.products![index], context);
            },
          ),
        ],
      ),
    ),
  );
}

Widget buildCardItem(Product model, context) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => ProductDetailScreen(model)));
      },
      child: Container(
        width: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15),
          ),
          elevation: 4,
          margin: EdgeInsets.all(10),
          child: Column(
            children: [
              Expanded(
                child: Stack(
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
                    if (model.discount != 0)
                      Positioned(
                        top: 10,
                        left: 0,
                        child: Transform.rotate(
                          angle: -math.pi / 4,
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.red,
                            ),
                            padding: EdgeInsets.all(1),
                            child: Text(
                              'Discount',
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              // Padding(

              //   padding: EdgeInsets.all(8.0),

              //   child: Row(

              //     mainAxisAlignment: MainAxisAlignment.spaceAround,

              //     children: [

              //       Row(

              //         children: [

              //           Icon(Icons.schedule),

              //           SizedBox(

              //             width: 6,

              //           ),

              //           Text('$duration min'),

              //         ],

              //       ),

              //       Row(

              //         children: [

              //           Icon(Icons.work),

              //           SizedBox(

              //             width: 6,

              //           ),

              //           Text('$complexityText'),

              //         ],

              //       ),

              //       Row(

              //         children: [

              //           Icon(Icons.attach_money),

              //           SizedBox(

              //             width: 6,

              //           ),

              //           Text('$affordabilityText'),

              //         ],

              //       ),

              //     ],

              //   ),

              // ),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 150,
                    color: Colors.black.withOpacity(0.8),
                    child: Text(
                      '${model.name}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      maxLines: 2,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
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
            ],
          ),
        ),
      ),
    );

Widget buildCategoryItem(Datum model) => Row(
      children: [
        Container(
          height: 100,
          width: 100,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image(
                height: 100,
                width: 100,
                image: NetworkImage(
                  '${model.image}',
                ),
                fit: BoxFit.cover,
              ),
              Container(
                color: Colors.black.withOpacity(0.8),
                width: double.infinity,
                child: Text(
                  '${model.name}',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
