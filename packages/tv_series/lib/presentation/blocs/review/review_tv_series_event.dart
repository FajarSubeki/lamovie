part of 'review_tv_series_bloc.dart';

abstract class ReviewTvSeriesEvent extends Equatable {
  const ReviewTvSeriesEvent();
}

class FetchReviewTvSeries extends ReviewTvSeriesEvent {
  final int id;

  const FetchReviewTvSeries(this.id);

  @override
  List<Object?> get props => [id];
}
