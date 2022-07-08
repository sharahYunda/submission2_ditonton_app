part of 'movie_recomendation_bloc.dart';

@immutable
abstract class MovieRecomendationEvent extends Equatable{
  const MovieRecomendationEvent();

  @override
  List<Object> get props => [];
}

class GetMovieRecomendationEvent extends MovieRecomendationEvent {
  final int id;

  GetMovieRecomendationEvent(this.id);
}
