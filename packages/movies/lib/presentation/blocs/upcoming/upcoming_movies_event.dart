part of 'upcoming_movies_bloc.dart';

abstract class UpComingMoviesEvent extends Equatable {
  const UpComingMoviesEvent();
}

class FetchUpComingMovies extends UpComingMoviesEvent {
  const FetchUpComingMovies();

  @override
  List<Object> get props => [];
}
