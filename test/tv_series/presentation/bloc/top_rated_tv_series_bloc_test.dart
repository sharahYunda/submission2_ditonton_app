import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ditonton/common/failure.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'top_rated_tv_series_bloc_test.mocks.dart';

@GenerateMocks([GetTopRatedTVSeries])
void main() {
  late SeriesTopRatedBloc seriesTopRatedBloc;
  late MockGetTopRatedTVSeries mockGetTopRatedTVSeries;

  setUp(() {
    mockGetTopRatedTVSeries = MockGetTopRatedTVSeries();
    seriesTopRatedBloc = SeriesTopRatedBloc(mockGetTopRatedTVSeries);
  });

  final tTvSeries = TVSeries(
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
  final tTvSeriesList = <TVSeries>[tTvSeries];

  group('bloc top rated tv series testing', () {
    test('initial state should be empty', () {
      expect(seriesTopRatedBloc.state, SeriesTopRatedEmpty());
    });

    blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
      'Should emit [Loading, HasData] when data is gotten successfully',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Right(tTvSeriesList));
        return seriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(OnSeriesTopRatedShow()),
      expect: () => [
        SeriesTopRatedLoading(),
        SeriesTopRatedHasData(tTvSeriesList),
      ],
      verify: (bloc) {
        verify(mockGetTopRatedTVSeries.execute());
        return OnSeriesTopRatedShow().props;
      },
    );

    blocTest<SeriesTopRatedBloc, SeriesTopRatedState>(
      'Should emit [Loading, Error] when get search is unsuccessful',
      build: () {
        when(mockGetTopRatedTVSeries.execute())
            .thenAnswer((_) async => Left(ServerFailure('Server Failure')));
        return seriesTopRatedBloc;
      },
      act: (bloc) => bloc.add(OnSeriesTopRatedShow()),
      expect: () => [
        SeriesTopRatedLoading(),
        SeriesTopRatedError('Server Failure'),
      ],
      verify: (bloc) => SeriesTopRatedLoading(),
    );
  });
}