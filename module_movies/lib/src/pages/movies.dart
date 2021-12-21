import 'package:flutter/material.dart';
import 'package:module_movies/src/controllers/movie_controller.dart';
import 'package:module_movies/src/pages/movie_details.dart';
import 'package:module_movies/src/widgets/movie_card.dart';
import 'package:module_movies/src/widgets/progress.dart';

class MoviePage extends StatefulWidget {
  const MoviePage({Key? key}) : super(key: key);

  @override
  _MoviePageState createState() => _MoviePageState();
}

class _MoviePageState extends State<MoviePage> {
  final _controller = MovieController();
  final _scrollController = ScrollController();
  int lastPage = 1;

  @override
  void initState() {
    super.initState();
    _initialize();
  }

  void _initialize() async {
    setState(() {
      _controller.loading = true;
    });

    await _controller.fetchMovies();

    setState(() {
      _controller.loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("AppSandler"),
        actions: [
          IconButton(onPressed: _initialize, icon: const Icon(Icons.refresh))
        ],
      ),
      body: _buildMovieGrid(),
    );
  }

  _buildMovieGrid() {
    if (_controller.loading) {
      return const Progress();
    }

    return GridView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(2),
      itemCount: _controller.moviesCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 2,
          crossAxisSpacing: 2,
          childAspectRatio: 0.65),
      itemBuilder: _buildMovieCard,
    );
  }

  Widget _buildMovieCard(context, index) {
    final movie = _controller.movies[index];

    return MovieCard(
        title: movie.title,
        posterPath: movie.posterPath,
        onTap: () => {
              // print(movie.id)
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => MovieDetailsPage(
                          movieId: movie.id,
                        )),
              ),
            });
  }
}
