import 'package:flutter/material.dart';
import 'package:flutter_covid19_tracker/utils/constants.dart';

class NavigationOption extends StatelessWidget {
  final String title;
  final bool selected;
  final Function() onSelected;

  NavigationOption(
      {required this.title, required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onSelected();
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
                color: selected ? kPrimaryColor : Colors.grey[400],
                fontSize: 16,
                fontWeight: FontWeight.bold),
          ),
          selected
              ? Column(
                  children: [
                    const SizedBox(
                      height: 12,
                    ),
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: kPrimaryColor,
                        shape: BoxShape.circle,
                      ),
                    )
                  ],
                )
              : Container()
        ],
      ),
    );
  }
}
