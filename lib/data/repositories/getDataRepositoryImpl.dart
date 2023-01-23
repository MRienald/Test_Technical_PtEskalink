import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:eskalink_technical_test/common/baseURL.dart';
import 'package:eskalink_technical_test/common/failure.dart';
import 'package:eskalink_technical_test/data/source/remote/getData.dart';
import 'package:eskalink_technical_test/domain/repositories/dataAPIRepository.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

class GetDataRepositoryImpl implements DataApiRepository {

  final http.Client client;

  GetDataRepositoryImpl({required this.client});

  @override
  Future<Either<Failure, List<Data>>> getDataAPI() async{
    var uri = Uri.parse(url);
    var response = await client.get(uri);

    if(response.statusCode == 200){
      String jsonDataString = response.body.toString();
      var jsonData = jsonDecode(jsonDataString);
      Logger().i(jsonData);
      return Right(DataAPI.fromJson(jsonData).data);
    }else{
      return left(ServerFailure(''));
    }
  }
    
}