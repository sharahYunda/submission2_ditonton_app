import 'package:ditonton/domain/entities/season_tvseries.dart';
import 'package:equatable/equatable.dart';

class SeasonTVSeriesModel extends Equatable {
  final int episodeCount;
  final int id;
  final String name;
  final String? posterPath;
  final int seasonNumber;

  SeasonTVSeriesModel({
    required this.episodeCount,
    required this.id,
    required this.name,
    required this.posterPath,
    required this.seasonNumber,
  });

  factory SeasonTVSeriesModel.fromJson(Map<String, dynamic> json) =>
      SeasonTVSeriesModel(
        episodeCount: json['episode_count'],
        id: json['id'],
        name: json['name'],
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );

  Map<String, dynamic> toJson() => {
    "episode_count": episodeCount,
    "id": id,
    "name": name,
    "poster_path": posterPath,
    "season_number": seasonNumber,
  };

  Season toEntity() => Season(
    id: this.id,
    posterPath: this.posterPath,
    seasonNumber: this.seasonNumber,
    episodeCount: this.episodeCount,
    name: this.name,
  );

  @override
  List<Object?> get props => [ episodeCount, id, name, posterPath, seasonNumber];
}