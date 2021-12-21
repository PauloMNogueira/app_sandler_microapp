import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:module_about/src/core/api.dart';
import 'package:module_about/src/errors/person_error.dart';
import 'package:module_about/src/models/person_model.dart';

class PersonRepository {
  Dio _dio = Dio(kDioOptions);
  PersonRepository({Dio? dio}) {
    _dio = dio ?? Dio(kDioOptions);
  }

  Future<Either<PersonError, PersonModel>> fetchPerson() async {
    try {
      final response = await _dio.get('/person/19292');

      final model = PersonModel.fromMap(response.data);
      return Right(model);
    } on DioError catch (error) {
      print(['Erro DIO ==>', error]);
      if (error.response != null) {
        return Left(
            PersonRepositoryError(error.response!.data["status_message"]));
      } else {
        print("ERRO CAI AQUI?");
        return Left(PersonRepositoryError(kServerError));
      }
    } on Exception catch (error) {
      print("ERRO CAI AQUI? 2");
      return Left(PersonRepositoryError(error.toString()));
    }
  }
}
