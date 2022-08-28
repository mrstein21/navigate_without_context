import 'package:alice/alice.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_statenotifier/main.dart';
import 'package:riverpod_statenotifier/utils/constant.dart';
import '../model/detail_movie.dart';
import '../model/res/movie_res.dart';
import '../utils/logging.dart';
import '../utils/navigator_service.dart';
import '../utils/network/error_handling.dart';
import '../utils/network/interceptor.dart';

class MovieProvider{
  late Dio _dio;
  late Alice _alice;

  MovieProvider(){
    _alice = Alice(
      showNotification: true,
      showInspectorOnShake: false,
      navigatorKey: GetIt.instance<NavigatorService>().navigatorKey,
      maxCallsCount: 1000,
    );

    BaseOptions options  =
    BaseOptions(
        baseUrl: kApiUrl,
        receiveTimeout: 15000,
        connectTimeout: kConnectionTimeout
    );
    _dio = Dio(options);
    _dio.interceptors.add(_alice.getDioInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
  }


  Future<Either<ErrorHandling,DetailMovie>> geDetailMovie(String id) async {
    try {
      final response = await _dio.get(
        '/movie/$id',
        queryParameters: {
          'api_key':kApiKey
        },
      );
      return right(DetailMovie.fromJson(response.data));
    } catch (e, s) {
      logger.e('getDetailMovie', e, s);
      return left(ErrorHandling(e));
    }
  }

  Future<Either<ErrorHandling,MovieRes>> getTopRatedMovie(int page) async {
   try{
    final response = await _dio.get(
      '/movie/top_rated',
      queryParameters: {
        'page':'$page',
        'api_key':kApiKey
      },
    );
      return right(MovieRes.fromJson(response.data));
    } catch (e, s) {
      logger.e('getMoviePopular', e, s);
      return left(ErrorHandling(e));
    }
  }

  Future<Either<ErrorHandling,MovieRes>> getRecommendation(int id) async {
    try {
      final response = await _dio.get(
      '/movie/$id/recommendations',
      queryParameters: {
        'api_key':kApiKey
      },
    );
      return right(MovieRes.fromJson(response.data));
    } catch (e, s) {
      logger.e('getMovieRecommended', e, s);
      return left(ErrorHandling(e));
    }
  }

}