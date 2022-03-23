import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shop_app1/models/onboard_model.dart';
import 'package:shop_app1/modules/reusable_components.dart';
import 'package:shop_app1/screens/log_in_screen.dart';
import 'package:shop_app1/shared_prefs/shared_prefernces.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget {
  @override
  _OnBoardingScreenState createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  List<OnBoardModel> onBoardingList = [
    OnBoardModel(
      image: 'assets/images/onboard_1.jpg',
      title: 'Screen1',
      text: 'text',
    ),
    OnBoardModel(
      image: 'assets/images/onboard_2.jpg',
      title: 'Screen2',
      text: 'text',
    ),
    OnBoardModel(
      image: 'assets/images/onboard_3.jpg',
      title: 'Screen3',
      text: 'text',
    ),
  ];
  int _currentPage = 0;
  PageController _pageController = PageController(
    initialPage: 0,
  );
  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(seconds: 5), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        SharedPrefs.setData(key: 'onBoarding', value: true).then((value) {
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => LogInScreen()));
        });
      }

      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 350),
        curve: Curves.easeIn,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView.builder(
                itemCount: onBoardingList.length,
                controller: _pageController,
                itemBuilder: (context, index) {
                  return onBoardingItem(context, onBoardingList[index]);
                }),
          ),
          Padding(
            padding:
                const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 20.0),
            child: Row(
              children: [
                SmoothPageIndicator(
                  controller: _pageController,
                  count: 3,
                  effect: WormEffect(),
                ),
                Spacer(),
                FloatingActionButton(
                  onPressed: () {
                    Navigator.of(context).pushReplacement(
                        MaterialPageRoute(builder: (context) => LogInScreen()));
                  },
                  child: Icon(Icons.arrow_forward_ios),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
