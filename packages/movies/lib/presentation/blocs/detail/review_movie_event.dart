part of 'review_movie_bloc.dart';

abstract class ReviewMovieEvent extends Equatable {
  const ReviewMovieEvent();
}

class FetchReviewMovie extends ReviewMovieEvent {
  final int id;

  const FetchReviewMovie(this.id);

  @override
  List<Object?> get props => [id];
}
