import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import '../../../core/model/posts_model.dart';
import '../../../core/string/app_color.dart';
import '../../../core/widgets/button_widget.dart';
import '../../../core/widgets/text_field_widget.dart';
import '../provider/posts_data_provider.dart';
import '../widgets/item_of_post.dart';

class HomePostsScreen extends StatefulWidget {
  final String uid;

  const HomePostsScreen({super.key, required this.uid});

  @override
  State<StatefulWidget> createState() {
    return _HomePostsScreen();
  }
}

class _HomePostsScreen extends State<HomePostsScreen> {
  TextEditingController controller = TextEditingController();
  late VideoPlayerController _videoPlayerController;

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PostsDataProvider>(context, listen: false)
          .getPostsDataProvider();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.lightGreyColor,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        centerTitle: true,
        title: const Text('Feed'),
      ),
      body: Column(
        children: [
          Expanded(
            child: Container(
              color: Colors.white,
              child: Column(
                children: [
                  Consumer<PostsDataProvider>(
                      builder: (context, cartImage, child) {
                    return Column(children: [
                      cartImage.imageState != null
                          ? Stack(
                              children: [
                                AspectRatio(
                                    aspectRatio: _videoPlayerController.value.aspectRatio,
                                    child: VideoPlayer(_videoPlayerController),
                                  ),
                                Positioned(
                                    right: 0,
                                    top: 0,
                                    child: GestureDetector(
                                        onTap: () {
                                          cartImage.clearImageState();
                                        },
                                        child: const Icon(Icons.close)))
                              ],
                            )
                          : const SizedBox(),
                      Container(
                        color: Colors.white,
                        margin: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Add new post',
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.grey.shade400),
                            ),
                            TextFieldWidget(
                              keyboardType: TextInputType.text,
                              hintText: 'Write here..',
                              height: 100,
                              borderRadius: 8,
                              controler: controller,
                              rightWidget: Container(
                                height: 70,
                                alignment: Alignment.topCenter,
                                width: 30,
                                child: IconButton(
                                    onPressed: () async {
                                      final ImagePicker picker = ImagePicker();
                                      XFile? image = await picker.pickVideo(
                                        source: ImageSource.gallery,
                                      );
                                      cartImage.changeImageState(image!.path);
                                      _videoPlayerController = VideoPlayerController.file(File(cartImage.imageState??''))..initialize().then((_) {
                                        setState(() { });
                                        _videoPlayerController.play();
                                      });
                                    },
                                    icon: const Icon(
                                      Icons.video_collection_rounded,
                                      color: Colors.grey,
                                    )),
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 15),
                              borderColor: Colors.black45,
                              maxLines: 5,
                            ),
                            Consumer<PostsDataProvider>(
                                builder: (context, cart, child) {
                              return cart.stateOfLoadingAddPosts != null
                                  ? ButtonWidget(
                                      textColor: Colors.white,
                                      boarderColor: Colors.transparent,
                                      text: 'Post',
                                      marginHeight: 5,
                                      marginWidth: 0,
                                      height: 50,
                                      action: () {
                                        cart.addNewPostsProvider(
                                            uid: widget.uid,
                                            body: controller.text,
                                            image:
                                                Provider.of<PostsDataProvider>(
                                                        context,
                                                        listen: false)
                                                    .imageState,);
                                        controller.clear();
                                      },
                                      backgroundColor: AppColor.mainColor,
                                    )
                                  : const Center(
                                      child: CircularProgressIndicator(
                                      color: AppColor.mainColor,
                                    ));
                            }),
                          ],
                        ),
                      ),
                    ]);
                  }),
                  const SizedBox(
                    height: 20,
                  ),
                  Expanded(
                    child: Consumer<PostsDataProvider>(
                        builder: (context, cart, child) {
                      return StreamBuilder<QuerySnapshot>(
                          stream: cart.stateOfGetPostsData,
                          builder: (BuildContext context,
                              AsyncSnapshot<QuerySnapshot> snapshot) {
                            if (snapshot.hasError) {
                              return const Text('Something went wrong');
                            } else if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return const Center(
                                  child: CircularProgressIndicator(
                                color: AppColor.mainColor,
                              ));
                            } else if (snapshot.hasData == true) {
                              return ListView.builder(
                                  itemCount: snapshot.data!.docs.length,
                                  itemBuilder: (context, index) {
                                    Map<String, dynamic> data =
                                        snapshot.data!.docs[index].data()!
                                            as Map<String, dynamic>;
                                    PostsModel dataMessages =
                                        PostsModel.fromJson(data);
                                    return ItemOfPost(
                                        id: snapshot.data!.docs[index].id,

                                        showSpace: true,
                                      countOfComments:dataMessages.comment==null?0.toString():dataMessages.comment!.length.toString(),
                                      name: dataMessages.userName.toString(),
                                        body: dataMessages.postBody,
                                        image: dataMessages.postImage,
                                        liked: dataMessages.liked??[], uid: widget.uid,
                                    );
                                  }
                                  // children: snapshot.data!.docs
                                  //         .map((DocumentSnapshot document) {
                                  //   Map<String, dynamic> data = document.data()!
                                  //       as Map<String, dynamic>;
                                  //   PostsModel dataMessages =
                                  //       PostsModel.fromJson(data);
                                  //   print('dataMessages:$dataMessages');
                                  //   // return Container();
                                  // }).toList());
                                  );
                            } else {
                              return Container();
                            }
                          });
                    }),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
