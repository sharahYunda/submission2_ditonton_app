part of 'popular_tv_series_bloc.dart';

abstract class SeriesPopularState extends Equatable {
  const SeriesPopularState();
  List<Object> get props => [];
}

class SeriesPopularEmpty extends SeriesPopularState {
  List<Object> get props => [];
}

class SeriesPopularLoading extends SeriesPopularState {
  List<Object> get props => [];
}

class SeriesPopularHasData extends SeriesPopularState {
  final List<TVSeries> result;
  SeriesPopularHasData(this.result);
  List<Object> get props => [result];
}

class SeriesPopularError extends SeriesPopularState {
  final String message;

  SeriesPopularError(this.message);

  @override
  List<Object> get props => [message];
}


