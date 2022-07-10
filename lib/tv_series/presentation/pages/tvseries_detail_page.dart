import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/movies/domain/entities/genre.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/presentation/bloc/recommendation_tvseries_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tvseries_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/pages/watchlist_tvseries_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class TVSeriesDetailPage extends StatefulWidget {
  static const ROUTE_NAME = '/detail-tv_series';

  final int id;
  TVSeriesDetailPage({required this.id});

  @override
  _TVSeriesDetailPageState createState() => _TVSeriesDetailPageState();
}

class _TVSeriesDetailPageState extends State<TVSeriesDetailPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      context.read<SeriesDetailBloc>()
          .add(OnSeriesDetailShow(widget.id));
      context.read<SeriesWatchlistBloc>()
          .add(SeriesWatchlist(widget.id));
      context.read<SeriesRecommendationBloc>()
          .add(OnRecommendationTvSeriesShow(widget.id));
    });
  }

  @override
  Widget build(BuildContext context) {
    final statusWatchlist =
    context.select<SeriesWatchlistBloc, bool>((value) {
      if (value.state is AddWatchlist) {
        return (value.state as AddWatchlist).status;
      }
      return false;
    });

    return Scaffold(
      body: BlocBuilder<SeriesDetailBloc, SeriesDetailState>(
        builder: (context, state) {
          if (state is SeriesDetailLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is SeriesDetailHasData) {
            final tvSeries = state.result;
            return SafeArea(
              child: DetailContent(tvSeries, statusWatchlist),
            );
          } else if (state is SeriesDetailError) {
            return Center(
              child: Text(state.message),
            );
          } else {
            return Center(
                child: Text("Empty"));
          }
        },
      ),
    );
  }
}

// ignore: must_be_immutable
class DetailContent extends StatefulWidget {
  final TVSeriesDetail tvSeries;
  late bool isTVSeriesAddedWatchlist;

  DetailContent(this.tvSeries, this.isTVSeriesAddedWatchlist);

  @override
  State<DetailContent> createState() => _DetailContentState();
}

