import 'package:cached_network_image/cached_network_image.dart';
import 'package:fb_clone/data/data.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:fb_clone/config/palette.dart';
import 'package:fb_clone/models/story_model.dart';
import 'package:fb_clone/models/user_model.dart';
import 'package:fb_clone/widgets/widget.dart';

const double maxWidth = 110.0;
const double maxHeight = 200.0;
const double minWidth = 55.0;
const double minHeight = 50.0;
const double borderRadius = 12.0;
const double _kAnimationMaxScrollExtentFactor = 0.2;
const double _kImageHeightFactor = 0.65;
const double _kIconSizeFactor = 0.45;
const double _kTextSpeed = 3;
const double _iconAddSize = 24.0;
const double _borderOutlineAddBtn = 4.0;
const double _paddingVerticalStories = 10.0;

class StoriesAnimation extends StatefulWidget {
  final User? currentUser;
  final List<Story> stories;

  StoriesAnimation({Key? key, this.currentUser, required this.stories})
      : super(key: key);

  @override
  _StoriesAnimationState createState() => _StoriesAnimationState();
}

class _StoriesAnimationState extends State<StoriesAnimation> {
  final ScrollController _scrollController = ScrollController();
  double _animationValue = 0.0;
  late SizeTween _addItemSizeTween;
  late BorderRadiusTween _addItemBorderRadiusTween;
  late EdgeInsetsTween _addItemPaddingTween;
  late SizeTween _addImageSizeTween;
  late AlignmentTween _addImageAlignmentTween;
  late BorderRadiusTween _addImageBorderRadiusTween;
  late EdgeInsetsTween _addIconMarginTween;
  late SizeTween _addIconAddSizeTween;
  late AlignmentTween _addIconAlimentTween;
  late BorderTween _addIconBorderSizeTween;

  void onListen() {
    double offset = _scrollController.offset;
    double _addItemAnimationMaxOffset =
        _scrollController.position.maxScrollExtent *
            _kAnimationMaxScrollExtentFactor;

    _animationValue =
        math.min(1, math.max(0, offset / _addItemAnimationMaxOffset));

    setState(() {});
  }

  @override
  void initState() {
    _scrollController.addListener(onListen);

    _addItemSizeTween = SizeTween(
        begin: Size(maxWidth, maxHeight), end: Size(minWidth, minHeight));
    _addItemBorderRadiusTween = BorderRadiusTween(
      begin: BorderRadius.circular(borderRadius),
      end: BorderRadius.only(
        topLeft: Radius.zero,
        bottomLeft: Radius.zero,
        topRight: Radius.circular(minHeight),
        bottomRight: Radius.circular(minHeight),
      ),
    );
    _addItemPaddingTween = EdgeInsetsTween(
      begin: EdgeInsets.symmetric(
        horizontal: 8.0,
      ),
      end: EdgeInsets.zero,
    );
    _addImageSizeTween = SizeTween(
        begin: Size(maxWidth, maxHeight * _kImageHeightFactor),
        end: Size(minHeight * 0.7, minHeight * 0.7));
    _addImageAlignmentTween =
        AlignmentTween(begin: Alignment.topCenter, end: Alignment.center);
    _addImageBorderRadiusTween = BorderRadiusTween(
      begin: BorderRadius.only(
          topLeft: Radius.circular(borderRadius),
          topRight: Radius.circular(borderRadius)),
      end: BorderRadius.circular(50.0),
    );

    _addIconAddSizeTween = SizeTween(
      begin: Size(_iconAddSize, _iconAddSize),
      end: Size(
          _iconAddSize * _kIconSizeFactor, _iconAddSize * _kIconSizeFactor),
    );
    _addIconMarginTween = EdgeInsetsTween(
        begin: EdgeInsets.only(
          bottom: math.max(
            0,
            maxHeight -
                _addImageSizeTween.begin!.height -
                _iconAddSize / 2 -
                _paddingVerticalStories * 2 -
                _borderOutlineAddBtn,
          ),
        ),
        end: EdgeInsets.only(bottom: 5.0, right: 5.0));
    _addIconAlimentTween = AlignmentTween(
        begin: Alignment.bottomCenter, end: Alignment.bottomRight);
    _addIconBorderSizeTween = BorderTween(
      begin: Border.all(width: _borderOutlineAddBtn, color: Colors.white),
      end: Border.all(width: _borderOutlineAddBtn / 2, color: Colors.white),
    );

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.removeListener(onListen);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: maxHeight,
      color: Colors.grey[50],
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: _paddingVerticalStories),
        child: Stack(
          alignment: Alignment.centerLeft,
          children: [
            ListView.builder(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              itemCount: 1 + widget.stories.length,
              itemBuilder: (context, index) => index == 0
                  ? Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: Container(
                        width: maxWidth,
                        height: double.infinity,
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8.0),
                      child: _StoryCard(
                        story: widget.stories[index - 1],
                      ),
                    ),
            ),
            Padding(
              padding: _addItemPaddingTween.transform(_animationValue),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius:
                      _addItemBorderRadiusTween.transform(_animationValue),
                  border: Border.all(width: 1.0, color: Colors.black12),
                ),
                width: _addItemSizeTween.transform(_animationValue)!.width,
                height: _addItemSizeTween.transform(_animationValue)!.height,
                child: Stack(
                  children: [
                    Align(
                      alignment:
                          _addImageAlignmentTween.transform(_animationValue),
                      child: SizedBox(
                        height: _addImageSizeTween
                            .transform(_animationValue)!
                            .height,
                        width: _addImageSizeTween
                            .transform(_animationValue)!
                            .width,
                        child: ClipRRect(
                          borderRadius: _addImageBorderRadiusTween
                              .transform(_animationValue),
                          child: CachedNetworkImage(
                            imageUrl: currentUser.imageUrl,
                            height: double.infinity,
                            width: 110.0,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        padding: EdgeInsets.all(5.0),
                        child: Opacity(
                          opacity:
                              math.max(0, 1 - _animationValue * _kTextSpeed),
                          child: Text(
                            'Create\nStory',
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Align(
                      alignment:
                          _addIconAlimentTween.transform(_animationValue),
                      child: Container(
                        margin: _addIconMarginTween.transform(_animationValue),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.blue,
                            shape: BoxShape.circle,
                            border: _addIconBorderSizeTween
                                .transform(_animationValue),
                          ),
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                            size: _addIconAddSizeTween
                                .transform(_animationValue)!
                                .width,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final Story story;

  const _StoryCard({Key? key, required this.story}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          border: Border.all(width: 1.0, color: Colors.black12),
          borderRadius: BorderRadius.circular(borderRadius)),
      child: Stack(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(12.0),
            child: CachedNetworkImage(
              imageUrl: story.imageUrl,
              height: double.infinity,
              width: 110.0,
              fit: BoxFit.cover,
            ),
          ),
          Container(
            height: double.infinity,
            width: 110.0,
            decoration: BoxDecoration(
                gradient: Palette.storyGradient,
                borderRadius: BorderRadius.circular(12.0)),
          ),
          Positioned(
              top: 8.0,
              left: 8.0,
              child: ProfileAvatar(
                imageUrl: story.user.imageUrl,
                hasBorder: !story.isViewed,
              )),
          Positioned(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: Text(
              story.user.name,
              style: const TextStyle(
                  color: Colors.white, fontWeight: FontWeight.bold),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );
  }
}
