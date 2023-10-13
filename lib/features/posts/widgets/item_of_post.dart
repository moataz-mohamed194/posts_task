import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import '../../../core/string/app_color.dart';
import '../../../core/string/app_images.dart';
import '../provider/posts_data_provider.dart';
import '../screens/post_with_comment_screen.dart';

Route _createRoute({required String id, required String uid}) {
  return PageRouteBuilder(
    pageBuilder: (context, animation, secondaryAnimation) =>
        PostWithCommentScreen(idPost: id, uid: uid),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}

class ItemOfPost extends StatefulWidget {
  final String countOfComments;
  final String? body;
  final String? image;
  final List<String> liked;
  final String uid;
  final String id;
  final String name;
  final bool showSpace;
  const ItemOfPost(
      {super.key, required this.countOfComments,
      required this.liked,
      required this.uid,
      required this.id,
      required this.showSpace,
      required this.name,
      this.body,
      this.image});

  @override
  State<StatefulWidget> createState() {
    return _ItemOfPost();
  }
}

class _ItemOfPost extends State<ItemOfPost> {
  late VideoPlayerController _videoPlayerController;
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    if (widget.image != null && widget.image != '' && widget.image != 'null') {
      _videoPlayerController =
          VideoPlayerController.networkUrl(Uri.parse(widget.image.toString()))
            ..initialize().then((_) {});
    }
    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        _isVisible = false;
      });
    });
  }

  bool playing = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context)
                .push(_createRoute(id: widget.id, uid: widget.uid));
          },
          child: Container(
            color: Colors.white,
            // margin: const EdgeInsets.only(bottom: 10),
            // padding: EdgeInsets.only(top: 14),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 23),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 18,
                                child: Image.asset(
                                  AppImages.imagePersonProfile,
                                  fit: BoxFit.fitHeight,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                widget.name,
                                style: const TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.w500),
                              )
                            ],
                          ),
                          InkWell(
                            onTap: () {},
                            child: const Icon(CupertinoIcons.ellipsis_vertical),
                          )
                        ],
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      widget.body != null
                          ? Text(
                              widget.body.toString(),
                              // 'Reference site about Lorem , giving safas information on itsgenerator.',
                              style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: Colors.grey),
                            )
                          : const SizedBox(),
                      widget.body != null
                          ? const SizedBox(
                              height: 6,
                            )
                          : const SizedBox(),
                    ],
                  ),
                ),
                widget.image != null &&
                        widget.image != '' &&
                        widget.image != 'null'
                    ? GestureDetector(
                        onTap: () {
                          if (_videoPlayerController.value.isPlaying) {
                            _videoPlayerController.pause();
                            setState(() {
                              playing = false;
                            });
                          } else {
                            _videoPlayerController.play();
                            setState(() {
                              playing = true;
                            });
                          }
                        },
                        child: Stack(
                          alignment: AlignmentDirectional.center,
                          children: [
                            SizedBox(
                              // radius: 18,
                              height: 300,
                              width: MediaQuery.of(context).size.width,
                              child: VideoPlayer(
                                _videoPlayerController,
                              ),
                            ),
                            playing
                                ? _isVisible
                                    ? const CircleAvatar(
                                        backgroundColor: Colors.white,
                                        child: Icon(
                                          Icons.pause,
                                          color: Colors.black,
                                        ),
                                      )
                                    : const SizedBox()
                                : const CircleAvatar(
                                    backgroundColor: Colors.white,
                                    child: Icon(
                                      Icons.play_arrow,
                                      color: Colors.black,
                                    ),
                                  )
                          ],
                        ),
                      )
                    : const SizedBox(),
                Container(
                  margin:
                      const EdgeInsets.symmetric(horizontal: 23, vertical: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              GestureDetector(
                                onTap: () {
                                  if (widget.liked.contains(widget.uid) ==
                                      true) {
                                    Provider.of<PostsDataProvider>(context,
                                            listen: false)
                                        .removeLikedProvider(
                                            uid: widget.uid, idPost: widget.id);
                                  } else {
                                    Provider.of<PostsDataProvider>(context,
                                            listen: false)
                                        .addLikedProvider(
                                            uid: widget.uid, idPost: widget.id);
                                  }
                                },
                                // child:liked.contains(uid)==true?
                                child: Image.asset(
                                  AppImages.iconLike,
                                  color:
                                      widget.liked.contains(widget.uid) == true
                                          ? Colors.redAccent
                                          : Colors.grey,
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Text(
                                widget.liked.length.toString(),
                                style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: AppColor.blueBlackColor),
                              )
                            ],
                          ),
                          const SizedBox(
                            width: 45,
                          ),
                          GestureDetector(
                              onTap: () {
                                if (widget.showSpace == true) {
                                  Navigator.of(context).push(_createRoute(
                                      id: widget.id, uid: widget.uid));
                                }
                              },
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Image.asset(AppImages.iconComment),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    widget.countOfComments,
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColor.blueBlackColor),
                                  )
                                ],
                              )),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
        widget.showSpace == true
            ? Container(
                height: 10,
                color: AppColor.lightGreyColor.withOpacity(.2),
              )
            : const SizedBox()
      ],
    );
  }
}
// itemOfPost({required context,required String countOfComments,required List<String> liked, required String uid, required String id, required bool showSpace, required String name, String? body, String? image}) {

// }
