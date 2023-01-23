import 'dart:async';
import 'dart:io';

import 'package:eskalink_technical_test/common/internetCheck.dart';
import 'package:eskalink_technical_test/data/source/remote/getData.dart';
import 'package:eskalink_technical_test/domain/usecases/getData/getDataAPI.dart';
import 'package:logger/logger.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'data_event.dart';

part 'data_state.dart';

class DataAPIBloc extends Bloc<DataEvent, DataState> {
  GetDataAPI getDataAPIUsecase;

  DataAPIBloc({
    required this.getDataAPIUsecase,

  }) : super(DataLoadingState()) {
    on<GetDataEvent>(_getData);
  }

  void _getData(
    GetDataEvent event, Emitter<DataState> emit
  ) async{
    final hasInternet = await InternetCheck().hasConnection();
    if(hasInternet){
      List<Data> listData = [];
      final resultUser = await getDataAPIUsecase.execute();

      resultUser.fold((failure){
        emit(DataErrorState());
      }, (response) {
        listData = response;
        Logger().i(response);
      });

      if(listData.isNotEmpty){
        emit(DataLoadedState(listData: listData));
      }else{
        emit(DataNoInternetState());
      }
    }else{
      emit(DataNoInternetState());
    }
  }

}