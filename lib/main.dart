import 'package:ditonton/common/constants.dart';
import 'package:ditonton/common/utils.dart';
import 'package:ditonton/movies/presentation/bloc/movie_recomendation_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/movies_detail_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/nowplaying_movie_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/search_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/watchlist_event_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/watchlist_movies_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/watchlist_status_bloc.dart';
import 'package:ditonton/movies/presentation/pages/about_page.dart';
import 'package:ditonton/movies/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/movies/presentation/pages/home_movie_page.dart';
import 'package:ditonton/movies/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/movies/presentation/pages/search_page.dart';
import 'package:ditonton/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/movies/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tvseries_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/recommendation_tvseries_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/search_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tvseries_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/pages/home_tvseries_page.dart';
import 'package:ditonton/tv_series/presentation/pages/tvseries_detail_page.dart';
import 'package:ditonton/tv_series/presentation/pages/popular_tvseries_page.dart';
import 'package:ditonton/tv_series/presentation/pages/tvseries_search_page.dart';
import 'package:ditonton/tv_series/presentation/pages/top_rated_tvseries_page.dart';
import 'package:ditonton/tv_series/presentation/pages/watchlist_tvseries_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:ditonton/injection.dart' as di;

void main() {
  di.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        BlocProvider<WatchlistEventBloc>(
          create: (_) => di.locator<WatchlistEventBloc>(),
        ),
        BlocProvider<WatchlistStatusBloc>(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),
        BlocProvider<MoviesDetailBloc>(
          create: (_) => di.locator<MoviesDetailBloc>(),
        ),
        BlocProvider<NowplayingMovieBloc>(
          create: (_) => di.locator<NowplayingMovieBloc>(),
        ),
        BlocProvider<PopularMoviesBloc>(
          create: (_) => di.locator<PopularMoviesBloc>(),
        ),
        BlocProvider<MovieRecomendationBloc>(
          create: (_) => di.locator<MovieRecomendationBloc>(),
        ),
        BlocProvider<SearchBloc>(
          create: (_) => di.locator<SearchBloc>(),
        ),
        BlocProvider<TopRatedMoviesBloc>(
          create: (_) => di.locator<TopRatedMoviesBloc>(),
        ),
        BlocProvider<WatchlistMoviesBloc>(
          create: (_) => di.locator<WatchlistMoviesBloc>(),
        ),
        BlocProvider<WatchlistEventBloc>(
          create: (_) => di.locator<WatchlistEventBloc>(),
        ),
        BlocProvider<WatchlistStatusBloc>(
          create: (_) => di.locator<WatchlistStatusBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<OnTheAirTvseriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<PopularTvSeriesBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesRecommendationBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesSearchBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesTopRatedBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesDetailBloc>(),
        ),
        BlocProvider(
          create: (_) => di.locator<SeriesWatchlistBloc>(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          colorScheme: kColorScheme,
          primaryColor: kRichBlack,
          scaffoldBackgroundColor: kRichBlack,
          textTheme: kTextTheme,
        ),
        home: HomeMoviePage(),
        navigatorObservers: [routeObserver],
        onGenerateRoute: (RouteSettings settings) {
          switch (settings.name) {
            case '/home':
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case PopularMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularMoviesPage());
            case TopRatedMoviesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedMoviesPage());
            case MovieDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => MovieDetailPage(id: id),
                settings: settings,
              );
            case SearchPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPage());
            case WatchlistMoviesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistMoviesPage());
            case AboutPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => AboutPage());
            case HomeMoviePage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => HomeMoviePage());
            case TVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => TVSeriesPage());
            case PopularTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => PopularTVSeriesPage());
            case TopRatedTVSeriesPage.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => TopRatedTVSeriesPage());
            case TVSeriesDetailPage.ROUTE_NAME:
              final id = settings.arguments as int;
              return MaterialPageRoute(
                builder: (_) => TVSeriesDetailPage(id: id),
                settings: settings,
              );
            case SearchPageTVSeries.ROUTE_NAME:
              return CupertinoPageRoute(builder: (_) => SearchPageTVSeries());
            case WatchlistTVSeriesPage.ROUTE_NAME:
              return MaterialPageRoute(builder: (_) => WatchlistTVSeriesPage());

            default:
              return MaterialPageRoute(builder: (_) {
                return Scaffold(
                  body: Center(
                    child: Text('Page not found :('),
                  ),
                );
              });
          }
        },
      ),
    );
  }
}
