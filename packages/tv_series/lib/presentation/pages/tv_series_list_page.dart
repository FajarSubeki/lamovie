import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/blocs/on_the_air/on_the_air_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/popular/popular_tv_series_bloc.dart';

class TvSeriesListPage extends StatefulWidget {
  const TvSeriesListPage({Key? key}) : super(key: key);

  @override
  State<TvSeriesListPage> createState() => _TvSeriesListPageState();
}

class _TvSeriesListPageState extends State<TvSeriesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context
          .read<OnTheAirTvSeriesBloc>()
          .add(const FetchOnTheAirTvSeries());
      context.read<PopularTvSeriesBloc>().add(const FetchPopularTvSeries());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TV Series'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSubHeading(
                title: 'On The Air',
                onTap: () {
                  Navigator.pushNamed(context, onTheAirTvSeriesRoute);
                },
              ),
              BlocBuilder<OnTheAirTvSeriesBloc, OnTheAirTvSeriesState>(
                builder: (_, state) {
                  if (state is OnTheAirTvSeriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is OnTheAirTvSeriesHasData) {
                    return TvSeriesList(state.result);
                  } else if (state is OnTheAirTvSeriesError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Failed'));
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () {
                  Navigator.pushNamed(context, popularTvSeriesRoute);
                },
              ),
              BlocBuilder<PopularTvSeriesBloc, PopularTvSeriesState>(
                builder: (_, state) {
                  if (state is PopularTvSeriesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is PopularTvSeriesHasData) {
                    return TvSeriesList(state.result);
                  } else if (state is PopularTvSeriesError) {
                    return Center(child: Text(state.message));
                  } else {
                    return const Center(child: Text('Failed'));
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: const [
                Text('See More'),
                Icon(Icons.arrow_forward_ios),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class TvSeriesList extends StatelessWidget {
  final List<TvSeries> tvSeries;

  const TvSeriesList(this.tvSeries, {super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final item = tvSeries[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              key: const Key('tvSeriesItem'),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  tvSeriesDetailRoute,
                  arguments: item.id,
                );
              },
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${item.posterPath}',
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: tvSeries.length,
      ),
    );
  }
}
