part of 'data_bloc.dart';

abstract class DataEvent extends Equatable {
  const DataEvent();
}

class GetDataEvent extends DataEvent {

  GetDataEvent();

  @override
  List<Object> get props => [];
}