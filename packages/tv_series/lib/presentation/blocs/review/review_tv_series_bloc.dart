import 'package:core/domain/entities/review.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_review_tv_series.dart';

part 'review_tv_series_event.dart';
part 'review_tv_series_state.dart';

class ReviewTvSeriesBloc
    extends Bloc<ReviewTvSeriesEvent, ReviewTvSeriesState> {
  final GetReviewTvSeries _getReviewTvSeries;

  ReviewTvSeriesBloc(this._getReviewTvSeries)
      : super(ReviewTvSeriesEmpty()) {
    on<FetchReviewTvSeries>((event, emit) async {
      emit(ReviewTvSeriesLoading());

      final id = event.id;
      final result = await _getReviewTvSeries.execute(id);

      result.fold(
            (failure) => emit(ReviewTvSeriesError(failure.message)),
            (data) {
          if (data.isEmpty) {
            emit(ReviewTvSeriesEmpty());
          } else {
            emit(ReviewTvSeriesHasData(data));
          }
        },
      );
    });
  }
}