class _DetailContentState extends State<DetailContent> {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${widget.tvSeries.posterPath}',
          width: screenWidth,
          placeholder: (context, url) => Center(
            child: CircularProgressIndicator(),
          ),
          errorWidget: (context, url, error) => Icon(Icons.error),
        ),
        Container(
          margin: const EdgeInsets.only(top: 48 + 8),
          child: DraggableScrollableSheet(
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: kRichBlack,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
                ),
                padding: const EdgeInsets.only(
                  left: 16,
                  top: 16,
                  right: 16,
                ),
                child: Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 16),
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!widget.isTVSeriesAddedWatchlist) {
                                  context.read<SeriesWatchlistBloc>().add(
                                      AddSeriesWatchlist(widget.tvSeries));
                                } else {
                                  context.read<SeriesWatchlistBloc>().add(
                                      DeleteSeriesWatchlist(widget.tvSeries));
                                }

                                final state =
                                    BlocProvider.of<SeriesWatchlistBloc>(
                                        context)
                                        .state;
                                String message = "";
                                String insertMessage = "Added to Watchlist";
                                String removeMessage = "Removed from Watchlist";

                                if (state is AddWatchlist) {
                                  final isAdded = state.status;
                                  if (isAdded == false) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                } else {
                                  if (!widget.isTVSeriesAddedWatchlist) {
                                    message = insertMessage;
                                  } else {
                                    message = removeMessage;
                                  }
                                }

                                if (message == insertMessage ||
                                    message == removeMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(message),
                                      action: SnackBarAction(
                                        label: 'See Watchlist',
                                        onPressed: () {
                                          Navigator.pushNamed(context,
                                              WatchlistTVSeriesPage.ROUTE_NAME);
                                        },
                                      ),
                                    ),
                                  );
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }

                                setState(() {
                                  widget.isTVSeriesAddedWatchlist =
                                  !widget.isTVSeriesAddedWatchlist;
                                });
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  widget.isTVSeriesAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(widget.tvSeries.genres),
                            ),
                            Text(
                              _formattedDuration(widget.tvSeries.episodeRunTime),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: widget.tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${widget.tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Total Episodes: ' +
                                  widget.tvSeries.numberOfEpisodes.toString(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Season: ' + widget.tvSeries.numberOfSeasons.toString(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            Column(
                                children: <Widget>[
                                  widget.tvSeries.seasons.isNotEmpty
                                      ? Container(
                                    height: 150,
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        final season =
                                        widget.tvSeries.seasons[index];
                                        return Padding(
                                          padding: EdgeInsets.all(4.0),
                                          child: ClipRRect(
                                            borderRadius:
                                            BorderRadius.all(
                                              Radius.circular(8),
                                            ),
                                            child: season.posterPath ==
                                                null
                                                ? Container(
                                              width: 96.0,
                                              decoration:
                                              BoxDecoration(
                                                color: kGrey,
                                              ),
                                              child: Center(
                                                child: Icon(
                                                  Icons.hide_image,
                                                ),
                                              ),
                                            )
                                                : CachedNetworkImage(
                                              imageUrl:
                                              '$BASE_IMAGE_URL${season.posterPath}',
                                              placeholder:
                                                  (context, url) =>
                                                  Center(
                                                    child:
                                                    CircularProgressIndicator(),
                                                  ),
                                              errorWidget: (context,
                                                  url, error) =>
                                                  Icon(Icons.error),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: widget.tvSeries.seasons.length,
                                    ),
                                  )
                                      : Text('-'),
                                ],
                              ),
                            SizedBox(height: 20),
                            Text(
                              'Overview',
                              style: kHeading6,
                            ),
                            Text(
                              widget.tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            BlocBuilder<SeriesRecommendationBloc,
                                SeriesRecommendationState>(
                              builder: (context, state) {
                                if (state is SeriesRecommendationLoading) {
                                  return Center(
                                    child: CircularProgressIndicator(),
                                  );
                                } else if (state
                                is SeriesRecommendationError) {
                                  return Text(state.message);
                                } else if (state
                                is SeriesRecommendationHasData) {
                                  final result = state.result;
                                  return Container(
                                    height: 150,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        final tvSeries = result[index];
                                        return Padding(
                                          padding: const EdgeInsets.all(4.0),
                                          child: InkWell(
                                            onTap: () {
                                              Navigator.pushReplacementNamed(
                                                context,
                                                TVSeriesDetailPage.ROUTE_NAME,
                                                arguments: tvSeries.id,
                                              );
                                            },
                                            child: ClipRRect(
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(8),
                                              ),
                                              child: CachedNetworkImage(
                                                imageUrl:
                                                '$BASE_IMAGE_URL${tvSeries.posterPath}',
                                                placeholder: (context, url) =>
                                                    Center(
                                                      child:
                                                      CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                    Icon(Icons.error),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                      itemCount: result.length,
                                    ),
                                  );
                                } else {
                                  return Text('no recommendations');
                                }
                              },
                            ),
                            SizedBox(height: 16),

                          ],
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.topCenter,
                      child: Container(
                        color: Colors.white,
                        height: 4,
                        width: 48,
                      ),
                    ),
                  ],
                ),
              );
            },
            // initialChildSize: 0.5,
            minChildSize: 0.25,
            // maxChildSize: 1.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundColor: kRichBlack,
            foregroundColor: Colors.white,
            child: IconButton(
              icon: Icon(Icons.arrow_back),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        )
      ],
    );
  }

  String _showGenres(List<Genre> genres) {
    String result = '';
    for (var genre in genres) {
      result += genre.name + ', ';
    }

    if (result.isEmpty) {
      return result;
    }

    return result.substring(0, result.length - 2);
  }

  String _showDuration(int runtime) {
    final int hours = runtime ~/ 60;
    final int minutes = runtime % 60;

    if (hours > 0) {
      return '${hours}h ${minutes}m';
    } else {
      return '${minutes}m';
    }
  }
  String _formattedDuration(List<int> runtimes) =>
      runtimes.map((runtime) => _showDuration(runtime)).join(", ");
}
