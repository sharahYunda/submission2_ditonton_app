import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/common/failure.dart';

class GetOnTheAirTVSeries {
  final TVSeriesRepository repository;

  GetOnTheAirTVSeries(this.repository);

  Future<Either<Failure, List<TVSeries>>> execute() {
    return repository.getOnTheAirTVSeries();
  }
}
