part of 'recommendation_tvseries_bloc.dart';

abstract class SeriesRecommendationEvent extends Equatable{
  const SeriesRecommendationEvent();
}
class OnRecommendationTvSeriesShow extends SeriesRecommendationEvent {
  final int id;

  OnRecommendationTvSeriesShow(this.id);

  @override
  List<Object?> get props => [];
}