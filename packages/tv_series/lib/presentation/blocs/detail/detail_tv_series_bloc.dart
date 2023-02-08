import 'package:core/core.dart';

import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:core/domain/entities/review.dart';

import 'package:tv_series/domain/usecases/get_detail_tv_series.dart';
import 'package:movies/domain/usecases/get_review_movies.dart';

part 'detail_tv_series_event.dart';
part 'detail_tv_series_state.dart';

class DetailTvSeriesBloc
    extends Bloc<DetailTvSeriesEvent, DetailTvSeriesState> {
  final GetDetailTvSeries _getDetailTvSeries;

  DetailTvSeriesBloc(
      this._getDetailTvSeries
  ) : super(DetailTvSeriesEmpty()) {
    on<FetchDetailTvSeries>((event, emit) async {
      emit(DetailTvSeriesLoading());

      final id = event.id;
      final result = await _getDetailTvSeries.execute(id);

      result.fold(
        (failure) => emit(DetailTvSeriesError(failure.message)),
        (data) => emit(DetailTvSeriesHasData(data)),

      );

    });
  }
}
