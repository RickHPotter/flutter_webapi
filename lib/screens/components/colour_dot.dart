import 'package:flutter/material.dart';

class ColourDot extends StatelessWidget {
  final Color? colour;
  const ColourDot({Key? key, required this.colour}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 4.0),
      child: Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            color: colour,
            borderRadius: BorderRadius.circular(10),
          )
      ),
    );
  }
}
