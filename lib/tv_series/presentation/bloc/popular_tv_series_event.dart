part of 'popular_tv_series_bloc.dart';

@immutable
abstract class SeriesPopularEvent extends Equatable {
  const SeriesPopularEvent();
}
class OnPopularTvSeriesShow extends SeriesPopularEvent {
  @override
  List<Object?> get props => [];
}
