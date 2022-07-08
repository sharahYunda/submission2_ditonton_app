// ignore_for_file: unnecessary_null_comparison

import 'package:ditonton/tv_series/data/models/tvseries_model.dart';
import 'package:equatable/equatable.dart';

class TVSeriesResponse extends Equatable {
  final List<TVSeriesModel> tvSeriesList;

  TVSeriesResponse({required this.tvSeriesList});

  factory TVSeriesResponse.fromJson(Map<String, dynamic> json) =>
      TVSeriesResponse(
        tvSeriesList: List<TVSeriesModel>.from((json["results"] as List)
            .map((x) => TVSeriesModel.fromJson(x))
            .where((element) => element.posterPath != null)),
      );

  Map<String, dynamic> toJson() => {
    "results": List<dynamic>.from(tvSeriesList.map((x) => x.toJson())),
  };

  @override
  List<Object> get props => [tvSeriesList];
}