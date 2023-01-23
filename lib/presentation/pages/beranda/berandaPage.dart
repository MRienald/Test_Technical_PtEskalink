import 'package:eskalink_technical_test/data/source/local/database/databaseHelper.dart';
import 'package:eskalink_technical_test/data/source/local/model/dataContacts.dart';
import 'package:eskalink_technical_test/data/source/remote/getData.dart';
import 'package:eskalink_technical_test/presentation/component/constant.dart';
import 'package:eskalink_technical_test/presentation/component/customAppBar.dart';
import 'package:eskalink_technical_test/presentation/component/noInternet.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/bloc/data_bloc.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/component/dialog_component.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:logger/logger.dart';

import 'package:eskalink_technical_test/injection.dart' as di;

class BerandaPage extends StatefulWidget{

  _BerandaPageState createState() => _BerandaPageState();
}

class _BerandaPageState extends State<BerandaPage>{

  late DataAPIBloc _dataBloc;

  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = GlobalKey<RefreshIndicatorState>();

  TextEditingController _nikTextController = TextEditingController();
  TextEditingController _namaTextController = TextEditingController();
  TextEditingController _umurTextController = TextEditingController();
  TextEditingController _kotaTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DataAPIBloc, DataState>(
      builder: (((context, state) {
        if(state is DataLoadedState){
          return Scaffold(
            backgroundColor: whiteBgPage,
            appBar: CustomAppBar(
                title: "Contacts",
                actions: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _nikTextController.clear();
                        _namaTextController.clear();
                        _umurTextController.clear();
                        _kotaTextController.clear();
                      });

                      YYInsertDataDialog(
                        context,
                        _nikTextController,
                        _namaTextController,
                        _umurTextController,
                        _kotaTextController,
                      );
                    },
                    child: Container(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.only(right: 10.w),
                      height: 40.h,
                      width: 40.w,
                      child:Image.asset(
                        'assets/beranda/ic_edit.png',
                        height: 24.h,
                        width: 24.w,
                      ),
                    ),
                  )
                ],
              ),
            body: Container(
              child: FutureBuilder<List<DataContacts>>(
                future: DatabaseHelper.instance.getDataContacts(),
                builder: (BuildContext context, AsyncSnapshot<List<DataContacts>> snapshot){
                  if(!snapshot.hasData){
                    return Center(child: Text("Loading..."));
                  }
                  return snapshot.data!.isEmpty
                  ? Center(child: Text("No Data"),)
                  : Container(
                    padding: EdgeInsets.only(top: 20.h),
                      child: _body(context, snapshot.data!)
                    );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () async {
                for(int i=0; i<state.listData.length; i++){
                  await DatabaseHelper.instance.add(
                    DataContacts(
                      nik: int.parse(state.listData[i].nik), 
                      nama: state.listData[i].nama, 
                      umur: state.listData[i].umur, 
                      kota: state.listData[i].kota,
                    )
                  );
                }
                setState(() {
                  _nikTextController.clear();
                  _namaTextController.clear();
                  _umurTextController.clear();
                  _kotaTextController.clear();
                });
              },
              icon: Icon(Icons.refresh),
              label: Text(
                "Refresh Data",
                style: TextStyle(
                      color: white, fontWeight: FontWeight.w400),
              ),
              backgroundColor: neutral40,
            ),
          );
        }else if(state is DataNoInternetState){
          return Container(
            child: Scaffold(
              backgroundColor: whiteBgPage,
              appBar: CustomAppBar(
                title: "Contacts",
              ),
              body: RefreshIndicator(
                key: _refreshIndicatorKey,
                color: Colors.white,
                backgroundColor: Colors.blue,
                strokeWidth: 4.0,
                onRefresh: () async{ 
                  return Future<void>.delayed(const Duration(seconds: 2)).then((value) {
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
                 },
                child:  NoInternet(
                  onPressed: () async{
                    _refreshIndicatorKey.currentState?.show();
                  },
                  buttonHide: false,
                )
              )
            )
          );
        }else if(state is DataLoadingState){
          return Container(
            child: Scaffold(
              backgroundColor: whiteBgPage,
              appBar: CustomAppBar(
                title: "Contacts",
              ),
              body: Container(
                child:  Center(child: CircularProgressIndicator(color: blueLinear1)),
              )
            )
          );
        }else{
          return Scaffold(
            backgroundColor: whiteBgPage,
            appBar: CustomAppBar(
                title: "Contacts",
              ),
            body: Container(
              alignment: Alignment.center,
              child: Text("Error"),
            ),
          );
        }
      })),
    );
  }

  Widget _body(BuildContext context, List<DataContacts> listData){
    return ListView.builder(
      itemCount: listData.length,
      itemBuilder: (BuildContext context, int i){
        return Container(
          padding: EdgeInsets.symmetric(vertical: 5.h),
          child: GestureDetector(
            onTap: () {
              YYDetailDataDialog(
                context, 
                listData[i],
                _nikTextController,
                _namaTextController,
                _umurTextController,
                _kotaTextController,
              );
              setState(() {
                _nikTextController.clear();
                _namaTextController.clear();
                _umurTextController.clear();
                _kotaTextController.clear();
              });
            },
            child: Card(
              color: whiteBgPage,
              child: ListTile(
                leading: Icon(
                  Icons.account_circle,
                  size: 40.w,
                ),
                title: Text(
                  listData[i].nama,
                  style: TextStyle(
                      fontSize: 16.sp, color: neutral50, fontWeight: FontWeight.w600),
                ),
                trailing: GestureDetector(
                  onTap: () {
                    setState(() {   
                      DatabaseHelper.instance.remove(listData[i].nik);
                    });
                  },
                  child: Icon(Icons.close),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

}