// ignore_for_file: unused_import

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:ditonton/movies/domain/entities/movie_detail.dart';
import 'package:ditonton/movies/domain/usecases/get_movie_detail.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'movies_detail_event.dart';
part 'movies_detail_state.dart';

class MoviesDetailBloc extends Bloc<MoviesDetailEvent, MoviesDetailState> {
  final GetMovieDetail getMovieDetail;
  MoviesDetailBloc({required this.getMovieDetail}) : super(MoviesDetailInitial()) {
    on<OnDetailMoviesShow>((event, emit) async {
      emit(MoviesDetailLoading());
      final result = await getMovieDetail.execute(event.id);

      result.fold(
            (failure) => emit(MoviesDetailError(failure.message)),
            (result) => emit(MoviesDetailHasData(result)),
      );
    });
  }
}
