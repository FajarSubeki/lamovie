import 'package:equatable/equatable.dart';

class Author extends Equatable {

  late String username;
  late double rating;

  Author.fromJson(Map<String, dynamic> json) {
    username = json['username'];
    rating = json['rating'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    return {
      'username': username,
      'rating': rating,
    };
  }

  @override
  List<Object> get props => [username, rating];
}
