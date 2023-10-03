import 'package:flutter/material.dart';

import '../../core/constants.dart';

class MainCard extends StatelessWidget {
  final String imageUrl;
  const MainCard({
    Key? key,required this.imageUrl,
  }):super(key:key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        width: 150,
        height: 250,
        decoration: BoxDecoration(
          borderRadius: kRadius10,
          image:  DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(
              imageUrl,  
                        ),
          ),
        ),
      ),
    );
  }
}
