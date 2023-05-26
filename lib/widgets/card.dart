import 'package:flutter/material.dart';

class CustomCard extends StatelessWidget {
  final double elevation;
  final double borderRadius;
  final double containerHeight;
  final double containerWidth;
  final String title;
  final String title_2;
  final List<Widget> actions;
  final Color bottomColor;

  CustomCard({
    required this.elevation,
    required this.borderRadius,
    required this.containerHeight,
    required this.containerWidth,
    required this.title,
    required this.title_2,
    required this.actions,
    required this.bottomColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
        elevation: elevation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        ),
        child: Column(children: [
          Container(
            height: containerHeight,
            width: containerWidth,
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Row(
                  children: actions,
                ),
              ],
            ),
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.only(bottomLeft: Radius.circular(15),bottomRight: Radius.circular(15)),
              color: bottomColor,
            ),

            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      title_2,
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ],
            ),
          )
        ]
        )
    );
  }
}
