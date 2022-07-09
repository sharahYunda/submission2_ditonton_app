part of 'on_the_air_tvseries_bloc.dart';

abstract class SeriesOnTheAirState extends Equatable{
  const SeriesOnTheAirState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesEmpty extends SeriesOnTheAirState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesLoading extends SeriesOnTheAirState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesHasData extends SeriesOnTheAirState {
  final List<TVSeries> result;

  OnTheAirTvseriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class OnTheAirTvseriesError extends SeriesOnTheAirState {
  final String message;

  OnTheAirTvseriesError(this.message);

  @override
  List<Object> get props => [message];
}

