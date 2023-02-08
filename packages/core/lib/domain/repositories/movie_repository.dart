import 'package:core/core.dart';
import 'package:core/domain/entities/movie.dart';
import 'package:core/domain/entities/review.dart';

import 'package:core/domain/entities/movie_detail.dart';
import 'package:dartz/dartz.dart';

abstract class MovieRepository {
  Future<Either<Failure, List<Movie>>> getNowPlaying();
  Future<Either<Failure, List<Movie>>> getUpComing();
  Future<Either<Failure, List<Movie>>> getPopular();
  Future<Either<Failure, MovieDetail>> getDetail(int id);
  Future<Either<Failure, List<Movie>>> getRecommendation(int id);
  Future<Either<Failure, List<Review>>> getReview(int id);
}
