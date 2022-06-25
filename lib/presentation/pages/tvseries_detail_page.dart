import 'package:cached_network_image/cached_network_image.dart';
import 'package:ditonton/common/constants.dart';
import 'package:ditonton/domain/entities/genre.dart';
import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/presentation/provider/tvseries_detail_notifier.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:provider/provider.dart';

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
      Provider.of<TVSeriesDetailNotifier>(context, listen: false)
          .fetchTVSeriesDetail(widget.id);
      Provider.of<TVSeriesDetailNotifier>(context, listen: false)
          .loadWatchlistStatus(widget.id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<TVSeriesDetailNotifier>(
        builder: (context, provider, child) {
          if (provider.tvSeriesState == RequestState.Loading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.tvSeriesState == RequestState.Loaded) {
            final series = provider.tvSeries;
            return SafeArea(
              child: DetailContent(
                series,
                provider.tvSeriesRecommendations,
                provider.isTVSeriesAddedToWatchlist,
                provider,
              ),
            );
          } else {
            return Text(provider.message);
          }
        },
      ),
    );
  }
}

class DetailContent extends StatelessWidget {
  final TVSeriesDetail tvSeries;
  final List<TVSeries> recommendations;
  final bool isTVSeriesAddedWatchlist;
  final TVSeriesDetailNotifier provider;

  DetailContent(this.tvSeries, this.recommendations, this.isTVSeriesAddedWatchlist, this.provider);

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        CachedNetworkImage(
          imageUrl: '$BASE_IMAGE_URL${tvSeries.posterPath}',
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
                              tvSeries.name,
                              style: kHeading5,
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                if (!isTVSeriesAddedWatchlist) {
                                  await Provider.of<TVSeriesDetailNotifier>(
                                      context,
                                      listen: false)
                                      .insertTVSeriesWatchlist(tvSeries);
                                } else {
                                  await Provider.of<TVSeriesDetailNotifier>(
                                      context,
                                      listen: false)
                                      .removeFromWatchlist(tvSeries);
                                }

                                final message =
                                    Provider.of<TVSeriesDetailNotifier>(context,
                                        listen: false)
                                        .watchlistMessage;

                                if (message ==
                                    TVSeriesDetailNotifier
                                        .watchlistAddSuccessMessage ||
                                    message ==
                                        TVSeriesDetailNotifier
                                            .watchlistRemoveSuccessMessage) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(message)));
                                } else {
                                  showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          content: Text(message),
                                        );
                                      });
                                }
                              },
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  isTVSeriesAddedWatchlist
                                      ? Icon(Icons.check)
                                      : Icon(Icons.add),
                                  Text('Watchlist'),
                                ],
                              ),
                            ),
                            Text(
                              _showGenres(tvSeries.genres),
                            ),
                            Text(
                              _showDuration(tvSeries.episodeRunTime[0]),
                            ),
                            Row(
                              children: [
                                RatingBarIndicator(
                                  rating: tvSeries.voteAverage / 2,
                                  itemCount: 5,
                                  itemBuilder: (context, index) => Icon(
                                    Icons.star,
                                    color: kMikadoYellow,
                                  ),
                                  itemSize: 24,
                                ),
                                Text('${tvSeries.voteAverage}')
                              ],
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Total Episodes: ' +
                                  tvSeries.numberOfEpisodes.toString(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Season: ' + tvSeries.numberOfSeasons.toString(),
                            ),
                            SizedBox(height: 8),
                            Text(
                              'Season',
                              style: kHeading6,
                            ),
                            if (provider.tvSeries.seasons.isEmpty)
                              Container(
                                child: Text(
                                  'There is no Season',
                                ),
                              )
                            else
                              Column(
                                children: <Widget>[
                                  tvSeries.seasons.isNotEmpty
                                      ? Container(
                                    height: 150,
                                    margin: EdgeInsets.only(top: 8.0),
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (ctx, index) {
                                        final season =
                                        tvSeries.seasons[index];
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
                                      itemCount: tvSeries.seasons.length,
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
                              tvSeries.overview,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'Recommendations',
                              style: kHeading6,
                            ),
                            if (provider.tvSeriesRecommendations.isEmpty)
                              Container(
                                child: Text(
                                  'There is no recommendations',
                                ),
                              )
                            else
                              Consumer<TVSeriesDetailNotifier>(
                                builder: (context, data, child) {
                                  if (data.recommendationStateTVSeries ==
                                      RequestState.Loading) {
                                    return Center(
                                      child: CircularProgressIndicator(),
                                    );
                                  } else if (data.recommendationStateTVSeries ==
                                      RequestState.Error) {
                                    return Text(data.message);
                                  } else if (data.recommendationStateTVSeries ==
                                      RequestState.Loaded) {
                                    return SizedBox(
                                      child: Column(
                                        children: <Widget>[
                                          _buildRecommendationsTVSeriesItem(
                                              context),
                                        ],
                                      ),
                                    );
                                  } else {
                                    return Container();
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

  Widget _buildRecommendationsTVSeriesItem(
      BuildContext context,
      ) {
    return Container(
      height: 150,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          final tvSeriesRecommendations = recommendations[index];
          return Padding(
            padding: const EdgeInsets.all(4.0),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacementNamed(
                  context,
                  TVSeriesDetailPage.ROUTE_NAME,
                  arguments: tvSeriesRecommendations.id,
                );
              },
              child: ClipRRect(
                borderRadius: BorderRadius.all(
                  Radius.circular(8),
                ),
                child: CachedNetworkImage(
                  imageUrl:
                  '$BASE_IMAGE_URL${tvSeriesRecommendations.posterPath}',
                  placeholder: (context, url) => Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
          );
        },
        itemCount: recommendations.length,
      ),
    );
  }
}
