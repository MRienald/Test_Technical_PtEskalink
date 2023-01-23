import 'package:eskalink_technical_test/common/internetCheck.dart';
import 'package:eskalink_technical_test/data/repositories/getDataRepositoryImpl.dart';
import 'package:eskalink_technical_test/domain/repositories/dataAPIRepository.dart';
import 'package:eskalink_technical_test/domain/usecases/getData/getDataAPI.dart';
import 'package:eskalink_technical_test/presentation/pages/beranda/bloc/data_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:logger/logger.dart';
import 'package:http/http.dart' as http;

final locator = GetIt.instance;

void init() {
  initRepository();
  initUseCase();
  initBloc();

  // external
  locator.registerLazySingleton(() => http.Client());
  locator.registerLazySingleton(() => Logger());
  locator.registerLazySingleton(() => InternetCheck());
}

void initRepository() {
  locator.registerLazySingleton<DataApiRepository>(
    () => GetDataRepositoryImpl(
      client: locator()
      )
  );
}

void initUseCase() {
  locator.registerLazySingleton(() => GetDataAPI(locator()));
}

void initBloc() {
  locator.registerFactory(
    () => DataAPIBloc(
      getDataAPIUsecase: locator()
    )
  );
}