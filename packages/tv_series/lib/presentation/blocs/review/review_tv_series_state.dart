part of 'review_tv_series_bloc.dart';

abstract class ReviewTvSeriesState extends Equatable {
  const ReviewTvSeriesState();

  @override
  List<Object?> get props => [];
}

class ReviewTvSeriesEmpty extends ReviewTvSeriesState {}

class ReviewTvSeriesLoading extends ReviewTvSeriesState {}

class ReviewTvSeriesError extends ReviewTvSeriesState {
  final String message;

  const ReviewTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class ReviewTvSeriesHasData extends ReviewTvSeriesState {
  final List<Review> result;

  const ReviewTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}