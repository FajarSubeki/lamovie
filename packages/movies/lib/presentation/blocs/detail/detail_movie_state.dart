part of 'detail_movie_bloc.dart';

class DetailMovieState extends Equatable {
  final MovieDetail? movieDetail;
  final RequestState movieDetailState;
  final List<Review> movieReviews;
  final RequestState movieReviewState;
  final List<Movie> movieRecommendations;
  final RequestState movieRecommendationsState;
  final String message;

  const DetailMovieState({
    required this.movieDetail,
    required this.movieDetailState,
    required this.movieReviews,
    required this.movieReviewState,
    required this.movieRecommendations,
    required this.movieRecommendationsState,
    required this.message,
  });

  @override
  List<Object?> get props {
    return [
      movieDetail,
      movieDetailState,
      movieReviews,
      movieReviewState,
      movieRecommendations,
      movieRecommendationsState,
      message,
    ];
  }

  DetailMovieState copyWith({
    MovieDetail? movieDetail,
    RequestState? movieDetailState,
    List<Review>? movieReviews,
    RequestState? movieReviewState,
    List<Movie>? movieRecommendations,
    RequestState? movieRecommendationsState,
    String? message,
  }) {
    return DetailMovieState(
      movieDetail: movieDetail ?? this.movieDetail,
      movieDetailState: movieDetailState ?? this.movieDetailState,
      movieReviews: movieReviews ?? this.movieReviews,
      movieReviewState:
      movieReviewState ?? this.movieReviewState,
      movieRecommendations: movieRecommendations ?? this.movieRecommendations,
      movieRecommendationsState:
          movieRecommendationsState ?? this.movieRecommendationsState,
      message: message ?? this.message,
    );
  }

  factory DetailMovieState.initial() {
    return const DetailMovieState(
      movieDetail: null,
      movieDetailState: RequestState.empty,
      movieReviews: [],
      movieReviewState: RequestState.empty,
      movieRecommendations: [],
      movieRecommendationsState: RequestState.empty,
      message: '',
    );
  }
}
