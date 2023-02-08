import 'package:core/domain/entities/author.dart';
import 'package:equatable/equatable.dart';

class Review extends Equatable {
  const Review({
    required this.author,
    required this.authorDetails,
    required this.content,
    required this.createdAt,
  });

  const Review.watchlist({
    this.author,
    this.authorDetails,
    this.content,
    this.createdAt,
  });

  final String? author;
  final Author? authorDetails;
  final String? content;
  final String? createdAt;

  @override
  List<Object?> get props => [
    author,
    authorDetails,
    content,
    createdAt
  ];
}
