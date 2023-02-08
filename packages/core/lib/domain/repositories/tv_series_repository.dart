import 'package:core/core.dart';
import 'package:core/domain/entities/tv_series.dart';
import 'package:core/domain/entities/review.dart';
import 'package:core/domain/entities/tv_series_detail.dart';
import 'package:dartz/dartz.dart';

abstract class TvSeriesRepository {
  Future<Either<Failure, List<TvSeries>>> getOnTheAir();
  Future<Either<Failure, List<TvSeries>>> getPopular();
  Future<Either<Failure, TvSeriesDetail>> getDetail(int id);
  Future<Either<Failure, List<TvSeries>>> getRecommendation(int id);
  Future<Either<Failure, List<Review>>> getReview(int id);
}
