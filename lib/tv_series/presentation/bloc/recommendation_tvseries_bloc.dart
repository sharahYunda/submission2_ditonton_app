import 'package:bloc/bloc.dart';
import 'package:ditonton/tv_series/domain/entities/tv_series.dart';
import 'package:ditonton/tv_series/domain/usecases/get_tvseries_recommendations.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'recommendation_tvseries_event.dart';
part 'recommendation_tvseries_state.dart';

class SeriesRecommendationBloc extends Bloc<SeriesRecommendationEvent, SeriesRecommendationState> {
  final GetTVSeriesRecommendations getTVSeriesRecommendations;
  SeriesRecommendationBloc(this.getTVSeriesRecommendations) : super(SeriesRecommendationEmpty()) {
    on<OnRecommendationTvSeriesShow>((event, emit) async{
      final id = event.id;
      emit(SeriesRecommendationLoading());
      final result = await getTVSeriesRecommendations.execute(id);

      result.fold(
            (failure) {
          emit(SeriesRecommendationError(failure.message));
        },
            (data) {
          emit(SeriesRecommendationHasData(data));
        },
      );
    });
  }
}
