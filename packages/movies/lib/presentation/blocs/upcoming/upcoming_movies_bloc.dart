import 'package:core/domain/entities/movie.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/domain/usecases/get_now_playing_movies.dart';
import 'package:movies/domain/usecases/get_upcoming_movies.dart';

part 'upcoming_movies_event.dart';
part 'upcoming_movies_state.dart';

class UpComingMoviesBloc
    extends Bloc<UpComingMoviesEvent, UpComingMoviesState> {
  final GetUpcomingMovies _getUpComingMovies;

  UpComingMoviesBloc(this._getUpComingMovies)
      : super(UpComingMoviesEmpty()) {
    on<FetchUpComingMovies>((event, emit) async {
      emit(UpComingMoviesLoading());

      final result = await _getUpComingMovies.execute();

      result.fold(
        (failure) => emit(UpComingMoviesError(failure.message)),
        (data) {
          if (data.isEmpty) {
            emit(UpComingMoviesEmpty());
          } else {
            emit(UpComingMoviesHasData(data));
          }
        },
      );
    });
  }
}
