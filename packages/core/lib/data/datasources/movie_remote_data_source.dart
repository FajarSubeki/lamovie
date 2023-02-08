import 'dart:convert';

import 'package:core/core.dart';
import 'package:core/data/models/movie_detail_model.dart';
import 'package:core/data/models/movie_model.dart';
import 'package:core/data/models/movie_response.dart';
import 'package:core/data/models/review_model.dart';
import 'package:core/data/models/review_response.dart';
import 'package:http/http.dart' as http;

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getNowPlaying();
  Future<List<MovieModel>> getUpComing();
  Future<List<MovieModel>> getPopular();
  Future<MovieDetailResponse> getDetail(int id);
  Future<List<MovieModel>> getRecommendation(int id);
  Future<List<ReviewModel>> getReview(int id);

}

class MovieRemoteDataSourceImpl implements MovieRemoteDataSource {
  final http.Client client;

  MovieRemoteDataSourceImpl({required this.client});

  @override
  Future<List<MovieModel>> getNowPlaying() async {
    final response =
        await client.get(Uri.parse('$baseUrl/movie/now_playing?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getUpComing() async {
    final response =
    await client.get(Uri.parse('$baseUrl/movie/upcoming?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final response =
    await client.get(Uri.parse('$baseUrl/movie/popular?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MovieDetailResponse> getDetail(int id) async {
    final response = await client.get(Uri.parse('$baseUrl/movie/$id?$apiKey'));

    if (response.statusCode == 200) {
      return MovieDetailResponse.fromJson(json.decode(response.body));
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MovieModel>> getRecommendation(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/movie/$id/recommendations?$apiKey'));

    if (response.statusCode == 200) {
      return MovieResponse.fromJson(json.decode(response.body)).movieList;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<ReviewModel>> getReview(int id) async {
    final response = await client
        .get(Uri.parse('$baseUrl/movie/$id/reviews?$apiKey'));

    if (response.statusCode == 200) {
      return ReviewResponse.fromJson(json.decode(response.body)).reviewList;
    } else {
      throw ServerException();
    }
  }
}
