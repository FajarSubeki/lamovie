import 'package:cached_network_image/cached_network_image.dart';
import 'package:core/core.dart';
import 'package:core/domain/entities/genre.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/review.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tv_series/presentation/blocs/detail/detail_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/recommendation/recommendation_tv_series_bloc.dart';
import 'package:tv_series/presentation/blocs/review/review_tv_series_bloc.dart';

class TvSeriesDetailPage extends StatefulWidget {
  final int id;

  const TvSeriesDetailPage({super.key, required this.id});

  @override
  State<TvSeriesDetailPage> createState() => _TvSeriesDetailPageState();
}

class _TvSeriesDetailPageState extends State<TvSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      final id = widget.id;
      context.read<DetailTvSeriesBloc>().add(FetchDetailTvSeries(id));
      context
          .read<RecommendationTvSeriesBloc>()
          .add(FetchRecommendationTvSeries(id));
      context
          .read<ReviewTvSeriesBloc>()
          .add(FetchReviewTvSeries(id));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<DetailTvSeriesBloc, DetailTvSeriesState>(
        builder: (_, state) {
          if (state is DetailTvSeriesLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is DetailTvSeriesHasData) {
            return SafeArea(child: DetailContent(state.result));
          } else if (state is DetailTvSeriesError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TvSeriesDetail tvSeriesDetail;

  const DetailContent(
      this.tvSeriesDetail,
      {super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$baseImageUrl${tvSeriesDetail.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => const Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => const Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: const BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              tvSeriesDetail.name,
                              style: kHeading5,
                            ),
                            Text(
                              _showGenres(tvSeriesDetail.genres),
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              tvSeriesDetail.overview,
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Reviews',
                              style: kHeading6,
                            ),
                            BlocBuilder<ReviewTvSeriesBloc,
                                ReviewTvSeriesState>(
                              builder: (_, state) {
                                if (state is ReviewTvSeriesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                is ReviewTvSeriesHasData) {
                                  return TvSeriesReviewList(
                                    reviewList: state.result,
                                  );
                                } else if (state
                                is ReviewTvSeriesError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else {
                                  return Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                        MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.tv_off),
                                          SizedBox(height: 2),
                                          Text('No Reviews'),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                            const SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<RecommendationTvSeriesBloc,
                                RecommendationTvSeriesState>(
                              builder: (_, state) {
                                if (state is RecommendationTvSeriesLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                    is RecommendationTvSeriesHasData) {
                                  return TvSeriesRecommendationList(
                                    tvSeriesList: state.result,
                                  );
                                } else if (state
                                    is RecommendationTvSeriesError) {
                                  return Center(
                                    child: Text(state.message),
                                  );
                                } else {
                                  return Container(
                                    child: Center(
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: const [
                                          Icon(Icons.tv_off),
                                          SizedBox(height: 2),
                                          Text('No Recommendations'),
                                        ],
                                      ),
                                    ),
                                  );
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              key: const Key('iconBack'),
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';

    for (var genre in genres) {
      result += '${genre.name}, ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }
}

class TvSeriesReviewList extends StatelessWidget{

  final List<Review> reviewList;

  const TvSeriesReviewList({required this.reviewList, super.key});

  @override
  Widget build(BuildContext context) {
    return LimitedBox(
      maxHeight: 500.0,
      child: ListView.builder(
        shrinkWrap: true,
        itemBuilder: (BuildContext context, int index) {
          final review = reviewList[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage:
              NetworkImage(urlUserImage),
              backgroundColor: kMikadoYellow,
            ),
            title: Text('${review.author}'),
            subtitle: Text('${review.content}'),
          );
        },
        itemCount: reviewList.length,
      ),
    );
  }

}

class TvSeriesRecommendationList extends StatelessWidget {
  final List<TvSeries> tvSeriesList;

  const TvSeriesRecommendationList({required this.tvSeriesList, super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeries = tvSeriesList[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () => Navigator.pushReplacementNamed(
                context,
                tvSeriesDetailRoute,
                arguments: tvSeries.id,
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(8)),
                child: CachedNetworkImage(
                  imageUrl: '$baseImageUrl${tvSeries.posterPath}',
                  placeholder: (_, __) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                  errorWidget: (_, __, error) {
                    return const Icon(Icons.error);
                  },
                ),
              ),
            ),
          );
        },
        itemCount: tvSeriesList.length,
      ),
    );
  }
}
