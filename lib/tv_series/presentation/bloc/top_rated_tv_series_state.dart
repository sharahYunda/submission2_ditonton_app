part of 'top_rated_tv_series_bloc.dart';

abstract class SeriesTopRatedState extends Equatable {
  const SeriesTopRatedState();

  @override
  List<Object> get props => [];
}

class SeriesTopRatedEmpty extends SeriesTopRatedState {
   @override
  List<Object> get props => [];
}
class SeriesTopRatedLoading extends SeriesTopRatedState {
  @override
  List<Object> get props => [];
}

class SeriesTopRatedHasData extends SeriesTopRatedState {
  final List<TVSeries> result;

  SeriesTopRatedHasData(this.result);

  @override
  List<Object> get props => [result];
}

class TopRatedTvSeriesError extends SeriesTopRatedState {
  final String message;

  TopRatedTvSeriesError(this.message);

  @override
  List<Object> get props => [message];
}

