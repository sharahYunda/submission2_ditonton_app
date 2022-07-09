import 'package:ditonton/movies/data/models/movie_table.dart';
import 'package:ditonton/tv_series/data/models/tvseries_table.dart';
import 'package:ditonton/movies/domain/entities/genre.dart';
import 'package:ditonton/movies/domain/entities/movie.dart';
import 'package:ditonton/movies/domain/entities/movie_detail.dart';
import 'package:ditonton/tv_series/domain/entities/season_tvseries.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';

final testMovie = Movie(
  adult: false,
  backdropPath: '/muth4OYamXf41G2evdrLEg8d3om.jpg',
  genreIds: [14, 28],
  id: 557,
  originalTitle: 'Spider-Man',
  overview:
      'After being bitten by a genetically altered spider, nerdy high school student Peter Parker is endowed with amazing powers to become the Amazing superhero known as Spider-Man.',
  popularity: 60.441,
  posterPath: '/rweIrveL43TaxUN0akQEaAXL6x0.jpg',
  releaseDate: '2002-05-01',
  title: 'Spider-Man',
  video: false,
  voteAverage: 7.2,
  voteCount: 13507,
);

final testMovieList = [testMovie];

final testMovieDetail = MovieDetail(
  adult: false,
  backdropPath: 'backdropPath',
  genres: [Genre(id: 1, name: 'Action')],
  id: 1,
  originalTitle: 'originalTitle',
  overview: 'overview',
  posterPath: 'posterPath',
  releaseDate: 'releaseDate',
  runtime: 120,
  name: 'title',
  voteAverage: 1,
  voteCount: 1,
);

final testWatchlistMovie = Movie.watchlist(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieTable = MovieTable(
  id: 1,
  title: 'title',
  posterPath: 'posterPath',
  overview: 'overview',
);

final testMovieMap = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'title': 'title',
};
final tQ = "Spider Man";
final tError = 'Server Failure';
final tId = 1;

// tv series data
final testTVSeries = TVSeries(
    backdropPath: "/1qpUk27LVI9UoTS7S0EixUBj5aR.jpg",
    firstAirDate: "2022-03-24",
    genreIds: [10759, 10765],
    id: 52814,
    name: "Halo",
    originCountry: ["US"],
    originalLanguage: "en",
    originalName: "Halo",
    overview:
    "Depicting an epic 26th-century conflict between humanity and an alien threat known as the Covenant, the series weaves deeply drawn personal stories with action, adventure and a richly imagined vision of the future.",
    popularity: 7348.55,
    posterPath: "/nJUHX3XL1jMkk8honUZnUmudFb9.jpg",
    voteAverage: 8.7,
    voteCount: 472
);
final testTVSeriesList = [testTVSeries];

final testTVSeriesTable = TVSeriesTable(
    id: 1,
    name: 'name',
    posterPath: 'posterPath',
    overview: 'overview',
);

final testWatchlistTVSeries = TVSeries.watchlist(
    id: 1,
    overview: 'overview',
    posterPath: 'posterPath',
    name:'name',
);

final testTVSeriesMaping = {
  'id': 1,
  'overview': 'overview',
  'posterPath': 'posterPath',
  'name': 'name',
};

final testTVSeriesDetail = TVSeriesDetail(
  adult: false,
  backdropPath: "/4g5gK5eGWZg8swIZl6eX2AoJp8S.jpg",
  episodeRunTime: [42],
  genres: [Genre(id: 18, name: 'Drama')],
  homepage: "https://www.telemundo.com/shows/pasion-de-gavilanes",
  id: 1,
  name: "name",
  numberOfEpisodes: 259,
  numberOfSeasons: 2,
  originalName: "Pasión de gavilanes",
  overview: "overview",
  popularity: 1747.047,
  posterPath: "posterPath",
  seasons: [
    Season(
      episodeCount: 188,
      id: 72643,
      name: "Season 1",
      posterPath: "/elrDXqvMIX3EcExwCenQMVVmnvd.jpg",
      seasonNumber: 1,
    )
  ],
  status: "Returning Series",
  type: "Scripted",
  voteAverage: 7.6,
  voteCount: 1803,
);
final tTvList = <TVSeries>[];
