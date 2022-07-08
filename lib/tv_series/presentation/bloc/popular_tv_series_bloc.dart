
import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_popular_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_tv_series_event.dart';
part 'popular_tv_series_state.dart';

class PopularTvSeriesBloc extends Bloc<PopularTvSeriesEvent, SeriesPopularState> {
  final GetPopularTVSeries _getPopularTvSeries;

  PopularTvSeriesBloc(this._getPopularTvSeries) : super(SeriesPopularEmpty()) {
    on<OnPopularTvSeriesShow>((event, emit) async {
      emit(SeriesPopularLoading());
      final result = await _getPopularTvSeries.execute();

      result.fold(
            (failure) {
          emit(SeriesPopularError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(SeriesPopularEmpty());
          } else {
            emit(SeriesPopularHasData(data));
          }
        },
      );
    });
  }
}
