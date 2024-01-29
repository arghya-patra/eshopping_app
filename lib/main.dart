import 'package:eshopping_app/views/splashScreen/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'consts/consts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //as we are using getX so MaterialApp=>getMaterialApp
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: appname,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.transparent,
          appBarTheme: AppBarTheme(backgroundColor: Colors.transparent),
          fontFamily: regular),
      home: const SplashScreen(),
    );
  }
}
