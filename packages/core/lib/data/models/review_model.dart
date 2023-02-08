import 'package:core/domain/entities/author.dart';
import 'package:core/domain/entities/review.dart';
import 'package:equatable/equatable.dart';

class ReviewModel extends Equatable{

  const ReviewModel({
    required this.author,
    required this.authorDetail,
    required this.content,
    required this.createdAt
  });

  final String author;
  final Author authorDetail;
  final String content;
  final String createdAt;

  factory ReviewModel.fromJson(Map<String, dynamic> json) => ReviewModel(
    author: json["author"],
    authorDetail: Author.fromJson(json['author_details']),
    content: json["content"],
    createdAt: json["created_at"]
  );

  Map<String, dynamic> toJson() => {
    "author": author,
    "author_details": authorDetail.toJson(),
    "content": content,
    "created_at": createdAt,
  };

  Review toEntity(){
    return Review(
      author: author,
      authorDetails: authorDetail,
      content: content,
      createdAt: createdAt
    );
  }

  @override
  List<Object?> get props => [
      author,
      authorDetail,
      content,
      createdAt
    ];

}