import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get_it/get_it.dart';
import 'package:riverpod_statenotifier/ui/home/view_model/home_state.dart';
import 'package:riverpod_statenotifier/ui/home/view_model/home_view_model.dart';
import 'package:riverpod_statenotifier/ui/home/widget/loading_view.dart';
import 'package:riverpod_statenotifier/ui/home/widget/movie_view.dart';
import 'package:riverpod_statenotifier/widget/error_view.dart';
import '../../utils/constant.dart';

class HomeScreen extends ConsumerStatefulWidget{
   const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
   final ScrollController _scrollController=ScrollController();
   final homeStateNotifier=GetIt.instance<StateNotifierProvider<HomeViewModel,HomeState>>();

   @override
  void initState() {
     _scrollController.addListener(() {
       listenScroll();
     });
    // TODO: implement initState
    super.initState();
  }

  void listenScroll(){
    final viewModel=ref.read(homeStateNotifier.notifier);
    final state=ref.read(homeStateNotifier);
    if(_scrollController.offset==_scrollController.position.maxScrollExtent ){
      if(state.isLoading==false){
        viewModel.loadData();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state=ref.watch(homeStateNotifier);
    final viewModel=ref.read(homeStateNotifier.notifier);
    return Scaffold(
      backgroundColor:kColorDark,
      appBar: AppBar(
        backgroundColor: kColorBlack,
        title: const Text("Top Rated Movie",style: TextStyle(
          fontSize: 12
        ),),
      ),
      body: state.isLoading && state.list.isEmpty?
          const LoadingView():
          RefreshIndicator(
            onRefresh: ()async{
              viewModel.resetData();
            },
            child: state.isError.isNotEmpty?
            ErrorView(message: state.isError)    
                :
            ListView.builder(
                controller: _scrollController,
                itemCount:
                state.hasReachMax?state.list.length:
                state.list.length+1,
                itemBuilder:(_,index){
                  if(index<state.list.length){
                    return MovieView(movie: state.list[index]);
                  }else{
                    return const LoadingView();
                  }
                }
            )
          )
      );
  }
}
