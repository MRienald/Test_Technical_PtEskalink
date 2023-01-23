import 'package:eskalink_technical_test/presentation/pages/beranda/berandaPage.dart';
import 'package:eskalink_technical_test/presentation/pages/splashScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:eskalink_technical_test/injection.dart' as di;

void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown, ]
  ).then((a)=>runApp(MyApp()));

  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(390, 844),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child){
        return MaterialApp(
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
          debugShowCheckedModeBanner: false,
        );
      },
      child: SplashScreen(),
    );
  }
}