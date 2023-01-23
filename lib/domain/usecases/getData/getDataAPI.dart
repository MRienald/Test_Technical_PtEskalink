
import 'package:dartz/dartz.dart';
import 'package:eskalink_technical_test/common/failure.dart';
import 'package:eskalink_technical_test/data/source/remote/getData.dart';
import 'package:eskalink_technical_test/domain/repositories/dataAPIRepository.dart';

class GetDataAPI{
  final DataApiRepository repository;

  GetDataAPI(this.repository);

  Future<Either<Failure, List<Data>>> execute(){
    return repository.getDataAPI();
  }
}