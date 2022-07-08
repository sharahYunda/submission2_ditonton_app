import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetTVSeriesDetail {
  final TVSeriesRepository repository;

  GetTVSeriesDetail(this.repository);

  Future<Either<Failure, TVSeriesDetail>> execute(int id) {
    return repository.getTVSeriesDetail(id);
  }
}
