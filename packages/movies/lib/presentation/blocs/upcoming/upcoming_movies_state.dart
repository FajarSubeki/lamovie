part of 'upcoming_movies_bloc.dart';

abstract class UpComingMoviesState extends Equatable {
  @override
  List<Object?> get props => [];
}

class UpComingMoviesEmpty extends UpComingMoviesState {}

class UpComingMoviesLoading extends UpComingMoviesState {}

class UpComingMoviesHasData extends UpComingMoviesState {
  final List<Movie> result;

  UpComingMoviesHasData(this.result);

  @override
  List<Object?> get props => [result];
}

class UpComingMoviesError extends UpComingMoviesState {
  final String message;

  UpComingMoviesError(this.message);

  @override
  List<Object?> get props => [message];
}
