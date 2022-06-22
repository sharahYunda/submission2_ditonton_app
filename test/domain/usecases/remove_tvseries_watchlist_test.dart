import 'package:dartz/dartz.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../dummy_data/dummy_objects.dart';
import '../../helpers/tvseries_test_helper.mocks.dart';

void main() {
  late RemoveTVSeriesWatchlist usecase;
  late MockTVSeriesRepository mockTVSeriesRepository;

  setUp(() {
    mockTVSeriesRepository = MockTVSeriesRepository();
    usecase = RemoveTVSeriesWatchlist(mockTVSeriesRepository);
  });

  test('should remove watchlist TV Series from repository', () async {
    // arrange
    when(mockTVSeriesRepository.removeTVSeriesFromWatchlist(testTVSeriesDetail))
        .thenAnswer((_) async => Right('Removed from watchlist'));
    // act
    final result = await usecase.execute(testTVSeriesDetail);
    // assert
    verify(mockTVSeriesRepository.removeTVSeriesFromWatchlist(testTVSeriesDetail));
    expect(result, Right('Removed from watchlist'));
  });
}
