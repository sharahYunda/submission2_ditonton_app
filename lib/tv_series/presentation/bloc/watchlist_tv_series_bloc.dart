
import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tvseries.dart';
import 'package:ditonton/tv_series/domain/usecases/get_watchlist_tvseries_status.dart';
import 'package:ditonton/tv_series/domain/usecases/remove_tvseries_watchlist.dart';
import 'package:ditonton/tv_series/domain/usecases/save_tvseries_watchlist.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_tv_series_event.dart';
part 'watchlist_tv_series_state.dart';

class SeriesWatchlistBloc extends Bloc<SeriesWatchlistEvent, SeriesWatchlistState> {
  final GetWatchlistTVSeries getWatchlistTVSeries;
  final GetWatchListTVSeriesStatus getWatchListTVSeriesStatus;
  final RemoveTVSeriesWatchlist removeTVSeriesWatchlist;
  final SaveTVSeriesWatchlist saveTVSeriesWatchlist;
  
  SeriesWatchlistBloc(
    this.getWatchlistTVSeries,
    this.getWatchListTVSeriesStatus,
    this.removeTVSeriesWatchlist,
    this.saveTVSeriesWatchlist
  ) : super(SeriesWatchlistEmpty()) {
    on<OnSeriesWatchlist>((event, emit) async{
      emit(SeriesWatchlistLoading());

      final result = await getWatchlistTVSeries.execute();

      result.fold(
            (failure) {
          emit(SeriesWatchlistError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(SeriesWatchlistEmpty());
          } else {
            emit(SeriesWatchlistHasData(data));
          }
        },
      );
    });
    on<SeriesWatchlist>((event, emit) async {

      final id = event.id;

      final result = await getWatchListTVSeriesStatus.execute(id);

      emit(AddWatchlist(result));
    });

    on<AddSeriesWatchlist>((event, emit) async {
      emit(SeriesWatchlistLoading());
      final movie = event.seriesDetail;

      final result = await saveTVSeriesWatchlist.execute(movie);

      result.fold(
            (failure) {
          emit(SeriesWatchlistError(failure.message));
        },
            (message) {
          emit(MessageSeriesWatchlist(message));
        },
      );
    });

    on<DeleteSeriesWatchlist>((event, emit) async {
      final movie = event.seriesDetail;

      final result = await removeTVSeriesWatchlist.execute(movie);

      result.fold(
            (failure) {
          emit(SeriesWatchlistError(failure.message));
        },
            (message) {
          emit(MessageSeriesWatchlist(message));
        },
      );
    });
  }
}
