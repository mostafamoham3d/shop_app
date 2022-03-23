import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shop_app1/cubit/shop_cubit.dart';
import 'package:shop_app1/dio/dio_helper.dart';
import 'package:shop_app1/screens/log_in_screen.dart';
import 'package:shop_app1/screens/onboarding_screen.dart';
import 'package:shop_app1/screens/shop_layout.dart';
import 'package:shop_app1/shared_prefs/shared_prefernces.dart';

import 'constants/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  DioHelper.init();
  Bloc.observer = MyBlocObserver();
  await SharedPrefs.init();
  token = SharedPrefs.getData('token') ?? null;
  print(token);
  bool isOnBoardingFinished = SharedPrefs.getData('onBoarding') ?? false;
  Widget startScreen;
  if (isOnBoardingFinished) {
    if (token != null) {
      startScreen = ShopMainScreen();
    } else {
      startScreen = LogInScreen();
    }
  } else {
    startScreen = OnBoardingScreen();
  }
  runApp(MyApp(startScreen));
}

class MyApp extends StatelessWidget {
  final Widget startScreen;
  MyApp(this.startScreen);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ShopCubit()
            ..getProducts()
            ..getCategory()
            ..getFavorites()
            ..getUserData()
            ..getCart(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          textTheme: TextTheme(
            bodyText1: TextStyle(
                fontSize: 18, fontWeight: FontWeight.w600, color: Colors.black),
          ),
          iconTheme: IconThemeData(
            color: Colors.black,
          ),
          primarySwatch: Colors.blue,
          bottomNavigationBarTheme: BottomNavigationBarThemeData(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.blue,
            elevation: 20,
          ),
          fontFamily: GoogleFonts.balsamiqSans().fontFamily,
        ),
        home: startScreen,
      ),
    );
  }
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
}
