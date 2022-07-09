import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_top_rated_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'top_rated_tv_series_event.dart';
part 'top_rated_tv_series_state.dart';

class SeriesTopRatedBloc
    extends Bloc<SeriesTopRatedEvent, SeriesTopRatedState> {
  final GetTopRatedTVSeries getTopRatedTVSeries;

  SeriesTopRatedBloc(this.getTopRatedTVSeries) : super(SeriesTopRatedEmpty()) {
    on<OnSeriesTopRatedShow>((event, emit) async {
      emit(SeriesTopRatedLoading());
      final result = await getTopRatedTVSeries.execute();
      result.fold(
            (failure) {
          emit(SeriesTopRatedError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(SeriesTopRatedEmpty());
          } else {
            emit(SeriesTopRatedHasData(data));
          }
        },
      );
    });
  }
}
