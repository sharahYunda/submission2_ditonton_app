import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/common/failure.dart';

class RemoveTVSeriesWatchlist {
  final TVSeriesRepository repository;

  RemoveTVSeriesWatchlist(this.repository);

  Future<Either<Failure, String>> execute(TVSeriesDetail movie) {
    return repository.removeTVSeriesFromWatchlist(movie);
  }
}
