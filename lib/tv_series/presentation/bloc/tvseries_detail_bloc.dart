import 'package:bloc/bloc.dart';

import 'package:ditonton/tv_series/domain/entities/tv_series_detail.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tvseries_detail.dart';
import 'package:equatable/equatable.dart';

part 'tvseries_detail_event.dart';
part 'tvseries_detail_state.dart';

class SeriesDetailBloc extends Bloc<SeriesDetailEvent, SeriesDetailState> {
  final GetTVSeriesDetail getTVSeriesDetail;
  SeriesDetailBloc(this.getTVSeriesDetail) : super(SeriesDetailEmpty()) {
    on<OnSeriesDetailShow>((event, emit) async{
      final id = event.id;
      emit(SeriesDetailLoading());
      final result = await getTVSeriesDetail.execute(id);
      result.fold(
            (failure) {
          emit(SeriesDetailError(failure.message));
        },
            (data) {
          emit(SeriesDetailHasData(data));
        },
      );
    });
  }
}
