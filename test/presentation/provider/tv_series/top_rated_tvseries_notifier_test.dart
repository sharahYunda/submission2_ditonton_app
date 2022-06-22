import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/presentation/provider/top_rated_tvseries_notifier.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tvseries_notifier_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;
  late TopRatedTVSeriesNotifier notifier;
  late int listenerCallCount;

  setUp(() {
    listenerCallCount = 0;
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    notifier = TopRatedTVSeriesNotifier(getTopRatedTVSeries: mockGetTopRatedTVSeries)
      ..addListener(() {
        listenerCallCount++;
      });
  });

  final tMovie = TVSeries(
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

  final tMovieList = <TVSeries>[tMovie];

  test('should change state to loading when usecase is called', () async {
    // arrange
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    notifier.fetchTopRatedTVSeries();
    // assert
    expect(notifier.state, RequestState.Loading);
    expect(listenerCallCount, 1);
  });

  test('should change TVSeries data when data is gotten successfully', () async {
    // arrange
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Right(tMovieList));
    // act
    await notifier.fetchTopRatedTVSeries();
    // assert
    expect(notifier.state, RequestState.Loaded);
    expect(notifier.tvSeries, tMovieList);
    expect(listenerCallCount, 2);
  });

  test('should return error when data is unsuccessful', () async {
    // arrange
    when(mockGetTopRatedTVSeries.execute())
        .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
    // act
    await notifier.fetchTopRatedTVSeries();
    // assert
    expect(notifier.state, RequestState.Error);
    expect(notifier.message, 'Server Failure');
    expect(listenerCallCount, 2);
  });
}
