part of 'popular_tv_series_bloc.dart';

@immutable
abstract class PopularTvSeriesEvent extends Equatable {
  const PopularTvSeriesEvent();
}
class OnPopularTvSeriesShow extends PopularTvSeriesEvent {
  @override
  List<Object?> get props => [];
}
