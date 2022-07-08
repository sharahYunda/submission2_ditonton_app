
import 'package:bloc/bloc.dart';
import 'package:ditonton/movies/domain/entities/movie.dart';
import 'package:ditonton/movies/domain/usecases/get_watchlist_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'watchlist_movies_event.dart';
part 'watchlist_movies_state.dart';

class WatchlistMoviesBloc extends Bloc<WatchlistMoviesEvent, WatchlistMoviesState> {
  final GetWatchlistMovies getWatchlistMovies;
  WatchlistMoviesBloc({required this.getWatchlistMovies}) : super(WatchlistMoviesEmpty()) {
    on<WatchlistMoviesEvent>((event, emit) async {
      emit(WatchlistMoviesLoading());
      final result = await getWatchlistMovies.execute();

      result.fold(
            (failure) => emit(WatchlistMoviesError(failure.message)),
            (result) => emit(WatchlistMoviesLoaded(result)),
      );
    });
  }
}
