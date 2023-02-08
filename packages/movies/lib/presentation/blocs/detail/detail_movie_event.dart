part of 'detail_movie_bloc.dart';

abstract class DetailMovieEvent extends Equatable {
  const DetailMovieEvent();
}

class FetchDetailMovie extends DetailMovieEvent {
  final int id;

  const FetchDetailMovie(this.id);

  @override
  List<Object?> get props => [id];
}
