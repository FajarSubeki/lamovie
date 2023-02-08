part of 'on_the_air_tv_series_bloc.dart';

abstract class OnTheAirTvSeriesEvent extends Equatable {
  const OnTheAirTvSeriesEvent();
}

class FetchOnTheAirTvSeries extends OnTheAirTvSeriesEvent {
  const FetchOnTheAirTvSeries();

  @override
  List<Object?> get props => [];
}
