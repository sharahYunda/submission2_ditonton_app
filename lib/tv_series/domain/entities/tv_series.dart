import 'package:equatable/equatable.dart';

class TVSeries extends Equatable {
  TVSeries({
    required this.backdropPath,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.originCountry,
    required this.originalLanguage,
    required this.overview,
    required this.popularity,
    required this.posterPath,
    required this.firstAirDate,
    required this.name,
    required this.voteAverage,
    required this.voteCount,
  });

  TVSeries.watchlist({
    this.backdropPath,
    this.genreIds,
    this.originalName,
    this.originCountry,
    this.originalLanguage,
    this.popularity,
    this.firstAirDate,
    this.voteAverage,
    this.voteCount,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.name,
  });

  final String? backdropPath;
  final List<int>? genreIds;
  final int id;
  final String? originalName;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final String? firstAirDate;
  final String? name;
  final double? voteAverage;
  final int? voteCount;

  @override
  List<Object?> get props => [
    backdropPath,
    genreIds,
    id,
    name,
    originCountry,
    originalLanguage,
    originalName,
    overview,
    popularity,
    posterPath,
    voteAverage,
    voteCount,
  ];
}