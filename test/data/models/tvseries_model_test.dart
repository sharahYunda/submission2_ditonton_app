import 'package:ditonton/data/models/tvseries_model.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  final seriesModel = TVSeriesModel(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3],
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    popularity: 1,
    voteAverage: 1,
    voteCount: 1,
    name: 'name',
    firstAirDate: 'firstAirDate',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: [
      'originCountry',
    ],
  );

  final seriestV = TVSeries(
    backdropPath: 'backdropPath',
    genreIds: [1, 2, 3, 4],
    id: 1,
    overview: 'overview',
    popularity: 1,
    posterPath: 'posterPath',
    voteAverage: 1,
    voteCount: 1,
    name: 'name',
    firstAirDate: 'firstAirDate',
    originalLanguage: 'originalLanguage',
    originalName: 'originalName',
    originCountry: ['originCountry'],
  );

  test('should be a subclass of Movie entity', () async {
    final result = seriesModel.toEntity();
    expect(result, seriestV);
  });
}
