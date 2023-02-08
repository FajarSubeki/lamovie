import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies/presentation/widgets/movie_card_list.dart';
import 'package:movies/presentation/blocs/upcoming/upcoming_movies_bloc.dart';


class UpcomingMoviesPage extends StatefulWidget {
  const UpcomingMoviesPage({super.key});

  @override
  State<UpcomingMoviesPage> createState() => _UpcomingMoviesPageState();
}

class _UpcomingMoviesPageState extends State<UpcomingMoviesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() =>
        context.read<UpComingMoviesBloc>().add(const FetchUpComingMovies()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Upcoming Movies'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<UpComingMoviesBloc, UpComingMoviesState>(
          builder: (_, state) {
            if (state is UpComingMoviesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is UpComingMoviesHasData) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  final movie = state.result[index];
                  return MovieCardList(movie: movie);
                },
                itemCount: state.result.length,
              );
            } else if (state is UpComingMoviesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Empty data'),
              );
            }
          },
        ),
      ),
    );
  }
}
