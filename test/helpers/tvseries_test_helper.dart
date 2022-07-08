import 'package:ditonton/common/db/database_helper.dart';
import 'package:ditonton/tv_series/data/datasources/tvseries_local_data_source.dart';
import 'package:ditonton/tv_series/data/datasources/tvseries_remote_data_source.dart';
import 'package:ditonton/tv_series/domain/repositories/tvseries_repository.dart';
import 'package:mockito/annotations.dart';
import 'package:http/http.dart' as http;

@GenerateMocks([
  TVSeriesRepository,
  TVSeriesRemoteDataSource,
  TVSeriesLocalDataSource,
  DatabaseHelper,
], customMocks: [
  MockSpec<http.Client>(as: #MockHttpClient)
])
void main() {}
