import 'package:core/domain/entities/tv_series.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/domain/usecases/get_on_the_air_tv_series.dart';

part 'on_the_air_tv_series_event.dart';
part 'on_the_air_tv_series_state.dart';

class OnTheAirTvSeriesBloc
    extends Bloc<OnTheAirTvSeriesEvent, OnTheAirTvSeriesState> {
  final GetOnTheAirTvSeries _getOnAirTvSeries;

  OnTheAirTvSeriesBloc(this._getOnAirTvSeries)
      : super(OnTheAirTvSeriesEmpty()) {
    on<FetchOnTheAirTvSeries>((event, emit) async {
      emit(OnTheAirTvSeriesLoading());

      final result = await _getOnAirTvSeries.execute();

      result.fold(
        (failure) => emit(OnTheAirTvSeriesError(failure.message)),
        (data) => emit(OnTheAirTvSeriesHasData(data)),
      );
    });
  }
}
