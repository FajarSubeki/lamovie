import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/review.dart';
import 'package:core/domain/entities/movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_detail_movie.dart';
import 'package:movies/domain/usecases/get_recommendation_movies.dart';
import 'package:movies/domain/usecases/get_review_movies.dart';

part 'detail_movie_event.dart';
part 'detail_movie_state.dart';

class DetailMovieBloc extends Bloc<DetailMovieEvent, DetailMovieState> {

  final GetDetailMovie getDetailMovie;
  final GetRecommendationMovies getRecommendationMovies;
  final GetReviewMovies getReviewMovies;

  DetailMovieBloc({
    required this.getDetailMovie,
    required this.getRecommendationMovies,
    required this.getReviewMovies
  }) : super(DetailMovieState.initial()) {
    on<FetchDetailMovie>((event, emit) async {
      emit(state.copyWith(movieDetailState: RequestState.loading));

      final id = event.id;

      final detailMovieResult = await getDetailMovie.execute(id);
      final recommendationMoviesResult =
          await getRecommendationMovies.execute(id);
      final reviewMoviesResult =
      await getReviewMovies.execute(id);

      detailMovieResult.fold(
        (failure) => emit(
          state.copyWith(
            movieDetailState: RequestState.error,
            message: failure.message,
          ),
        ),
        (movieDetail) {
          emit(
            state.copyWith(
              movieRecommendationsState: RequestState.loading,
              movieDetailState: RequestState.loaded,
              movieDetail: movieDetail,
            ),
          );
          recommendationMoviesResult.fold(
            (failure) => emit(
              state.copyWith(
                movieRecommendationsState: RequestState.error,
                message: failure.message,
              ),
            ),
            (movieRecommendations) {
              if (movieRecommendations.isEmpty) {
                emit(
                  state.copyWith(
                    movieRecommendationsState: RequestState.empty,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    movieRecommendationsState: RequestState.loaded,
                    movieRecommendations: movieRecommendations,
                  ),
                );
              }
            },
          );
          reviewMoviesResult.fold(
                (failure) => emit(
              state.copyWith(
                movieReviewState: RequestState.error,
                message: failure.message,
              ),
            ),
                (movieReviews) {
              if (movieReviews.isEmpty) {
                emit(
                  state.copyWith(
                    movieReviewState: RequestState.empty,
                  ),
                );
              } else {
                emit(
                  state.copyWith(
                    movieReviewState: RequestState.loaded,
                    movieReviews: movieReviews,
                  ),
                );
              }
            },
          );
        },
      );
    });

  }
}
