import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_clone/config/palette.dart';
import 'package:fb_clone/widgets/widget.dart';
import 'package:flutter/material.dart';

import 'package:fb_clone/models/post_model.dart';

class PostContainer extends StatelessWidget {
  final Post post;
  const PostContainer({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.symmetric(vertical: 5.0),
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        color: Colors.white,
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12.0),
            child: _PostHeader(
              post: post,
            ),
          ),
          const SizedBox(
            height: 4.0,
          ),
          _PostContent(post: post),
          Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 10.0, 12.0, 5.0),
            child: _PostStats(post: post),
          )
        ]));
  }
}

class _PostStats extends StatelessWidget {
  final Post post;
  const _PostStats({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Container(
              padding: const EdgeInsets.all(4.0),
              decoration: BoxDecoration(
                  color: Palette.facebookBlue, shape: BoxShape.circle),
              child: Icon(
                Icons.thumb_up,
                size: 10.0,
                color: Colors.white,
              ),
            ),
            const SizedBox(
              width: 4.0,
            ),
            Expanded(child: Text('${post.likes}')),
            Text('${post.comments} comments'),
            const SizedBox(
              width: 4.0,
            ),
            Text('${post.shares} share')
          ],
        ),
        const Divider(
          color: Colors.red,
        ),
        Row(
          children: [],
        )
      ],
    );
  }
}

class _PostButton extends StatelessWidget {
  final Icon icon;
  final String label;
  final Function onTap;

  const _PostButton(
      {Key key,
      @required this.icon,
      @required this.label,
      @required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        child: Row(
          children: [
            icon,
            const SizedBox(
              width: 4.0,
            ),
            Text(label)
          ],
        ),
      ),
    );
  }
}

class _PostContent extends StatelessWidget {
  final Post post;

  const _PostContent({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12.0),
          child: Text(post.caption),
        ),
        const SizedBox(
          height: 8.0,
        ),
        post.imageUrl != null
            ? CachedNetworkImage(imageUrl: post.imageUrl)
            : const SizedBox.shrink()
      ],
    );
  }
}

class _PostHeader extends StatelessWidget {
  final Post post;
  const _PostHeader({Key key, @required this.post}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        ProfileAvatar(imageUrl: post.user.imageUrl),
        const SizedBox(
          width: 8.0,
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                post.user.name,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Row(
                children: [
                  Text(
                    '${post.timeAgo} •',
                    style: TextStyle(fontSize: 12.0, color: Colors.grey[600]),
                  ),
                  Icon(
                    Icons.public,
                    size: 12.0,
                    color: Colors.grey[600],
                  ),
                ],
              )
            ],
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.more_horiz,
            color: Colors.grey[700],
          ),
          onPressed: () {},
        )
      ],
    );
  }
}
