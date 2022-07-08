import 'package:ditonton/common/db/database_helper.dart';
import 'package:ditonton/movies/data/datasources/movie_local_data_source.dart';
import 'package:ditonton/movies/data/datasources/movie_remote_data_source.dart';
import 'package:ditonton/movies/presentation/bloc/movies_detail_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/nowplaying_movie_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/search_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/watchlist_event_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/watchlist_status_bloc.dart';
import 'package:ditonton/tv_series/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/tv_series/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/movies/data/repositories/movie_repository_impl.dart';
import 'package:ditonton/tv_series/data/repositories/tvseries_repository_impl.dart';
import 'package:ditonton/movies/domain/repositories/movie_repository.dart';
import 'package:ditonton/tv_series/domain/repositories/tvseries_repository.dart';
import 'package:ditonton/movies/domain/usecases/get_movie_detail.dart';
import 'package:ditonton/movies/domain/usecases/get_movie_recommendations.dart';
import 'package:ditonton/movies/domain/usecases/get_now_playing_movies.dart';
import 'package:ditonton/movies/domain/usecases/get_popular_movies.dart';
import 'package:ditonton/movies/domain/usecases/get_top_rated_movies.dart';
import 'package:ditonton/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:ditonton/movies/domain/usecases/get_watchlist_status.dart';
import 'package:ditonton/movies/domain/usecases/remove_watchlist.dart';
import 'package:ditonton/movies/domain/usecases/save_watchlist.dart';
import 'package:ditonton/movies/domain/usecases/search_movies.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/tv_series/domain/usecases/get_on_air_tvseries.dart';
import 'package:ditonton/tv_series/domain/usecases/get_popular_tvseries.dart';
import 'package:ditonton/tv_series/domain/usecases/get_top_rated_tvseries.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:ditonton/tv_series/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/tv_series/domain/usecases/save_tvseries_watchlist.dart';
import 'package:ditonton/tv_series/domain/usecases/search_tvseries.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tvseries_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/recommendation_tvseries_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/search_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tvseries_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:get_it/get_it.dart';

import 'movies/presentation/bloc/movie_recomendation_bloc.dart';

final locator = GetIt.instance;

void init() {
  // provider

  locator.registerFactory(
    () =>  MoviesDetailBloc(
      getMovieDetail: locator(),
  ),
  );
  locator.registerFactory(
    () => NowplayingMovieBloc(
    getNowPlayingMovies: locator(),
  ),
  );
  locator.registerFactory(
    () => SearchBloc(
  searchMovies: locator(),
  ),
  );
  locator.registerFactory(
    () => PopularMoviesBloc(
  getPopularMovies: locator(),
  ),
  );
  locator.registerFactory(
    () => TopRatedMoviesBloc(
      getTopRatedMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistMoviesBloc(
      getWatchlistMovies: locator(),
    ),
  );
  locator.registerFactory(
        () => WatchlistEventBloc(
      removeWatchlist: locator(),
      saveWatchlist: locator(),
    ),
  );
  locator.registerFactory(
    () => WatchlistStatusBloc(
      getWatchListStatus: locator(),
    ),
  );
  locator.registerFactory(
        () => MovieRecomendationBloc(
          getMovierecomandations: locator(),
    ),
  );


  // provider tvseries

  locator.registerFactory(
        () => SeriesDetailBloc(locator(),
        ),
  );
  locator.registerFactory(
        () => SeriesRecommendationBloc(locator(),
        ),
  );
  locator.registerFactory(
        () => SeriesSearchBloc(locator(),
        ),
  );
  locator.registerFactory(
        () => OnTheAirTvseriesBloc(locator(),
        ),
  );
  locator.registerFactory(
        () => PopularTvSeriesBloc(locator(),
        ),
  );
  locator.registerFactory(
        () => SeriesTopRatedBloc(locator(),
        ),
  );
  locator.registerFactory(
        () => SeriesWatchlistBloc(locator(),
          locator(),
          locator(),
          locator(),
        ),
  );

  // use case
  locator.registerLazySingleton(() => GetNowPlayingMovies(locator()));
  locator.registerLazySingleton(() => GetPopularMovies(locator()));
  locator.registerLazySingleton(() => GetTopRatedMovies(locator()));
  locator.registerLazySingleton(() => GetMovieDetail(locator()));
  locator.registerLazySingleton(() => GetMovieRecommendations(locator()));
  locator.registerLazySingleton(() => SearchMovies(locator()));
  locator.registerLazySingleton(() => GetWatchListStatus(locator()));
  locator.registerLazySingleton(() => SaveWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistMovies(locator()));

  // use case TV Series
  locator.registerLazySingleton(() => GetOnTheAirTVSeries(locator()));
  locator.registerLazySingleton(() => GetPopularTVSeries(locator()));
  locator.registerLazySingleton(() => GetTopRatedTVSeries(locator()));
  locator.registerLazySingleton(() => GetTVSeriesDetail(locator()));
  locator.registerLazySingleton(() => GetTVSeriesRecommendations(locator()));
  locator.registerLazySingleton(() => SearchTVSeries(locator()));
  locator.registerLazySingleton(() => GetWatchListTVSeriesStatus(locator()));
  locator.registerLazySingleton(() => SaveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => RemoveTVSeriesWatchlist(locator()));
  locator.registerLazySingleton(() => GetWatchlistTVSeries(locator()));

  // repository
  locator.registerLazySingleton<MovieRepository>(
    () => MovieRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );

  // repository TV Series
  locator.registerLazySingleton<TVSeriesRepository>(
        () => TVSeriesRepositoryImpl(
      remoteDataSource: locator(),
      localDataSource: locator(),
    ),
  );


  // data sources
  locator.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl(databaseHelper: locator()));

  // data sources TV Series
  locator.registerLazySingleton<TVSeriesRemoteDataSource>(
          () => TVSeriesRemoteDataSourceImpl(client: locator()));
  locator.registerLazySingleton<TVSeriesLocalDataSource>(
          () => TVSeriesLocalDataSourceImpl(databaseHelper: locator()));

  // helper
  locator.registerLazySingleton<DatabaseHelper>(() => DatabaseHelper());

  // external
  locator.registerLazySingleton(() => http.Client());
}
