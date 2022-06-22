import 'dart:convert';

import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/data/models/tvseries_response.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../json_reader.dart';

void main() {
  final seriesModel = TVSeriesModel(
    backdropPath: "/path.jpg",
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    popularity: 1,
    voteAverage: 1,
    voteCount: 1,
    name: 'name',
    firstAirDate: 'firstAirDate',
    originalLanguage: 'en',
    originalName: 'originalName',
    originCountry: [
      'US',
    ],
  );
  final tSeriesResponseModel =
      TVSeriesResponse(tvSeriesList: <TVSeriesModel>[seriesModel]);
  group('fromJson', () {
    test('should return a valid model from JSON', () async {
      // arrange
      final Map<String, dynamic> jsonMap =
          json.decode(readJson('dummy_data/now_playing.json'));
      // act
      final result = TVSeriesResponse.fromJson(jsonMap);
      // assert
      expect(result, tSeriesResponseModel);
    });
  });

  group('toJson', () {
    test('should return a JSON map containing proper data', () async {
      // arrange

      // act
      final result = tSeriesResponseModel.toJson();
      // assert
      final expectedJsonMap = {
        "results": [
          {
            "backdrop_path": "/path.jpg",
            "genre_ids": [1, 2, 3, 4],
            "id": 1,
            "overview": "overview",
            "poster_path": "/path.jpg",
            "popularity": 1,
            "vote_average": 1,
            "vote_count": 1,
            "name": "name",
            "firstAirDate": "firstAirDate",
            "original_language": "en",
            "original_name": "original Name",
            "origin_country": ["US"],
          }
        ],
      };
      expect(result, expectedJsonMap);
    });
  });
}
