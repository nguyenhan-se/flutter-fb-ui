import 'package:flutter/material.dart';

import 'package:fb_clone/config/palette.dart';
import 'package:fb_clone/models/user_model.dart';
import 'package:fb_clone/widgets/widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

class CustomAppBar extends StatelessWidget {
  final User currentUser;
  final List<IconData> icons;
  final int selectedIndex;
  final Function(int) onTap;

  const CustomAppBar(
      {Key? key,
      required this.currentUser,
      required this.icons,
      required this.onTap,
      this.selectedIndex = 0})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      height: 56.0,
      decoration: BoxDecoration(color: Colors.white, boxShadow: const [
        BoxShadow(color: Colors.black12, offset: Offset(0, 2), blurRadius: 4.0)
      ]),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
              child: Row(
            children: [
              InkWell(
                onTap: () {},
                child: Icon(
                  MdiIcons.facebook,
                  color: Palette.facebookBlue,
                  size: 42.0,
                ),
              ),
              const SizedBox(width: 4.0),
              Container(
                width: 250.0,
                height: 40.0,
                decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(20.0)),
                child: Padding(
                  padding: const EdgeInsets.only(left: 5.0),
                  child: TextField(
                    style: TextStyle(
                      color: Colors.grey[700],
                    ),
                    cursorColor: Colors.black38,
                    cursorWidth: 1.0,
                    decoration: InputDecoration(
                        hintText: 'Search Facebook',
                        border: InputBorder.none,
                        prefixIcon: Icon(MdiIcons.searchWeb)),
                  ),
                ),
              )
            ],
          )),
          Container(
            height: double.infinity,
            width: 600.0,
            child: CustomTabBar(
              icons: icons,
              onTap: onTap,
              selectedIndex: selectedIndex,
              isBottomIndicator: true,
            ),
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                UserCard(
                  user: currentUser,
                ),
                const SizedBox(
                  width: 12.0,
                ),
                CircleButton(
                  icon: MdiIcons.plus,
                  iconSize: 24.0,
                  onPressed: () {},
                ),
                CircleButton(
                  icon: MdiIcons.facebookMessenger,
                  iconSize: 18.0,
                  onPressed: () {},
                ),
                CircleButton(
                  icon: MdiIcons.bell,
                  iconSize: 18.0,
                  onPressed: () {},
                ),
                CircleButton(
                  icon: MdiIcons.menuDown,
                  iconSize: 30.0,
                  onPressed: () {},
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
