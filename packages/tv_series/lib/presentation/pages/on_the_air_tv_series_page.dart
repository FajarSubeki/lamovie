import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/blocs/on_the_air/on_the_air_tv_series_bloc.dart';
import 'package:tv_series/presentation/widgets/tv_series_card_list.dart';

class OnTheAirTvSeriesPage extends StatefulWidget {
  const OnTheAirTvSeriesPage({super.key});

  @override
  State<OnTheAirTvSeriesPage> createState() => _OnTheAirTvSeriesPageState();
}

class _OnTheAirTvSeriesPageState extends State<OnTheAirTvSeriesPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => context
        .read<OnTheAirTvSeriesBloc>()
        .add(const FetchOnTheAirTvSeries()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('On The Air TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
          builder: (_, state) {
            if (state is OnTheAirTvSeriesLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state is OnTheAirTvSeriesHasData) {
              return ListView.builder(
                itemBuilder: (_, index) {
                  final tvSeries = state.result[index];
                  return TvSeriesCardList(tvSeries: tvSeries);
                },
                itemCount: state.result.length,
              );
            } else if (state is OnTheAirTvSeriesError) {
              return Center(
                key: const Key('error_message'),
                child: Text(state.message),
              );
            } else {
              return const Center(
                child: Text('Error Get On The Air TV Series'),
              );
            }
          },
        ),
      ),
    );
  }
}
