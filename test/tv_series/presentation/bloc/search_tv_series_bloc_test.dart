import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/search_tvseries.dart';
import 'package:ditonton/tv_series/presentation/bloc/search_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'search_tv_series_bloc_test.mocks.dart';

@GenerateMocks([SearchTVSeries])
void main() {
  late SeriesSearchBloc seriesSearchBloc;
  late MockSearchTVSeries mockSearchTVSeries;

  setUp(() {
    mockSearchTVSeries = MockSearchTVSeries();
    seriesSearchBloc = SeriesSearchBloc(mockSearchTVSeries);
  });

  final tTvSeriesModel = TVSeries(
    backdropPath: "/9hp4JNejY6Ctg9i9ItkM9rd6GE7.jpg",
    firstAirDate: "1997-09-13",
    genreIds: [10764],
    id: 12610,
    name: "Robinson",
    originCountry: ["SE"],
    originalLanguage: "sv",
    originalName: "Robinson",
    overview:
    "Expedition Robinson is a Swedish reality television program in which contestants are put into survival situations, and a voting process eliminates one person each episode until a winner is determined. The format was developed in 1994 by Charlie Parsons for a United Kingdom TV production company called Planet 24, but the Swedish debut in 1997 was the first production to actually make it to television.",
    popularity: 2338.977,
    posterPath: "/sWA0Uo9hkiAtvtjnPvaqfnulIIE.jpg",
    voteAverage: 5,
    voteCount: 3,
  );
  final tTvSeriesList = <TVSeries>[tTvSeriesModel];
  final tQuery = 'moon knight';

  test('initial state should be empty', () {
    expect(seriesSearchBloc.state, SeriesSearchEmpty());
  });

  blocTest<SeriesSearchBloc, SeriesSearchState>(
    'Should emit [Loading, HasData] when data is gotten successfully',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Right(tTvSeriesList));
      return seriesSearchBloc;
    },
    act: (bloc) => bloc.add(queryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SeriesSearchLoading(),
      SeriesSearchHasData(tTvSeriesList),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );

  blocTest<SeriesSearchBloc, SeriesSearchState>(
    'Should emit [Loading, Error] when get search is unsuccessful',
    build: () {
      when(mockSearchTVSeries.execute(tQuery))
          .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
      return seriesSearchBloc;
    },
    act: (bloc) => bloc.add(queryChanged(tQuery)),
    wait: const Duration(milliseconds: 500),
    expect: () => [
      SeriesSearchLoading(),
      SeriesSearchError('Server Failure'),
    ],
    verify: (bloc) {
      verify(mockSearchTVSeries.execute(tQuery));
    },
  );
}