import 'dart:async';

import 'package:eskalink_technical_test/presentation/component/constant.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/berandaPage.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/bloc/data_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:eskalink_technical_test/injection.dart' as di;

class SplashScreen extends StatefulWidget{
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteBgPage,
      body: Center(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage(
                  'assets/logo_splashscreen.webp'
                ),
                height: 160.h,
                width: 260.w,
              ),
              SizedBox(
                height: 12.h,
              ),
              Text(
                "By. Muhammad Rienaldi",
                style: TextStyle(
                      fontSize: 16.sp, color: neutral60, fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    openSplashScreen();
  }

  openSplashScreen() async {
    var durasiSplash = const Duration(seconds: 3);
    return Timer(durasiSplash, () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => BlocProvider(
            create: (context) => di.locator<DataAPIBloc>()
            ..add(GetDataEvent()),
            child: BerandaPage(),
          ),
        )
      );
    });
  }

}