import 'package:flutter/material.dart';

import 'package:fb_clone/widgets/profile_avatar.dart';
import 'package:fb_clone/models/user_model.dart';

class Rooms extends StatelessWidget {
  final List<User> onlineUsers;

  const Rooms({Key? key, required this.onlineUsers}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      color: Colors.white,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + onlineUsers.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  child: _CreateRoomButton());
            }
            final User user = onlineUsers[index - 1];
            return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: ProfileAvatar(imageUrl: user.imageUrl, isActive: true));
          }),
    );
  }
}

class _CreateRoomButton extends StatelessWidget {
  const _CreateRoomButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          side: BorderSide(width: 1.0, color: Colors.blueAccent)),
      child: Row(
        children: [
          // ShaderMask(
          //     shaderCallback: (rect) =>
          //         Palette.createRoomGradient.createShader(rect),
          //     child: Icon(Icons.video_call, color: Colors.white, size: 35.0)),
          Icon(Icons.video_call, color: Colors.purple, size: 35.0),
          const SizedBox(
            width: 4.0,
          ),
          Text('Create\nRoom')
        ],
      ),
    );
  }
}
