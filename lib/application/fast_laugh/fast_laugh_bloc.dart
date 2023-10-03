import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:netflix/domain/downloads/i_downloads_repo.dart';

import '../../domain/downloads/models/downloads.dart';

part 'fast_laugh_event.dart';
part 'fast_laugh_state.dart';
part 'fast_laugh_bloc.freezed.dart';

final dummyVideoUrls = [
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/fileSequence49.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/fileSequence5.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/fileSequence51.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/fileSequence52.mp4",
  "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/fileSequence53.mp4"
];

ValueNotifier<Set<int>> likedIdsNotifier = ValueNotifier({});

@injectable
class FastLaughBloc extends Bloc<FastLaughEvent, FastLaughState> {
  FastLaughBloc(
    IDownloadsRepo _downloadService,
  ) : super(FastLaughState.initial()) {
    on<Initialize>((event, emit) async {
      emit(const FastLaughState(
        videosList: [],
        isLoading: true,
        isError: false,
        
      ));
// get movies

      final _result = await _downloadService.getDownloadsImage();
      final _state = _result.fold(
        (l) {
          return FastLaughState(
            videosList: [],
            isLoading: false,
            isError: true,
            
          );
        },
        (resp) => FastLaughState(
          videosList: resp,
          isLoading: false,
          isError: false,
          
        ),
      );

// ui

      emit(_state);
    });

    on<LikeVideo>((event, emit) async {
      likedIdsNotifier.value.add(event.id);
      //likedIdsNotifier.notifyListeners();
    });

    on<UnlikeVideo>((event, emit) async {
           likedIdsNotifier.value.remove(event.id);

    });
  }
}
