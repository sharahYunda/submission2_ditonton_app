part of 'on_the_air_tvseries_bloc.dart';

abstract class OnTheAirTvseriesState extends Equatable{
  const OnTheAirTvseriesState();

  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesEmpty extends OnTheAirTvseriesState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesLoading extends OnTheAirTvseriesState {
  @override
  List<Object> get props => [];
}

class OnTheAirTvseriesHasData extends OnTheAirTvseriesState {
  final List<TVSeries> result;

  OnTheAirTvseriesHasData(this.result);

  @override
  List<Object> get props => [result];
}

class OnTheAirTvseriesError extends OnTheAirTvseriesState {
  final String message;

  OnTheAirTvseriesError(this.message);

  @override
  List<Object> get props => [message];
}

