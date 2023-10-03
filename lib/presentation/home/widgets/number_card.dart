import 'package:flutter/material.dart';
import 'package:netflix/core/colors/colors.dart';
import 'package:stroke_text/stroke_text.dart';
import '../../../core/constants.dart';

class NumberCard extends StatelessWidget {
  const NumberCard({super.key, required this.index,required this.imageUrl});
  final int index;
  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Row(
          children: [
            const SizedBox(
              width: 42,
              height: 250,
            ),
            Container(
              width: 170,
              height: 250,
              decoration: BoxDecoration(
                borderRadius: kRadius10,
                image:  DecorationImage(
                  fit: BoxFit.cover,
                  image: NetworkImage(imageUrl,
                  ),
                ),
              ),
            ),
          ],
        ),
        Positioned(
          left: 10,
          bottom: -25,
          child: StrokeText(
            text: "${index + 1}",
            textStyle: TextStyle(fontSize: 130, fontWeight: FontWeight.bold),
            strokeWidth: 8,
            strokeColor: kWhiteColor,
            textColor: kBlackColor,
          ),
        )
      ],
    );
  }
}
