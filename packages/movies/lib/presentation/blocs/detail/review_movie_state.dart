part of 'review_movie_bloc.dart';

class ReviewMovieState extends Equatable {
  final Review? review;
  final RequestState reviewState;
  final List<Review> reviews;
  final String message;

  const ReviewMovieState({
    required this.review,
    required this.reviewState,
    required this.reviews,
    required this.message,
  });

  @override
  List<Object?> get props {
    return [
      reviews,
      reviewState,
      reviews,
      message
    ];
  }

  ReviewMovieState copyWith({
    Review? review,
    RequestState? reviewState,
    List<Review>? reviews,
    String? message,
  }) {
    return ReviewMovieState(
      review: review ?? this.review,
      reviewState: reviewState ?? this.reviewState,
      reviews: reviews ?? this.reviews,
      message: message ?? this.message,
    );
  }

  factory ReviewMovieState.initial() {
    return const ReviewMovieState(
      review: null,
      reviewState: RequestState.empty,
      reviews: [],
      message: '',
    );
  }
}
