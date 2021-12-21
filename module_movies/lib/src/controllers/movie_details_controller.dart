import 'package:dartz/dartz.dart';
import 'package:module_movies/src/errors/movies_error.dart';
import 'package:module_movies/src/models/movie_details_model.dart';
import 'package:module_movies/src/repositories/movie_repository.dart';

class MovieDetailsController {
  final _repository = MovieRepository();
  MovieDetailModel? movieDetailsModel;
  late MovieError movieError;
  late bool loading = true;

  MovieDetailModel? get movie => movieDetailsModel;

  Future<Either<MovieError, MovieDetailModel>> fetchMovie(int id) async {
    final result = await _repository.fetchMovieById(id);
    result.fold(
        (error) => movieError = error, (movie) => movieDetailsModel = movie);
    return result;
  }
}
