import 'package:flutter/cupertino.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_statenotifier/provider/movie_provider.dart';
import 'package:riverpod_statenotifier/ui/detail/view_model/detail_state.dart';
import 'package:riverpod_statenotifier/ui/detail/view_model/detail_view_model.dart';
import 'package:riverpod_statenotifier/ui/home/view_model/home_view_model.dart';

import 'ui/home/view_model/home_state.dart';
import 'utils/navigator_service.dart';

void setup() {
  GetIt.I.registerSingleton<NavigatorService>(NavigatorService());
  GetIt.I.registerSingleton<MovieProvider>(MovieProvider());

  //singleton homeviewmodel
  GetIt.I.registerSingleton<StateNotifierProvider<HomeViewModel,HomeState>>(
      StateNotifierProvider<HomeViewModel,HomeState>(
            (ref) => HomeViewModel(),
      )
  );


  //singleton detailviewmodel
  GetIt.I.registerSingleton<StateNotifierProviderFamily<DetailViewModel,DetailState,int>>(
      StateNotifierProvider.family<DetailViewModel,DetailState,int>(
            (ref,int id) => DetailViewModel(id),
      )
  );
}