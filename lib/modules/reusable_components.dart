import 'package:flutter/material.dart';
import 'package:shop_app1/models/onboard_model.dart';

Widget onBoardingItem(BuildContext context, OnBoardModel model) => Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        //mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image(
            image: AssetImage(model.image),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            model.title,
            style: Theme.of(context)
                .textTheme
                .headline3!
                .copyWith(color: Colors.black),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            model.text,
            style:
                Theme.of(context).textTheme.bodyText1!.copyWith(fontSize: 20),
          ),
        ],
      ),
    );
