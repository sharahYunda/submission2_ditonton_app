import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:ditonton/tv_series/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/tv_series/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/tv_series/data/models/tvseries_table.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/common/exception.dart';
import 'package:ditonton/common/failure.dart';

class TVSeriesRepositoryImpl implements TVSeriesRepository {
  final TVSeriesRemoteDataSource remoteDataSource;
  final TVSeriesLocalDataSource localDataSource;

  TVSeriesRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<TVSeries>>> getOnTheAirTVSeries() async {
    try {
      final result = await remoteDataSource.getOnTheAirTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, TVSeriesDetail>> getTVSeriesDetail(int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesDetail(id);
      return Right(result.toEntity());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTVSeriesRecommendations(
      int id) async {
    try {
      final result = await remoteDataSource.getTVSeriesRecommendations(id);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getPopularTVSeries() async {
    try {
      final result = await remoteDataSource.getPopularTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTopRatedTVSeries() async {
    try {
      final result = await remoteDataSource.getTopRatedTVSeries();
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, List<TVSeries>>> searchTVSeries(String query) async {
    try {
      final result = await remoteDataSource.searchTVSeries(query);
      return Right(result.map((model) => model.toEntity()).toList());
    } on ServerException {
      return Left(ServerFailure(''));
    } on SocketException {
      return Left(ConnectionFailure('Failed to connect to the network'));
    } on TlsException{
      return Left(SSLFailure('CERTIFICATE_VERIFY_FAILED'));
    }
  }

  @override
  Future<Either<Failure, String>> saveTVSeriesWatchlist(
      TVSeriesDetail tvSeries) async {
    try {
      final result = await localDataSource
          .insertTVSeriesWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    } catch (e) {
      throw e;
    }
  }

  @override
  Future<Either<Failure, String>> removeTVSeriesFromWatchlist(
      TVSeriesDetail tvSeries) async {
    try {
      final result = await localDataSource
          .removeTVSeriesWatchlist(TVSeriesTable.fromEntity(tvSeries));
      return Right(result);
    } on DatabaseException catch (e) {
      return Left(DatabaseFailure(e.message));
    }
  }

  @override
  Future<bool> isTVSeriesAddedToWatchlist(int id) async {
    final result = await localDataSource.getTVSeriesById(id);
    return result != null;
  }

  @override
  Future<Either<Failure, List<TVSeries>>> getTVSeriesWatchlist() async {
    final result = await localDataSource.getWatchlistTVSeries();
    return Right(result.map((data) => data.toEntity()).toList());
  }
}
