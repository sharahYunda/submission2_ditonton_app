import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_on_air_tvseries.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/provider/tvseries_list_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'tvseries_list_notifier_test.mocks.dart';

@GenerateMocks([GetOnTheAirTVSeries, GetPopularTVSeries, GetTopRatedTVSeries])
void main() {
  late TVSeriesListNotifier provider;
  late MockGetOnTheAirTVSeries mockGetOnTheAirTVSeries;
  late MockGetPopularTVSeries mockGetPopularTVSeries;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetOnTheAirTVSeries = MockGetOnTheAirTVSeries();
    mockGetPopularTVSeries = MockGetPopularTVSeries();
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    provider = TVSeriesListNotifier(
      getOnTheAirTVSeries: mockGetOnTheAirTVSeries,
      getPopularTVSeries: mockGetPopularTVSeries,
      getTopRatedTVSeries: mockGetTopRatedTVSeries,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tTVSeries = TVSeries(
    backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
    firstAirDate: "2003-10-21",
    genreIds: [18],
    id: 11250,
    name: "Hidden Passion",
    originCountry: ["CO"],
    originalLanguage: "es",
    originalName: "Pasión de gavilanes",
    overview:
    "The Reyes-Elizondo's idyllic lives are shattered by a murder charge against Eric and León.",
    popularity: 1747.047,
    posterPath: "/lWlsZIsrGVWHtBeoOeLxIKDd9uy.jpg",
    voteAverage: 7.6,
    voteCount: 1803,
  );
  final tTVSeriesList = <TVSeries>[tTVSeries];

  group('now playing TV Series', () {
    test('initialState should be Empty', () {
      expect(provider.nowPlayingState, equals(RequestState.Empty));
    });

    test('should get data from the usecase', () async {
      // arrange
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchOnTheAirTVSeries();
      // assert
      verify(mockGetOnTheAirTVSeries.execute());
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchOnTheAirTVSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loading);
    });

    test('should change TV Series when data is gotten successfully', () async {
      // arrange
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchOnTheAirTVSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Loaded);
      expect(provider.onTheAirTVSeries, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetOnTheAirTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchOnTheAirTVSeries();
      // assert
      expect(provider.nowPlayingState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('popular mTV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, RequestState.Loading);
      // verify(provider.setState(RequestState.Loading));
    });

    test('should change TV Series data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, RequestState.Loaded);
      expect(provider.popularTVSeries, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetPopularTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchPopularTVSeries();
      // assert
      expect(provider.popularTVSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });

  group('top rated TV Series', () {
    test('should change state to loading when usecase is called', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, RequestState.Loading);
    });

    test('should change TVSeries data when data is gotten successfully',
        () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Right(tTVSeriesList));
      // act
      await provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, RequestState.Loaded);
      expect(provider.topRatedTVSeries, tTVSeriesList);
      expect(listenerCallCount, 2);
    });

    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTopRatedTVSeries.execute())
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      // act
      await provider.fetchTopRatedTVSeries();
      // assert
      expect(provider.topRatedTVSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
