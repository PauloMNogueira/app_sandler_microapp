import 'package:dartz/dartz.dart';
import 'package:module_movies/src/errors/movies_error.dart';
import 'package:module_movies/src/models/movies_model.dart';
import 'package:module_movies/src/models/movies_response_model.dart';
import 'package:module_movies/src/repositories/movie_repository.dart';

class MovieController {
  final _repository = MovieRepository();
  MovieResponseModel? movieResponseModel;
  late MovieError movieError;
  late bool loading = true;
  late int moviesCount = movieResponseModel!.movies!.length;

  List<MovieModel> get movies => movieResponseModel!.movies ?? <MovieModel>[];

  Future<Either<MovieError, MovieResponseModel>> fetchMovies() async {
    final result = await _repository.fetchAllMovies();
    result.fold(
        (error) => movieError = error, (movies) => movieResponseModel = movies);
    return result;
  }
}
