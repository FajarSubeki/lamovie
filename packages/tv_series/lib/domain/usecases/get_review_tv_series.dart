import 'package:core/core.dart';
import 'package:core/domain/entities/review.dart';
import 'package:core/domain/repositories/tv_series_repository.dart';
import 'package:dartz/dartz.dart';

class GetReviewTvSeries {
  final TvSeriesRepository repository;

  GetReviewTvSeries(this.repository);

  Future<Either<Failure, List<Review>>> execute(id) {
    return repository.getReview(id);
  }
}
