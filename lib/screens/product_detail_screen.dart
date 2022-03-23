import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/cubit/shop_cubit.dart';
import 'package:shop_app1/cubit/shop_states.dart';
import 'package:shop_app1/models/home_model.dart';

class ProductDetailScreen extends StatelessWidget {
  final Product model;

  ProductDetailScreen(this.model);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          body: CustomScrollView(
            slivers: [
              SliverAppBar(
                actions: [
                  IconButton(
                    icon: Icon(
                      cubit.cart[model.id]!
                          ? Icons.shopping_cart_rounded
                          : Icons.shopping_cart_outlined,
                      color: Colors.black,
                      size: 30,
                    ),
                    onPressed: () {
                      cubit.toggleCart(model.id);
                    },
                  ),
                ],
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                pinned: false,
                floating: true,
                snap: true,
                expandedHeight: 300,
                flexibleSpace: FlexibleSpaceBar(
                  title: Container(
                    color: Colors.black.withOpacity(0.5),
                    child: Text(
                      '${model.name}',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  background: CarouselSlider(
                    items: model.images!.map((e) {
                      return Image(
                        image: NetworkImage('$e'),
                        fit: BoxFit.cover,
                        width: double.infinity,
                      );
                    }).toList(),
                    options: CarouselOptions(
                        height: 325,
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
                ),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    height: 20,
                    width: double.infinity,
                    child: Text(
                      '${model.price} \$',
                      textAlign: TextAlign.left,
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                  [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey.withOpacity(0.6),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        padding: EdgeInsets.all(10),
                        child: Text(
                          '${model.description}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
