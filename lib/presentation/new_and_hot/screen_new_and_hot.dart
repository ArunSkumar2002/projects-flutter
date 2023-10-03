import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:netflix/application/hot_and_new/hot_and_new_bloc.dart';
import 'package:netflix/presentation/home/widgets/custom_button_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/coming_soon_widget.dart';
import 'package:netflix/presentation/new_and_hot/widgets/everyones_watching_widget.dart';
import 'package:netflix/presentation/widgets/video_widget.dart';

import '../../core/colors/colors.dart';
import '../../core/constants.dart';
import '../widgets/app_bar_widget.dart';

class ScreenNewAndHot extends StatelessWidget {
  const ScreenNewAndHot({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: PreferredSize(
            preferredSize: Size.fromHeight(90),
            child: AppBar(
              title: const Text(
                "New & Hot",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w900,
                ),
              ),
              actions: [
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
              bottom: TabBar(
                  labelColor: kBlackColor,
                  labelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  isScrollable: true,
                  unselectedLabelColor: kWhiteColor,
                  unselectedLabelStyle: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                  indicator: BoxDecoration(
                    color: kWhiteColor,
                    borderRadius: kRadius30,
                  ),
                  tabs: const [
                    Tab(
                      text: "🍿 Coming Soon",
                    ),
                    Tab(
                      text: "👀 Everyone's Watching",
                    )
                  ]),
            ),
          ),
          body: const TabBarView(
            children: [
              ComingSoonList(
                key: Key('coming_soon'),
              ),
              EveryoneIsWatchingList(
                key: Key('everyone_is_watching'),
              ),
            ],
          ),
        ));
  }
}

class ComingSoonList extends StatelessWidget {
  const ComingSoonList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context).add(const LoadDataInComingSoon());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInComingSoon());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error'),
            );
          } else if (state.comingSoonList.isEmpty) {
            return const Center(
              child: Text('List is empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(
                  top: 8,
                ),
                itemCount: state.comingSoonList.length,
                itemBuilder: (BuildContext context, index) {
                  final movie = state.comingSoonList[index];
                  if (movie.id == null) {
                    return const SizedBox();
                  }
                  String month = '';
                  String day = '';

                  try {
                    final _date = DateTime.parse(movie.releaseDate!);
                    final formatDate = DateFormat.yMMMMd('en_US').format(_date);
                    //print(formatDate);
                    month = formatDate
                        .split(' ')
                        .first
                        .substring(0, 3)
                        .toUpperCase();
                    day = movie.releaseDate!.split('-')[2];
                  } catch (_) {
                    month = '';
                    day = '';
                  }

                  return ComingSoonWidget(
                    id: movie.id.toString(),
                    month: month,
                    day: day,
                    posterPath: '$imageAppendUrl${movie.posterPath}',
                    movieName: movie.originalTitle ?? 'No title',
                    description: movie.overview ?? 'No description',
                  );
                });
          }
        },
      ),
    );
  }
}

class EveryoneIsWatchingList extends StatelessWidget {
  const EveryoneIsWatchingList({super.key});

  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance!.addPostFrameCallback((_) {
      BlocProvider.of<HotAndNewBloc>(context)
          .add(const LoadDataInEveryoneIsWatching());
    });
    return RefreshIndicator(
      onRefresh: () async {
        BlocProvider.of<HotAndNewBloc>(context)
            .add(const LoadDataInEveryoneIsWatching());
      },
      child: BlocBuilder<HotAndNewBloc, HotAndNewState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(
              child: CircularProgressIndicator(
                strokeWidth: 2,
              ),
            );
          } else if (state.isError) {
            return const Center(
              child: Text('Error'),
            );
          } else if (state.everyoneIsWatchingList.isEmpty) {
            return const Center(
              child: Text('List is empty'),
            );
          } else {
            return ListView.builder(
                padding: const EdgeInsets.only(right: 8, left: 8, top: 10),
                itemCount: state.everyoneIsWatchingList.length,
                itemBuilder: (BuildContext context, index) {
                  final tv = state.everyoneIsWatchingList[index];
                  if (tv.id == null) {
                    return const SizedBox();
                  }
                  return EveryonesWatchingWidget(
                    posterPath: '$imageAppendUrl${tv.posterPath}',
                    movieName: tv.originalName ?? 'No title',
                    description: tv.overview ?? 'No description',
                  );
                });
          }
        },
      ),
    );
  }
}
