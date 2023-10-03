import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../../core/constants.dart';
import '../../widgets/main_title.dart';
import 'number_card.dart';

class NumberTitleCard extends StatelessWidget {
  const NumberTitleCard({
    Key? key,
    required this.postersList
  }):super(key: key);
final List<String>postersList;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        MainTitle(
          title: "Top 10 shows in India today",
        ),
        kHeight20,
        LimitedBox(
          maxHeight: 230,
          child: ListView(
            padding: EdgeInsets.symmetric(horizontal: 10),
            scrollDirection: Axis.horizontal,
            children: List.generate(10, (index) => NumberCard(index: index,
            imageUrl: postersList[index],)),
          ),
        )
      ],
    );
  }
}
