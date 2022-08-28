import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:riverpod_statenotifier/ui/home/home_screen.dart';
import 'package:riverpod_statenotifier/widget/error_view.dart';

import '../ui/detail/detail_screen.dart';

const String homeRoute="/";
const String detailRoute="/detail";

class RouterGenerator{
    static Route<dynamic> generateRoute(RouteSettings settings) {
      final args = settings.arguments;
      if(settings.name==homeRoute){
        return MaterialPageRoute(builder:(_)=>const HomeScreen());
      }else if(settings.name==detailRoute){
        if(args is Map<String,dynamic>){
          String id=args["movie_id"];
          return MaterialPageRoute(builder: (_)=> DetailScreen(id));
        }else{
          return MaterialPageRoute(builder: (_)=>const Scaffold(body: ErrorView(message: "Invalid Parameter")));
        }
      }else{
        return MaterialPageRoute(builder:(_)=>const HomeScreen());
      }
    }
}

// final routesPage={
//   homeRoute:(context)=> const HomeScreen(),
//   detailRoute:(context)=>const DetailScreen()
// };
//
// goToDetail(BuildContext context,int id){
//   Navigator.of(context).pushNamed(detailRoute,arguments: id.toString());
// }