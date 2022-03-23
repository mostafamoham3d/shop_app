import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/cubit/shop_cubit.dart';
import 'package:shop_app1/cubit/shop_states.dart';
import 'package:shop_app1/models/category_model.dart';

class CategoriesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ShopCubit, ShopStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var cubit = ShopCubit.get(context);
        return Scaffold(
          body: Container(
            padding: EdgeInsets.all(10),
            child: ListView.builder(
                itemCount: cubit.categoryModel!.data!.data!.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      buildCategoryScreenItem(
                          cubit.categoryModel!.data!.data![index]),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  );
                }),
          ),
        );
      },
    );
  }
}

Widget buildCategoryScreenItem(Datum model) => Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.grey.withOpacity(0.6),
      ),
      padding: EdgeInsets.all(20),
      child: ListTile(
        leading: Image(
          // height: 100,
          // width: 100,
          image: NetworkImage('${model.image}'),
          fit: BoxFit.cover,
        ),
        title: Text('${model.name}'),
        trailing: IconButton(
          onPressed: () {},
          icon: Icon(CupertinoIcons.forward),
        ),
      ),
    );
