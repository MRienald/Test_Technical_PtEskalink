import 'package:eskalink_technical_test/data/source/local/database/databaseHelper.dart';
import 'package:eskalink_technical_test/data/source/local/model/dataContacts.dart';
import 'package:eskalink_technical_test/presentation/component/constant.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/berandaPage.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/bloc/data_bloc.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/component/txtinput_component.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import 'package:eskalink_technical_test/injection.dart' as di;


YYDialog YYDialogSuccess(
    BuildContext context,
    String hintText) {
  return YYDialog().build(context)
    ..width = 340.w
    ..height = 231.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Image.asset(
        'assets/beranda/icon_success.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Success",
        style: TextStyle(
          fontSize: 18.sp, 
          color: neutral90, 
          fontWeight: FontWeight.w700
        ),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 8.h),
      child: Text(
        "$hintText data successful",
        style: TextStyle(
            fontSize: 14.sp, color: neutral60, fontWeight: FontWeight.w500),
      ),
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 27.h),
      child: GestureDetector(
        onTap: () {
          if(hintText == "Insert"){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => di.locator<DataAPIBloc>()
                  ..add(GetDataEvent()),
                  child: BerandaPage(),
                ),
              )
            );
          }else if(hintText == "Update"){
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => BlocProvider(
                  create: (context) => di.locator<DataAPIBloc>()
                  ..add(GetDataEvent()),
                  child: BerandaPage(),
                ),
              )
            );
          }
          
        },
        child: Container(
          width: 129.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
          child: Center(
            child: Text(
              "Done",
              style: TextStyle(
                  fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYWarningSameDataDialog(BuildContext context) {
  return YYDialog().build(context)
    ..width = 340.w
    ..height = 231.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Padding(
      padding: EdgeInsets.only(top: 12.h),
      child: Image.asset(
        'assets/beranda/icon_danger.png',
        width: 62.w,
        height: 62.h,
      ),
    ))
     ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Can't Input the same NIK!",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontSize: 18.sp, 
          color: neutral90, 
          fontWeight: FontWeight.w700
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..widget(Padding(
      padding: EdgeInsets.only(top: 27.h),
      child: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          width: 129.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
          child: Center(
            child: Text(
              "Back",
              style: TextStyle(
                  fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..show();
}

YYDialog YYDetailDataDialog(
  BuildContext context,
  DataContacts data,
  TextEditingController nikController,
  TextEditingController namaController,
  TextEditingController umurController,
  TextEditingController kotaController,
  ) {
  return YYDialog().build(context)
    ..width = 340.w
    ..height = 420.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..widget(Padding(
      padding: EdgeInsets.only(top: 32.h),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/beranda/avatar.jpg'),
        maxRadius: 75.w,
      )
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        data.nama + " | " + data.umur.toString() ,
        style: TextStyle(
          fontSize: 20.sp, 
          color: neutral90, 
          fontWeight: FontWeight.w700
        ),
      ),
    ))
    ..widget(Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 40.h, left: 20.w),
      child: Text(
        "NIK            :  "+ data.nik.toString(),
        style: TextStyle(
          fontSize: 18.sp, 
          color: neutral90, 
          fontWeight: FontWeight.w500
        ),
      ),
    ))
    ..widget(Container(
      alignment: Alignment.centerLeft,
      padding: EdgeInsets.only(top: 16.h, left: 20.w),
      child: Text(
        "Asal Kota :  "+ data.kota,
        style: TextStyle(
          fontSize: 18.sp, 
          color: neutral90, 
          fontWeight: FontWeight.w500
        ),
      ),
    ))
    ..widget(Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(top: 27.h, right: 20.w),
      child: GestureDetector(
        onTap: () {

          nikController.text = data.nik.toString();
          namaController.text = data.nama;
          umurController.text = data.umur.toString();
          kotaController.text = data.kota;

          Navigator.pop(context);
          YYUpdateDataDialog(context, nikController, namaController, umurController, kotaController);
        },
        child: Container(
          width: 129.w,
          height: 48.h,
          decoration: BoxDecoration(
              color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
          child: Center(
            child: Text(
              "Update",
              style: TextStyle(
                  fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..show();
}

YYDialog YYUpdateDataDialog(
  BuildContext context,
  TextEditingController nikController,
  TextEditingController namaController,
  TextEditingController umurController,
  TextEditingController kotaController,
  ) {
  return YYDialog().build(context)
    ..width = 360.w
    ..height = 600.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Update Contacts",
        style: TextStyle(
          fontSize: 24.sp, 
          color: neutral90, 
          fontWeight: FontWeight.w700
        ),
      )
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/beranda/avatar.jpg'),
        maxRadius: 40.w,
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral40),
        controller: nikController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        readOnly: true,
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert Name',
          ),
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral90),
        controller: namaController,
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert Name',
          ),
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral90),
        controller: umurController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert Name',
          ),
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral90),
        controller: kotaController,
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert Name',
          ),
      )
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..widget(Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async{
              Logger().e(namaController.text);
              Logger().e(nikController.text);
              Logger().e(umurController.text);
              Logger().e(kotaController.text);
              await DatabaseHelper.instance.update(
                DataContacts(
                  nik: int.parse(nikController.text), 
                  nama: namaController.text, 
                  umur: int.parse(umurController.text), 
                  kota: kotaController.text
                )
              );
              Navigator.pop(context);
              YYDialogSuccess(context, "Update");
            },
            child: Container(
              width: 129.w,
              height: 48.h,
              decoration: BoxDecoration(
                  color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
              child: Center(
                child: Text(
                  "Update",
                  style: TextStyle(
                      fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 129.w,
              height: 48.h,
              decoration: BoxDecoration(
                  color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
              child: Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    ))
    ..show();
}

YYDialog YYInsertDataDialog(
  BuildContext context,
  TextEditingController nikController,
  TextEditingController namaController,
  TextEditingController umurController,
  TextEditingController kotaController,
  ) {
  return YYDialog().build(context)
    ..width = 360.w
    ..height = 600.h
    ..backgroundColor = whiteBgPage
    ..borderRadius = 10.0
    ..showCallBack = () {
      print("showCallBack invoke");
    }
    ..barrierDismissible = false
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h),
      child: Text(
        "Create New Contacts",
        style: TextStyle(
          fontSize: 24.sp, 
          color: neutral90, 
          fontWeight: FontWeight.w700
        ),
      )
    ))
    ..widget(Padding(
      padding: EdgeInsets.only(top: 40.h),
      child: CircleAvatar(
        backgroundImage: AssetImage('assets/beranda/avatar.jpg'),
        maxRadius: 40.w,
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral90),
        controller: nikController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert NIK',
          ),
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral90),
        controller: namaController,
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert Name',
          ),
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral90),
        controller: umurController,
        keyboardType: TextInputType.number,
        inputFormatters: <TextInputFormatter>[
          FilteringTextInputFormatter.digitsOnly
        ],
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert Age',
          ),
      )
    ))
    ..widget(Container(
      padding: EdgeInsets.only(top: 16.h, left: 32.w, right: 32.w),
      child: TextFormField(
        style: hintTextStyle.copyWith(color: neutral90),
        controller: kotaController,
        decoration: inputDecorationTextInput(
            color: neutral40,
            hintText: 'Insert City',
          ),
      )
    ))
    ..animatedFunc = (child, animation) {
      return ScaleTransition(
        child: child,
        scale: Tween(begin: 0.0, end: 1.0).animate(animation),
      );
    }
    ..widget(Padding(
      padding: EdgeInsets.only(top: 60.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () async{
              var response = DatabaseHelper.instance.getDataContactsByNIK(int.parse(nikController.text));
              response.then((value) async {
                if(value.isEmpty){
                  if(
                    nikController.text.isNotEmpty &&
                    namaController.text.isNotEmpty &&
                    umurController.text.isNotEmpty &&
                    kotaController.text.isNotEmpty
                  ){
                    await DatabaseHelper.instance.add(
                      DataContacts(
                        nik: int.parse(nikController.text), 
                        nama: namaController.text, 
                        umur: int.parse(umurController.text), 
                        kota: kotaController.text
                      )
                    );
                  }

                  Navigator.pop(context);
                  YYDialogSuccess(context, "Insert");
                }else{
                  Navigator.pop(context);
                  YYWarningSameDataDialog(context);
                }
              });
              
            },
            child: Container(
              width: 129.w,
              height: 48.h,
              decoration: BoxDecoration(
                  color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
              child: Center(
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
          SizedBox(
            width: 20.w,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              width: 129.w,
              height: 48.h,
              decoration: BoxDecoration(
                  color: biruMuda2, borderRadius: BorderRadius.circular(5.r)),
              child: Center(
                child: Text(
                  "Cancel",
                  style: TextStyle(
                      fontSize: 16.sp, color: white, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ),
        ],
      ),
    ))
    ..show();
}