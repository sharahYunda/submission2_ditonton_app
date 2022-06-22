import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/usecases/get_popular_tvseries.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/tvseries_test_helper.mocks.dart';

void main() {
  late GetPopularTVSeries usecase;
  late MockTVSeriesRepository mockTVSeriesRpository;

  setUp(() {
    mockTVSeriesRpository = MockTVSeriesRepository();
    usecase = GetPopularTVSeries(mockTVSeriesRpository);
  });

  final tTVSeries = <TVSeries>[];

  group('GetPopularTV Series Tests', () {
    group('execute', () {
      test(
          'should get list of TV Series from the repository when execute function is called',
          () async {
        // arrange
        when(mockTVSeriesRpository.getPopularTVSeries())
            .thenAnswer((_) async => Right(tTVSeries));
        // act
        final result = await usecase.execute();
        // assert
        expect(result, Right(tTVSeries));
      });
    });
  });
}
