import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app/home/movie.dart';
import 'package:movie_app/home/movies_exception.dart';

final movieServiceProvider = Provider<MovieService>((ref) {
  return MovieService(Dio());
});

class MovieService {
  final Dio _dio;

  MovieService(this._dio);

  Future<List<Movie>> getMovies() async {
    try {
      final Response response = await _dio.get(
          "https://api.themoviedb.org/3/movie/popular?api_key=${dotenv.env['SECRET_API_KEY']}&language=en-US&page=1");

      final results = List<Map<String, dynamic>>.from(response.data['results']);

      List<Movie> movies = results
          .map((movieData) => Movie.fromMap(movieData))
          .toList(growable: false);

      return movies;
    } on DioError catch (e) {
      throw MoviesException.fromDioError(e);
    }
  }
}
