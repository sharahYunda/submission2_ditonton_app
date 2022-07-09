import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/movies/domain/entities/movie.dart';
import 'package:ditonton/movies/presentation/bloc/nowplaying_movie_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/popular_movies_bloc.dart';
import 'package:ditonton/movies/presentation/bloc/top_rated_movies_bloc.dart';
import 'package:ditonton/movies/presentation/pages/about_page.dart';
import 'package:ditonton/movies/presentation/pages/movie_detail_page.dart';
import 'package:ditonton/movies/presentation/pages/popular_movies_page.dart';
import 'package:ditonton/movies/presentation/pages/search_page.dart';
import 'package:ditonton/movies/presentation/pages/top_rated_movies_page.dart';
import 'package:ditonton/movies/presentation/pages/watchlist_movies_page.dart';
import 'package:ditonton/tv_series/presentation/pages/home_tvseries_page.dart';
import 'package:ditonton/tv_series/presentation/pages/watchlist_tvseries_page.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeMoviePage extends StatefulWidget {
  static const ROUTE_NAME = '/movies';

  @override
  _HomeMoviePageState createState() => _HomeMoviePageState();
}

class _HomeMoviePageState extends State<HomeMoviePage> {
  @override
  void initState() {
    super.initState();
    context.read<NowplayingMovieBloc>().add(GetNowplayingMovieEvent());
    context.read<PopularMoviesBloc>().add(GetPopularMoviesEvent());
    context.read<TopRatedMoviesBloc>().add(GetTopRatedMoviesEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: Column(
          children: [
            UserAccountsDrawerHeader(
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/circle-g.png'),
              ),
              accountName: Text('Ditonton'),
              accountEmail: Text('ditonton@dicoding.com'),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'Movie',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('Movies'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('Movie Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistMoviesPage.ROUTE_NAME);
              },
            ),
            Divider(
              color: Colors.white,
              height: 20,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 10.0, bottom: 8.0),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  'TV Series',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.movie),
              title: Text('TV Series'),
              onTap: () {
                Navigator.pushNamed(context, TVSeriesPage.ROUTE_NAME);
              },
            ),
            ListTile(
              leading: Icon(Icons.save_alt),
              title: Text('TV Series Watchlist'),
              onTap: () {
                Navigator.pushNamed(context, WatchlistTVSeriesPage.ROUTE_NAME);
              },
            ),
            Divider(
              color: Colors.white,
              height: 20,
              thickness: 2,
              indent: 10,
              endIndent: 10,
            ),
            ListTile(
              onTap: () {
                Navigator.pushNamed(context, AboutPage.ROUTE_NAME);
              },
              leading: Icon(Icons.info_outline),
              title: Text('About'),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        title: Text('Ditonton'),
        actions: [
          IconButton(
            onPressed: () {
              FirebaseCrashlytics.instance.crash();
              Navigator.pushNamed(context, SearchPage.ROUTE_NAME);
            },
            icon: Icon(Icons.search),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Now Playing',
                style: kHeading6,
              ),
              BlocBuilder<NowplayingMovieBloc, NowplayingMovieState>(
                builder: (context, state) {
                  if (state is NowplayingMovieLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is NowplayingMovieLoaded) {
                    return MovieList(state.result);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Popular',
                onTap: () =>
                    Navigator.pushNamed(context, PopularMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<PopularMoviesBloc, PopularMoviesState>(
                builder: (context, state) {
                  if (state is PopularMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is PopularMoviesLoaded) {
                    return MovieList(state.result);
                  } else {
                    return Text('Failed');
                  }
                },
              ),
              _buildSubHeading(
                title: 'Top Rated',
                onTap: () =>
                    Navigator.pushNamed(context, TopRatedMoviesPage.ROUTE_NAME),
              ),
              BlocBuilder<TopRatedMoviesBloc, TopRatedMoviesState>(
                builder: (context, state) {
                  if (state is TopRatedMoviesLoading) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (state is TopRatedMoviesLoaded) {
                    return MovieList(state.result);
                  } else {
                    return Text('Failed');
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  Row _buildSubHeading({required String title, required Function() onTap}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: kHeading6,
        ),
        InkWell(
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [Text('See More'), Icon(Icons.arrow_forward_ios)],
            ),
          ),
        ),
      ],
    );
  }
}

class MovieList extends StatelessWidget {
  final List<Movie> movies;

  MovieList(this.movies);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final movie = movies[index];
          return Container(
            padding: const EdgeInsets.all(8),
            child: InkWell(
              onTap: () {
                Navigator.pushNamed(
                  context,
                  MovieDetailPage.ROUTE_NAME,
                  arguments: movie.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(16)),
                child: CachedNetworkImage(
                  imageUrl: '$BASE_IMAGE_URL${movie.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: movies.length,
      ),
    );
  }
}
