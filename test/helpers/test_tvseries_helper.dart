import 'package:bloc_test/bloc_test.dart';
import 'package:ditonton/tv_series/presentation/bloc/on_the_air_tvseries_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/tvseries_detail_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/popular_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/recommendation_tvseries_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/top_rated_tv_series_bloc.dart';
import 'package:ditonton/tv_series/presentation/bloc/watchlist_tv_series_bloc.dart';
import 'package:mocktail/mocktail.dart';

// On the air
class FakeOnTheAirTvSeriesEvent extends Fake
    implements SeriesOnTheAirEvent {}

class FakeOnTheAirTvSeriesState extends Fake
    implements SeriesOnTheAirState {}

class FakeOnTheAirTvSeriesBloc
    extends MockBloc<SeriesOnTheAirEvent, SeriesOnTheAirState>
    implements SeriesOnTheAirBloc {}

// Top Rated
class FakeSeriesTopRatedEvent extends Fake implements SeriesTopRatedEvent {}

class FakeSeriesTopRatedState extends Fake implements SeriesTopRatedState {}

class FakeSeriesTopRatedBloc
    extends MockBloc<SeriesTopRatedEvent, SeriesTopRatedState>
    implements SeriesTopRatedBloc {}

// Popular
class FakeSeriesPopularEvent extends Fake implements SeriesPopularEvent {}

class FakeSeriesPopularState extends Fake implements SeriesPopularState {}

class FakePopularSeriesBloc
    extends MockBloc<SeriesPopularEvent, SeriesPopularState>
    implements SeriesPopularBloc {}

// Detail Tv Series
class FakeSeriesDetailEvent extends Fake implements SeriesDetailEvent {}

class FakeSeriesDetailState extends Fake implements SeriesDetailState {}

class FakeDetailTVSeriesBloc
    extends MockBloc<SeriesDetailEvent, SeriesDetailState>
    implements SeriesDetailBloc {}


// Watch List
class FakeSeriesWatchlistEvent extends Fake
    implements SeriesWatchlistEvent {}

class FakeSeriesWatchlistState extends Fake
    implements SeriesWatchlistState {}

class FakeSeriesWatchlistBloc
    extends MockBloc<SeriesWatchlistEvent, SeriesWatchlistState>
    implements SeriesWatchlistBloc {}

// Recommendation
class FakeSeriesRecommendationEvent extends Fake
    implements SeriesRecommendationEvent {}

class FakeSeriesRecommendationState extends Fake
    implements SeriesRecommendationState {}

class FakeSeriesRecommendationsBloc
    extends MockBloc<SeriesRecommendationEvent, SeriesRecommendationState>
    implements SeriesRecommendationBloc {}