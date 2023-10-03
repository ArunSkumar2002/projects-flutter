import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:netflix/application/home/home_bloc.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:netflix/core/constants.dart';
import 'package:netflix/presentation/home/widgets/background_card.dart';
import 'package:netflix/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/home/widgets/number_card.dart';
import 'package:netflix/presentation/home/widgets/number_title_card.dart';
import 'package:netflix/presentation/widgets/main_title.dart';
import '../widgets/main_card.dart';
import '../widgets/main_title_card.dart';

ValueNotifier<bool> scrollNotifier = ValueNotifier(true);

class ScreenHome extends StatelessWidget {
  const ScreenHome({Key? key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HomeBloc>(context).add(const GetHomeScreenData());
    });
    return Scaffold(
      body: ValueListenableBuilder<bool>(
        valueListenable: scrollNotifier,
        builder: (BuildContext context, bool index, _) {
          return NotificationListener<UserScrollNotification>(
            onNotification: (notification) {
              final ScrollDirection direction = notification.direction!;
              print(direction);
              if (direction == ScrollDirection.reverse) {
                scrollNotifier.value = false;
              } else if (direction == ScrollDirection.forward) {
                scrollNotifier.value = true;
              }
              return true;
            },
            child: Stack(
              children: [
                BlocBuilder<HomeBloc, HomeState>(
                  builder: (context, state) {
                    if (state.isLoading) {
                      return Center(
                        child: CircularProgressIndicator(strokeWidth: 2),
                      );
                    } else if (state.hasError) {
                      return Center(
                        child: const Text(
                          'Error while getting data',
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      );
                    }
                    //realsed past year
                    final _releasedPastYear = state.pastYearMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _releasedPastYear.shuffle();

                    //trending
                    final _trending = state.trendingMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _trending.shuffle();

                    //tense
                      final _tense = state.tenseDramaMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _tense.shuffle();

                    //south
                      final _southIndian = state.southIndianMovieList.map((m) {
                      return '$imageAppendUrl${m.posterPath}';
                    }).toList();
                    _southIndian.shuffle();

                    //top10
                    final _top10tvshow = state.trendingTvList.map((t){
                       return '$imageAppendUrl${t.posterPath}';
                    }).toList();
                    _top10tvshow.shuffle();

                    return ListView(
                      children: [
                        Column(
                          children:  [
                            BackgroundCard(),
                            MainTitleCard(
                              title: "Released in the past year",
                              posterList: _releasedPastYear.sublist(0,10),
                            ),
                            kHeight,
                            MainTitleCard(
                              title: "Trending now",
                              posterList: _trending.sublist(0,10),
                            ),
                            kHeight,
                            NumberTitleCard(
                              postersList: _top10tvshow.sublist(0,10),
                            ),
                            kHeight,
                            MainTitleCard(
                              title: "Tense dramas",
                              posterList: _tense.sublist(0,10),
                            ),
                            kHeight,
                            MainTitleCard(
                              title: "South Indian movies",
                              posterList:_southIndian.sublist(0,10),
                            ),
                            kHeight,
                          ],
                        ),
                      ],
                    );
                  },
                ),
                if (scrollNotifier.value)
                  AnimatedContainer(
                    duration: Duration(milliseconds: 1000),
                    padding: EdgeInsets.only(top: 8),
                    width: double.infinity,
                    height: 90,
                    color: Colors.black.withOpacity(0.3),
                    child: Column(children: [
                      Row(
                        children: [
                          Image.network(
                            'https://cdn-images-1.medium.com/v2/resize:fit:1200/1*ty4NvNrGg4ReETxqU2N3Og.png',
                            width: 60,
                            height: 60,
                          ),
                          const Spacer(),
                          const Icon(
                            Icons.cast,
                            color: kWhiteColor,
                            size: 30,
                          ),
                          kWidth,
                          Container(
                            width: 30,
                            height: 30,
                            color: Colors.blue,
                          ),
                          kWidth,
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            "Tv Shows",
                            style: kHomeTitleText,
                          ),
                          Text(
                            "Movies",
                            style: kHomeTitleText,
                          ),
                          Text(
                            "Categories",
                            style: kHomeTitleText,
                          ),
                        ],
                      )
                    ]),
                  )
                else
                  kHeight,
              ],
            ),
          );
        },
      ),
    );
  }
}
