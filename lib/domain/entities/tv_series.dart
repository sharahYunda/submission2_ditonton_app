import 'package:equatable/equatable.dart';

// ignore: must_be_immutable
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

  String? backdropPath;
  List<int>? genreIds;
  int id;
  String? originalName;
  List<String>? originCountry;
  String? originalLanguage;
  String? overview;
  double? popularity;
  String? posterPath;
  String? firstAirDate;
  String? name;
  double? voteAverage;
  int? voteCount;

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