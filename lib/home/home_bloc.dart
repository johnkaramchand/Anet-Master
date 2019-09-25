import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:anet/home/index.dart';

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
    yield UnHomeState();
    try {
      var x = await event.applyAsync(currentState: currentState, bloc: this);
      print("JOHN ASKED : ${x.props}");
      yield x;
    } catch (_, stackTrace) {
      print('$_ $stackTrace');
      yield currentState;
    }
  }
}
