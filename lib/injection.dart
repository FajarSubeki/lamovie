import 'package:core/core.dart';

import 'package:get_it/get_it.dart';
import 'package:movies/presentation/blocs/now_playing/now_playing_movies_bloc.dart';
import 'package:movies/presentation/blocs/upcoming/upcoming_movies_bloc.dart';
import 'package:movies/presentation/blocs/popular/popular_movies_bloc.dart';
import 'package:movies/presentation/blocs/detail/detail_movie_bloc.dart';
import 'package:movies/domain/usecases/get_detail_movie.dart';
import 'package:movies/domain/usecases/get_upcoming_movies.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_popular_movies.dart';
import 'package:movies/domain/usecases/get_recommendation_movies.dart';
import 'package:movies/domain/usecases/get_review_movies.dart';
import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';
import 'package:tv_series/domain/usecases/get_popular_tv_series.dart';
import 'package:tv_series/domain/usecases/get_recommendation_tv_series.dart';
import 'package:tv_series/domain/usecases/get_review_tv_series.dart';
import 'package:tv_series/presentation/blocs/detail/detail_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/on_the_air/on_the_air_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/popular/popular_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/recommendation/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/review/review_tv_series_bloc.dart';
import 'package:core/data/repositories/movie_repository_impl.dart';
import 'package:core/data/repositories/tv_series_repository_impl.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:core/data/datasources/movie_remote_data_source.dart';
import 'package:core/data/datasources/tv_series_remote_data_source.dart';


final locator = GetIt.instance;

void init() {

  // bloc
  locator.registerFactory(() => NowPlayingMoviesBloc(locator()));
  locator.registerFactory(() => UpComingMoviesBloc(locator()));
  locator.registerFactory(() => PopularMoviesBloc(locator()));
  locator.registerFactory(
        () => DetailMovieBloc(
          getDetailMovie: locator(),
          getRecommendationMovies: locator(),
          getReviewMovies: locator(),
    ),
  );

  // bloc tv series
  locator.registerFactory(() => OnTheAirTvSeriesBloc(locator()));
  locator.registerFactory(() => PopularTvSeriesBloc(locator()));
  locator.registerFactory(() => DetailTvSeriesBloc(locator()));
  locator.registerFactory(() => RecommendationTvSeriesBloc(locator()));
  locator.registerFactory(() => ReviewTvSeriesBloc(locator()));


  // use case movies
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetUpcomingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetDetailMovie(locator()));
  locator.registerLazySingleton(() => GetRecommendationMovies(locator()));
  locator.registerLazySingleton(() => GetReviewMovies(locator()));

  // use case tv series
  locator.registerLazySingleton(() => GetOnTheAirTvSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTvSeries(locator()));
  locator.registerLazySingleton(() => GetDetailTvSeries(locator()));
  locator.registerLazySingleton(() => GetRecommendationTvSeries(locator()));
  locator.registerLazySingleton(() => GetReviewTvSeries(locator()));


  // repository
  locator.registerLazySingleton<MovieRepository>(
        () => MovieRepositoryImpl(
      remoteDataSource: locator()
    ),
  );
  locator.registerLazySingleton<TvSeriesRepository>(
        () => TvSeriesRepositoryImpl(
      remoteDataSource: locator()
    ),
  );

  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
          () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TvSeriesRemoteDataSource>(
          () => TvSeriesRemoteDataSourceImpl(client: locator()));

  // external
  locator.registerLazySingleton(() => HttpSSLPinning.client);
}
