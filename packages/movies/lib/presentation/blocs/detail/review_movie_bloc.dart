import 'package:core/core.dart';
import 'package:core/domain/entities/review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_review_movies.dart';

part 'review_movie_event.dart';
part 'review_movie_state.dart';

class ReviewMovieBloc extends Bloc<ReviewMovieEvent, ReviewMovieState> {

  final GetReviewMovies getReviewMovies;

  ReviewMovieBloc({
    required this.getReviewMovies,
  }) : super(ReviewMovieState.initial()) {
    on<FetchReviewMovie>((event, emit) async {
      emit(state.copyWith(reviewState: RequestState.loading));

      final id = event.id;

      final reviewMovieResult = await getReviewMovies.execute(id);

      reviewMovieResult.fold(
            (failure) => emit(
          state.copyWith(
            reviewState: RequestState.error,
            message: failure.message,
          ),
        ),
            (movieReviews) {
          if (movieReviews.isEmpty) {
            emit(
              state.copyWith(
                reviewState: RequestState.empty,
              ),
            );
          } else {
            emit(
              state.copyWith(
                reviewState: RequestState.loaded,
                reviews: movieReviews,
              ),
            );
          }
        },
      );

    });

  }
}
