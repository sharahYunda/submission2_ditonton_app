import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/season_tvseries.dart';
import 'package:equatable/equatable.dart';

class TVSeriesDetail extends Equatable {
  TVSeriesDetail({
    required this.adult,
    required this.backdropPath,
    required this.genres,
    required this.id,
    required this.overview,
    required this.posterPath,
    required this.episodeRunTime,
    required this.name,
    required this.numberOfEpisodes,
    required this.numberOfSeasons,
    required this.seasons,
    required this.voteAverage,
    required this.voteCount,
  });

  final bool adult;
  final String? backdropPath;
  final List<Genre> genres;
  final int id;
  final String overview;
  final String posterPath;
  final List<int> episodeRunTime;
  final String name;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<Season> seasons;
  final double voteAverage;
  final int voteCount;

  @override
  List<Object?> get props => [
    adult,
    backdropPath,
    genres,
    id,
    overview,
    posterPath,
    episodeRunTime,
    name,
    numberOfEpisodes,
    numberOfSeasons,
    seasons,
    voteAverage,
    voteCount
  ];
}