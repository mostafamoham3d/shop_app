import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shop_app1/cubit/search_cubit.dart';
import 'package:shop_app1/cubit/search_states.dart';
import 'package:shop_app1/cubit/shop_cubit.dart';
import 'package:shop_app1/screens/search_detail_screen.dart';

class SearchScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => SearchCubit(),
      child: BlocConsumer<SearchCubit, SearchStates>(
        listener: (BuildContext context, state) {},
        builder: (BuildContext context, state) {
          var cubit = SearchCubit.get(context);
          return Scaffold(
            appBar: AppBar(),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Form(
                key: formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'Search',
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(width: 2, color: Colors.blue),
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return 'Enter a product to search';
                        }
                      },
                      /* onChanged: (String? text) {
                        cubit.search(text);
                      },*/
                      onFieldSubmitted: (String? text) {
                        cubit.search(text);
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchLoadingState) LinearProgressIndicator(),
                    SizedBox(
                      height: 10,
                    ),
                    if (state is SearchSuccessState)
                      Expanded(
                        child: ListView.builder(
                            itemCount: cubit.searchModel!.data!.data!.length,
                            itemBuilder: (context, index) {
                              return Column(
                                children: [
                                  buildSearchItem(
                                      SearchCubit.get(context)
                                          .searchModel!
                                          .data!
                                          .data![index],
                                      context),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              );
                            }),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildSearchItem(model, context) => GestureDetector(
      onTap: () {
        Navigator.of(context).push(
            MaterialPageRoute(builder: (ctx) => SearchDetailScreen(model)));
      },
      child: Container(
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
                            '${model.image ?? ''}', //height: 200,

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
                      '${model.name ?? ''}',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                      ),
                      softWrap: true,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Spacer(),
                  Container(
                    margin: EdgeInsets.only(left: 5, top: 10),
                    child: Row(
                      children: [
                        Text(
                          '${model.price ?? ''}',
                          style: TextStyle(color: Colors.blue),
                        ),
                        SizedBox(
                          width: 8,
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
      ),
    );
