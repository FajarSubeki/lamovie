import 'package:core/core.dart';
import 'package:core/domain/entities/review.dart';
import 'package:core/domain/repositories/movie_repository.dart';
import 'package:dartz/dartz.dart';

class GetReviewMovies {
  final MovieRepository repository;

  GetReviewMovies(this.repository);

  Future<Either<Failure, List<Review>>> execute(id) {
    return repository.getReview(id);
  }
}
