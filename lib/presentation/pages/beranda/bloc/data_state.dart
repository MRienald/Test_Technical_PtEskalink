part of 'data_bloc.dart';

abstract class DataState extends Equatable {
  const DataState();
}

class DataLoadingState extends DataState {
  @override
  List<Object> get props => [];
}

class DataErrorState extends DataState {
  @override
  List<Object> get props => [];
}

class DataLoadedState extends DataState {
  final List<Data> listData;

  DataLoadedState({required this.listData});

  @override
  List<Object> get props => [listData];
}

class DataNoInternetState extends DataState {
  @override
  List<Object> get props => [];
}