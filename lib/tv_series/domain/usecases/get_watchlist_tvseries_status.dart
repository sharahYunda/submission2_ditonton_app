import 'package:ditonton/tv_series/domain/repositories/tvseries_repository.dart';

class GetWatchListTVSeriesStatus {
  final TVSeriesRepository repository;

  GetWatchListTVSeriesStatus(this.repository);

  Future<bool> execute(int id) async {
    return repository.isTVSeriesAddedToWatchlist(id);
  }
}
