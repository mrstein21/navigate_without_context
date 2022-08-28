import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_statenotifier/model/res/movie_res.dart';
import 'package:riverpod_statenotifier/provider/movie_provider.dart';
import 'package:riverpod_statenotifier/ui/home/view_model/home_state.dart';
import 'package:riverpod_statenotifier/utils/network/error_handling.dart';


class HomeViewModel extends StateNotifier<HomeState>{
  HomeViewModel():super(const HomeState()){
    loadData();
  }

  final MovieProvider _movieProvider=GetIt.instance<MovieProvider>();

  void loadData()async{
      state=state.copyWith(isLoading: true);
      final result= await _movieProvider.getTopRatedMovie(state.page);
      result.fold((ErrorHandling err){
        state=state.copyWith(
            isLoading: false,
            isError: err.message
        );
      },(MovieRes res){
        state=state.addListMovie(res.results!);
      });
  }

  void resetData()async{
    state=state.copyWith(isLoading: true);
    final result= await _movieProvider.getTopRatedMovie(1);
    result.fold((ErrorHandling err){
      state=state.copyWith(
          isLoading: false,
          isError: err.message
      );
    },(MovieRes res){
      state=state.addListMovie(res.results!);
    });
  }



}