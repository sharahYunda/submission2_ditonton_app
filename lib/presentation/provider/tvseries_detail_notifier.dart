import 'package:ditonton/domain/entities/tv_series.dart';
import 'package:ditonton/domain/entities/tv_series_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_detail.dart';
import 'package:ditonton/domain/usecases/get_tvseries_recommendations.dart';
import 'package:ditonton/common/state_enum.dart';
import 'package:ditonton/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:ditonton/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/domain/usecases/save_tvseries_watchlist.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class TVSeriesDetailNotifier extends ChangeNotifier {
  static const watchlistAddSuccessMessage = 'Added to Watchlist';
  static const watchlistRemoveSuccessMessage = 'Removed from Watchlist';

  final GetTVSeriesDetail getTVSeriesDetail;
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  final GetWatchListTVSeriesStatus getWatchListStatusTVSeries;
  final SaveTVSeriesWatchlist saveTVSeriesWatchlist;
  final RemoveTVSeriesWatchlist removeTVSeriesFromWatchlist;

  TVSeriesDetailNotifier({
    required this.getTVSeriesDetail,
    required this.getTVSeriesRecommendations,
    required this.getWatchListStatusTVSeries,
    required this.saveTVSeriesWatchlist,
    required this.removeTVSeriesFromWatchlist,
  });

  late TVSeriesDetail _tvSeries;
  TVSeriesDetail get tvSeries => _tvSeries;

  RequestState _tvSeriesState = RequestState.Empty;
  RequestState get tvSeriesState => _tvSeriesState;

  List<TVSeries> _tvSeriesRecommendations = [];
  List<TVSeries> get tvSeriesRecommendations => _tvSeriesRecommendations;

  RequestState _recommendationStateTVSeries = RequestState.Empty;
  RequestState get recommendationStateTVSeries => _recommendationStateTVSeries;

  String _message = '';
  String get message => _message;

  bool _isTVSeriesAddedToWatchlist = false;
  bool get isTVSeriesAddedToWatchlist => _isTVSeriesAddedToWatchlist;

  Future<void> fetchTVSeriesDetail(int id) async {
    _tvSeriesState = RequestState.Loading;
    notifyListeners();
    final detailResult = await getTVSeriesDetail.execute(id);
    final recommendationResult = await getTVSeriesRecommendations.execute(id);
    detailResult.fold(
          (failure) {
        _tvSeriesState = RequestState.Error;
        _message = failure.message;
        notifyListeners();
      },
          (tvSeries) {
        _recommendationStateTVSeries = RequestState.Loading;
        _tvSeries = tvSeries;
        notifyListeners();
        recommendationResult.fold(
              (failure) {
            _recommendationStateTVSeries = RequestState.Error;
            _message = failure.message;
          },
              (tvSeries) {
            _recommendationStateTVSeries = RequestState.Loaded;
            _tvSeriesRecommendations = tvSeries;
          },
        );
        _tvSeriesState = RequestState.Loaded;
        notifyListeners();
      },
    );
  }

  String _watchlistMessage = '';
  String get watchlistMessage => _watchlistMessage;

  Future<void> insertTVSeriesWatchlist(TVSeriesDetail movie) async {
    final result = await saveTVSeriesWatchlist.execute(movie);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> removeFromWatchlist(TVSeriesDetail movie) async {
    final result = await removeTVSeriesFromWatchlist.execute(movie);

    await result.fold(
          (failure) async {
        _watchlistMessage = failure.message;
      },
          (successMessage) async {
        _watchlistMessage = successMessage;
      },
    );

    await loadWatchlistStatus(movie.id);
  }

  Future<void> loadWatchlistStatus(int id) async {
    final result = await getWatchListStatusTVSeries.execute(id);
    _isTVSeriesAddedToWatchlist = result;
    notifyListeners();
  }
}
