
import 'package:dartz/dartz.dart';
import 'package:eskalink_technical_test/common/failure.dart';
import 'package:eskalink_technical_test/data/source/remote/getData.dart';

abstract class DataApiRepository{
  Future<Either<Failure, List<Data>>> getDataAPI();
}