
import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_on_air_tvseries.dart';
import 'package:equatable/equatable.dart';

part 'on_the_air_tvseries_event.dart';
part 'on_the_air_tvseries_state.dart';

class SeriesOnTheAirBloc extends Bloc<SeriesOnTheAirEvent, SeriesOnTheAirState> {
 final GetOnTheAirTVSeries getOnTheAirTVSeries;

  SeriesOnTheAirBloc(this.getOnTheAirTVSeries) : super((OnTheAirTvseriesEmpty())) {
    on<OnTheAirTvseriesShow>((event, emit) async {
      emit(OnTheAirTvseriesLoading());
      final result = await getOnTheAirTVSeries.execute();
      result.fold(
            (failure) {
          emit(OnTheAirTvseriesError(failure.message));
        },
            (data) {
          if (data.isEmpty) {
            emit(OnTheAirTvseriesEmpty());
          } else {
            emit(OnTheAirTvseriesHasData(data));
          }
        },
      );
    });
  }
}
