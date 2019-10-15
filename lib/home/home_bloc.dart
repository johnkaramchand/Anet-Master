import 'dart:async';
import 'package:anet/authentication_bloc/authentication.dart';
import 'package:bloc/bloc.dart';
import 'package:anet/home/index.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  static final HomeBloc _homeBlocSingleton = HomeBloc._internal();
  factory HomeBloc() {
    return _homeBlocSingleton;
  }
  HomeBloc._internal();

  HomeState get initialState => UnHomeState();

  @override
  Stream<HomeState> mapEventToState(
    HomeEvent event,
  ) async* {
    print("EVENT:  \n\n\n\n $event\n\n\n\n\n");
    if (event is LoadHomeEvent) {
      var x = await event.applyAsync(currentState: currentState, bloc: this);
      print("\n\n\n\nPROPS ${x.props}\n\n\n\n STATE : $x\n\n\n\n");
      try {
        yield ErrorHomeState("$x");
      } catch (error) {
        print("\n\n\n\n\n ERROR: $error \n\n\n\n");
      }
    } else {
      print("EVENT $event");
    }

    try {
      /* var x = await event.applyAsync(currentState: currentState, bloc: this);
      print("JOHN ASKED : ${x.props}");5

      print("Dude this is the current State yeild $currentState");
      print("Dude this is the current State yeild $x");
      yield x; */
      print("WOrked");
    } catch (_, stackTrace) {
      print('\n\n\n\n\nSTACK TRACE \n$_ $stackTrace \n\n\n\n');
      yield currentState;
      //yield InHomeState();
    }
  }
}
