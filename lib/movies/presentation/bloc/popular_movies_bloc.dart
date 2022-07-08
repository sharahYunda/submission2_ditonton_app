// ignore_for_file: unused_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/movies/domain/entities/movie.dart';
import 'package:ditonton/movies/domain/usecases/get_popular_movies.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'popular_movies_event.dart';
part 'popular_movies_state.dart';

class PopularMoviesBloc extends Bloc<PopularMoviesEvent, PopularMoviesState> {
  final GetPopularMovies getPopularMovies;
  PopularMoviesBloc({required this.getPopularMovies}) : super(PopularMoviesInitial()) {
    on<PopularMoviesEvent>((event, emit) async {
      emit(PopularMoviesLoading());
      final result = await getPopularMovies.execute();

      result.fold(
            (failure) => emit(PopularMoviesError(failure.message)),
            (result) => emit(PopularMoviesLoaded(result)),
      );
    });
  }
}
