import 'package:dartz/dartz.dart';
import 'package:module_about/src/errors/person_error.dart';
import 'package:module_about/src/models/person_model.dart';
import 'package:module_about/src/repositories/person_repository.dart';

class PersonController {
  final _repository = PersonRepository();
  PersonModel? personModel;
  PersonError? personError;
  late bool loading = true;

  Future<Either<PersonError, PersonModel>> fetchPerson() async {
    final result = await _repository.fetchPerson();
    result.fold((error) {
      personError = error;
    }, (person) {
      personModel = person;
    });
    return result;
  }

  String splitBiography() {
    if (personModel!.biography.length > 300) {
      return '${personModel!.biography.substring(0, 347)}...';
    }
    return personModel!.biography;
  }
}
