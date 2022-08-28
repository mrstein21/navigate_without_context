import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_statenotifier/model/detail_movie.dart';
import 'package:riverpod_statenotifier/utils/network/error_handling.dart';
import '../../../model/res/movie_res.dart';
import '../../../provider/movie_provider.dart';
import '../../../utils/logging.dart';
import 'detail_state.dart';

class DetailViewModel extends StateNotifier<DetailState>{
  DetailViewModel(int id):super(DetailState(detailMovie: DetailMovie())){
    loadData(id);
    loadDataRecommendation(id);
  }

  final MovieProvider _movieProvider=GetIt.instance<MovieProvider>();

  void loadData(int id)async{
      state=state.copyWith(isLoading: true);
      final results= await _movieProvider.geDetailMovie(id.toString());
      results.fold((ErrorHandling err){
        state=state.copyWith(
            isLoading: false,
            isError: err.message
        );
      },(DetailMovie movie){
          state=state.copyWith(
           isLoading: false,
           detailMovie: movie
          );
      });
  }

  void loadDataRecommendation(int id)async {
      state=state.copyWith(isLoadingRecommended: true);
      final result = await _movieProvider.getRecommendation(id);
      result.fold((ErrorHandling err){
        logger.i(("CALL API BECAUSE ${err.message}"));
        state=state.copyWith(
          isLoadingRecommended: false,
        );
      }, (MovieRes res){
        state=state.copyWith(isLoadingRecommended: false,listRecommend: res.results!);
      });
  }

}