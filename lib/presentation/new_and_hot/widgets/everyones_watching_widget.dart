import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class EveryonesWatchingWidget extends StatelessWidget {
  final String posterPath;
  final String movieName;
  final String description;

  const EveryonesWatchingWidget({
    super.key,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        kHeight,
        Text(
          movieName,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        kHeight,
        Text(
          description,
          maxLines: 4,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(
            color: kGreyColor,
          ),
        ),
        kHeight20,
        VideoWidget(
          url: posterPath,
        ),
        kHeight,
        const Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            CustomButtonWidget(
              title: "Share",
              icon: Icons.share,
              iconSize: 23,
              textSize: 16,
            ),
            kWidth,
            CustomButtonWidget(
              title: "My List",
              icon: Icons.add,
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
            CustomButtonWidget(
              title: "Play",
              icon: Icons.play_arrow,
              iconSize: 25,
              textSize: 16,
            ),
            kWidth,
          ],
        ),
        kHeight20,
      ],
    );
  }
}
