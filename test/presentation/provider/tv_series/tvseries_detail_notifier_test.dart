import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/presentation/provider/tvseries_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../../dummy_data/dummy_objects.dart';
import '../tv_series/tvseries_detail_notifier_test.mocks.dart';

@GenerateMocks([
  GetTVSeriesDetail,
  GetTVSeriesRecommendations,
  GetWatchListTVSeriesStatus,
  SaveTVSeriesWatchlist,
  RemoveTVSeriesWatchlist,
])
void main() {
  late TVSeriesDetailNotifier provider;
  late MockGetTVSeriesDetail mockGetTVSeriesDetail;
  late MockGetTVSeriesRecommendations mockGetTVSeriesRecommendations;
  late MockGetWatchListTVSeriesStatus mockGetWatchlistTVSeriesStatus;
  late MockSaveTVSeriesWatchlist mockSaveTVSeriesWatchlist;
  late MockRemoveTVSeriesWatchlist mockRemoveTVSeriesWatchlist;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTVSeriesDetail = MockGetTVSeriesDetail();
    mockGetTVSeriesRecommendations = MockGetTVSeriesRecommendations();
    mockGetWatchlistTVSeriesStatus = MockGetWatchListTVSeriesStatus();
    mockSaveTVSeriesWatchlist = MockSaveTVSeriesWatchlist();
    mockRemoveTVSeriesWatchlist = MockRemoveTVSeriesWatchlist();
    provider = TVSeriesDetailNotifier(
      getTVSeriesDetail: mockGetTVSeriesDetail,
      getTVSeriesRecommendations: mockGetTVSeriesRecommendations,
      getWatchListStatusTVSeries: mockGetWatchlistTVSeriesStatus,
      saveTVSeriesWatchlist: mockSaveTVSeriesWatchlist,
      removeTVSeriesFromWatchlist: mockRemoveTVSeriesWatchlist,
    )..addListener(() {
        listenerCallCount += 1;
      });
  });

  final tId = 1;

  final tTVSeries = TVSeries(
      backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
      firstAirDate: "2022-03-24",
      genreIds: [10759, 10765],
      id: 52814,
      name: "Halo",
      originCountry: ["US"],
      originalLanguage: "en",
      originalName: "Halo",
      overview:
      "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
      popularity: 7348.55,
      posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
      voteAverage: 8.7,
      voteCount: 472
  );
  final tSeries = <TVSeries>[tTVSeries];

  void _arrangeUsecase() {
    when(mockGetTVSeriesDetail.execute(tId))
        .thenAnswer((_) async => Right(testTVSeriesDetail));
    when(mockGetTVSeriesRecommendations.execute(tId))
        .thenAnswer((_) async => Right(tSeries));
  }

  group('Get TV Series Detail', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeriesDetail(tId);
      // assert
      verify(mockGetTVSeriesDetail.execute(tId));
      verify(mockGetTVSeriesRecommendations.execute(tId));
    });

    test('should change state to Loading when usecase is called', () {
      // arrange
      _arrangeUsecase();
      // act
      provider.fetchTVSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loading);
      expect(listenerCallCount, 1);
    });

    test('should change TV Series when data is gotten successfully', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeries, testTVSeriesDetail);
      expect(listenerCallCount, 3);
    });

    test('should change recommendation TV Series when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tSeries);
    });
  });

  group('Get TV Series Recommendations', () {
    test('should get data from the usecase', () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeriesDetail(tId);
      // assert
      verify(mockGetTVSeriesRecommendations.execute(tId));
      expect(provider.tvSeriesRecommendations, tSeries);
    });

    test('should update recommendation state when data is gotten successfully',
        () async {
      // arrange
      _arrangeUsecase();
      // act
      await provider.fetchTVSeriesDetail(tId);
      // assert
      expect(provider.recommendationStateTVSeries, RequestState.Loaded);
      expect(provider.tvSeriesRecommendations, tSeries);
    });

    test('should update error message when request in successful', () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Right(testTVSeriesDetail));
      when(mockGetTVSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Failed')));
      // act
      await provider.fetchTVSeriesDetail(tId);
      // assert
      expect(provider.recommendationStateTVSeries, RequestState.Error);
      expect(provider.message, 'Failed');
    });
  });

  group('Watchlist', () {
    test('should get the watchlist status', () async {
      // arrange
      when(mockGetWatchlistTVSeriesStatus.execute(1)).thenAnswer((_) async => true);
      // act
      await provider.loadWatchlistStatus(1);
      // assert
      expect(provider.isTVSeriesAddedToWatchlist, true);
    });

    test('should execute save watchlist when function called', () async {
      // arrange
      when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Success'));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.insertTVSeriesWatchlist(testTVSeriesDetail);
      // assert
      verify(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail));
    });

    test('should execute remove watchlist when function called', () async {
      // arrange
      when(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Removed'));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.removeFromWatchlist(testTVSeriesDetail);
      // assert
      verify(mockRemoveTVSeriesWatchlist.execute(testTVSeriesDetail));
    });

    test('should update watchlist status when add watchlist success', () async {
      // arrange
      when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Right('Added to Watchlist'));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => true);
      // act
      await provider.insertTVSeriesWatchlist(testTVSeriesDetail);
      // assert
      verify(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id));
      expect(provider.isTVSeriesAddedToWatchlist, true);
      expect(provider.watchlistMessage, 'Added to Watchlist');
      expect(listenerCallCount, 1);
    });

    test('should update watchlist message when add watchlist failed', () async {
      // arrange
      when(mockSaveTVSeriesWatchlist.execute(testTVSeriesDetail))
          .thenAnswer((_) async => Left(DatabaseFailure('Failed')));
      when(mockGetWatchlistTVSeriesStatus.execute(testTVSeriesDetail.id))
          .thenAnswer((_) async => false);
      // act
      await provider.insertTVSeriesWatchlist(testTVSeriesDetail);
      // assert
      expect(provider.watchlistMessage, 'Failed');
      expect(listenerCallCount, 1);
    });
  });

  group('on Error', () {
    test('should return error when data is unsuccessful', () async {
      // arrange
      when(mockGetTVSeriesDetail.execute(tId))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      when(mockGetTVSeriesRecommendations.execute(tId))
          .thenAnswer((_) async => Right(tSeries));
      // act
      await provider.fetchTVSeriesDetail(tId);
      // assert
      expect(provider.tvSeriesState, RequestState.Error);
      expect(provider.message, 'Server Failure');
      expect(listenerCallCount, 2);
    });
  });
}
