part of 'on_the_air_tv_series_bloc.dart';

abstract class OnTheAirTvSeriesState extends Equatable {
  const OnTheAirTvSeriesState();

  @override
  List<Object?> get props => [];
}

class OnTheAirTvSeriesEmpty extends OnTheAirTvSeriesState {}

class OnTheAirTvSeriesLoading extends OnTheAirTvSeriesState {}

class OnTheAirTvSeriesError extends OnTheAirTvSeriesState {
  final String message;

  const OnTheAirTvSeriesError(this.message);

  @override
  List<Object?> get props => [message];
}

class OnTheAirTvSeriesHasData extends OnTheAirTvSeriesState {
  final List<TvSeries> result;

  const OnTheAirTvSeriesHasData(this.result);

  @override
  List<Object?> get props => [result];
}
