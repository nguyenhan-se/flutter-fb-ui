import 'package:fb_clone/config/palette.dart';
import 'package:flutter/material.dart';

class CustomTabBar extends StatelessWidget {
  final int selectedIndex;
  final List<IconData> icons;
  final Function(int) onTap;
  final bool isBottomIndicator;

  const CustomTabBar(
      {Key? key,
      required this.icons,
      required this.onTap,
      this.selectedIndex = 0,
      this.isBottomIndicator = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TabBar(
      indicatorPadding: EdgeInsets.zero,
      indicator: BoxDecoration(
          border: isBottomIndicator
              ? Border(
                  bottom: BorderSide(color: Palette.facebookBlue, width: 3.0))
              : Border(
                  top: BorderSide(color: Palette.facebookBlue, width: 3.0))),
      tabs: icons
          .asMap()
          .map((i, icon) => MapEntry(
                i,
                Tab(
                  icon: Icon(
                    icon,
                    color: i == selectedIndex
                        ? Palette.facebookBlue
                        : Colors.black54,
                  ),
                ),
              ))
          .values
          .toList(),
      onTap: onTap,
    );
  }
}
