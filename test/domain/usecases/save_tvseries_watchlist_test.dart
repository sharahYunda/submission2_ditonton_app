import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tvseries_test_helper.mocks.dart';

void main() {
  late SaveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = SaveTVSeriesWatchlist(mockTVSeriesRepository);
  });

  test('should save TV Series to the repository', () async {
    // arrange
    when(mockTVSeriesRepository.saveTVSeriesWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => Right('Added to Watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockTVSeriesRepository.saveTVSeriesWatchlist(testTVSeriesDetail));
    expect(result, Right('Added to Watchlist'));
  });
}
