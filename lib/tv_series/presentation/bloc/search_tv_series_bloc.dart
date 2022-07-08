import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/search_tvseries.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';

part 'search_tv_series_event.dart';
part 'search_tv_series_state.dart';

class SeriesSearchBloc
    extends Bloc<SeriesSearchEvent, SeriesSearchState> {
  late final SearchTVSeries searchTVSeries;
  SeriesSearchBloc(this.searchTVSeries) : super(SeriesSearchEmpty()) {
    EventTransformer<T> debounce<T>(Duration duration) {
      return ((events, mapper) =>
          events.debounceTime(duration).flatMap(mapper));
    }
    on<queryChanged>((event, emit) async {
      final query = event.query;

      emit(SeriesSearchLoading());
      final result = await searchTVSeries.execute(query);

      result.fold(
            (failure) {
          emit(SeriesSearchError(failure.message));
        },
            (data) {
          emit(SeriesSearchHasData(data));
        },
      );
    }, transformer: debounce(const Duration(milliseconds: 500)));
  }
}
