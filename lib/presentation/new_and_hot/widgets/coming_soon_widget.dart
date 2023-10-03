import 'package:flutter/material.dart';

import '../../../core/colors/colors.dart';
import '../../../core/constants.dart';
import '../../home/widgets/custom_button_widget.dart';
import '../../widgets/video_widget.dart';

class ComingSoonWidget extends StatelessWidget {
  final String id;
  final String month;
  final String day;
  final String posterPath;
  final String movieName;
  final String description;

  const ComingSoonWidget({
    super.key,
    required this.id,
    required this.month,
    required this.day,
    required this.posterPath,
    required this.movieName,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Row(
      children: [
        SizedBox(
          width: 50,
          height: 460,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              kHeight,
              Text(
                month,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: kGreyColor,
                ),
              ),
              Text(
                day,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 4,
                ),
              ),
            ],
          ),
        ),
        SizedBox(
          width: size.width - 50,
          height: 460,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              kHeight,
               VideoWidget(url: posterPath,),
              kHeight,
              Row(
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      movieName,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        letterSpacing: -1,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  kWidth,
                  //const Spacer(),
                  const CustomButtonWidget(
                    title: "Remind Me",
                    icon: Icons.alarm,
                    iconSize: 20,
                    textSize: 12,
                  ),
                  kWidth,
                  const CustomButtonWidget(
                    title: "Info",
                    icon: Icons.info,
                    iconSize: 20,
                    textSize: 12,
                  ),
                  kWidth,
                ],
              ),
              kHeight,
              Text(
                "Coming on $day $month",
                style: const TextStyle(
                  fontSize: 14,
                ),
              ),
              kHeight20,
              Text(
                movieName,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              kHeight,
              Text(
                description,
                maxLines: 4,
                //overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: kGreyColor,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
