import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/core/failures/main_failure.dart';
import 'package:netflix/domain/hot_and_new/hot_and_new_service.dart';
import 'package:netflix/domain/hot_and_new/models/hot_and_new_resp.dart';

part 'hot_and_new_event.dart';
part 'hot_and_new_state.dart';
part 'hot_and_new_bloc.freezed.dart';

@injectable
class HotAndNewBloc extends Bloc<HotAndNewEvent, HotAndNewState> {
  final HotAndNewService _hotAndNewService;
  HotAndNewBloc(this._hotAndNewService) : super(HotAndNewState.initial()) {
    on<LoadDataInComingSoon>((event, emit) async {
      //loading
      emit(const HotAndNewState(
        comingSoonList: [],
        everyoneIsWatchingList: [],
        isLoading: true,
        isError: false,
      ));

      //get data
      final _result = await _hotAndNewService.getHotAndNewMovieData();

      //ui
      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyoneIsWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonList: resp.results,
            everyoneIsWatchingList: state.everyoneIsWatchingList,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(newState);
    });

    on<LoadDataInEveryoneIsWatching>((event, emit) async {
      //loading
      emit(const HotAndNewState(
        comingSoonList: [],
        everyoneIsWatchingList: [],
        isLoading: true,
        isError: false,
      ));

      //get data
      final _result = await _hotAndNewService.getHotAndNewTvData();

      //ui
      final newState = _result.fold(
        (MainFailure failure) {
          return const HotAndNewState(
            comingSoonList: [],
            everyoneIsWatchingList: [],
            isLoading: false,
            isError: true,
          );
        },
        (HotAndNewResp resp) {
          return HotAndNewState(
            comingSoonList: state.comingSoonList,
            everyoneIsWatchingList: resp.results,
            isLoading: false,
            isError: false,
          );
        },
      );
      emit(newState);
    });
  }
}
