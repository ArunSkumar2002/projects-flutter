import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new/models/hot_and_new_resp.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final HotAndNewService _homeService;
  HomeBloc(this._homeService) : super(HomeState.initial()) {
//home

    on<GetHomeScreenData>((event, emit) async {
//loading

      emit(state.copyWith(isLoading: true, hasError: false));

      final _mResult = await _homeService.getHotAndNewMovieData();
      final _tvResult = await _homeService.getHotAndNewTvData();

      final _state1 = _mResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramaMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          final pastyear = resp.results;
          final trending = resp.results;
          final dramas = resp.results;
          final southInd = resp.results;
          pastyear.shuffle();
          trending.shuffle();
          dramas.shuffle();
          southInd.shuffle();

          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: pastyear,
            trendingMovieList: trending,
            tenseDramaMovieList: dramas,
            southIndianMovieList: southInd,
            trendingTvList: state.trendingTvList,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(_state1);

      final _state2 = _tvResult.fold(
        (MainFailure failure) {
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: [],
            trendingMovieList: [],
            tenseDramaMovieList: [],
            southIndianMovieList: [],
            trendingTvList: [],
            isLoading: false,
            hasError: true,
          );
        },
        (HotAndNewResp resp) {
          final top10 = resp.results;
          return HomeState(
            stateId: DateTime.now().millisecondsSinceEpoch.toString(),
            pastYearMovieList: state.pastYearMovieList,
            trendingMovieList: state.trendingMovieList,
            tenseDramaMovieList: state.tenseDramaMovieList,
            southIndianMovieList: state.southIndianMovieList,
            trendingTvList: top10,
            isLoading: false,
            hasError: false,
          );
        },
      );

      emit(_state2);
    });
  }
}