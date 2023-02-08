import 'package:core/data/models/review_model.dart';
import 'package:equatable/equatable.dart';

class ReviewResponse extends Equatable {
  final List<ReviewModel> reviewList;

  const ReviewResponse({required this.reviewList});

  factory ReviewResponse.fromJson(Map<String, dynamic> json) => ReviewResponse(
        reviewList: List<ReviewModel>.from((json["results"] as List)
            .map((x) => ReviewModel.fromJson(x))
            .where((element) => element.createdAt != null)),
      );

  Map<String, dynamic> toJson() => {
        "results": List<dynamic>.from(reviewList.map((x) => x.toJson())),
      };

  @override
  List<Object> get props => [reviewList];
}
