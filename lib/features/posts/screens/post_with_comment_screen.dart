import 'package:flutter/material.dart';
import '../../../core/provider/get_un_user_data_provider.dart';
import '../../../core/string/app_color.dart';
import '../../../core/string/app_images.dart';
import '../provider/posts_data_provider.dart';
import '../widgets/item_of_add_comment.dart';
import '../widgets/item_of_comment.dart';
import '../widgets/item_of_post.dart';

class PostWithCommentScreen extends StatefulWidget {
  final String idPost;
  final String uid;

  const PostWithCommentScreen({super.key, required this.idPost, required this.uid});

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PostWithCommentScreen();
  }
}
class _PostWithCommentScreen extends State<PostWithCommentScreen>{
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      Provider.of<PostsDataProvider>(context, listen: false)
          .getOnePostDataProvider(idPost: widget.idPost);
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Consumer<PostsDataProvider>(
        builder: (context, cart, child) {
      return cart.stateOfLoadingGetCurrentOnePostData!=null?  Column(
          children: [
            Container(
              color: Colors.white,
              padding: const EdgeInsets.only(left: 10, right: 30, top: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.arrow_back)),
                  GestureDetector(
                    onTap: () {

                    },
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 10),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 5),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(58.0),
                          color: AppColor.textFieldColor),
                      child: const Text('Group A25'),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
                child: ListView(
              children: [
                ItemOfPost(
                    showSpace: false,
                    liked:cart.currentOnePostData!.data()!.liked??[],
                    uid: '',
                    countOfComments:cart.currentOnePostData!.data()!.comment==null?0.toString():cart.currentOnePostData!.data()!.comment!.length.toString(),
                    body: cart.currentOnePostData!.data()!.postBody.toString(),
                    image: cart.currentOnePostData!.data()!.postImage.toString(),
                    id: cart.currentOnePostData!.id.toString(),
                    name: cart.currentOnePostData!.data()!.userName.toString()),
                if (cart.currentOnePostData!.data()!.comment!=null)...{
                  ...List.generate(cart.currentOnePostData!.data()!.comment!
                      .length, (index) =>
                      itemOfComment(
                          context: context,
                          image: AppImages.imageBeforePerson,
                          title: cart.currentOnePostData!.data()!.comment![index].userName.toString(),
                          message: cart.currentOnePostData!.data()!.comment![index].value.toString()))
                }
                // itemOfComment(
                //     context: context,
                //     image: AppImages.imageBeforePerson,
                //     title: 'Ahmed Yassen',
                //     message: 'Good Job doctor.'),
                // itemOfComment(
                //     context: context,
                //     image: AppImages.imagePost,
                //     title: 'Ahmed Yassen',
                //     message:
                //         'Good Job doctor.Good Job doctor.Good Job doctor.Good Job doctor.'),
                // itemOfComment(
                //     context: context,
                //     image: AppImages.imageAfterPerson,
                //     title: 'Ahmed Yassen',
                //     message: 'Good Job doctor.')
              ],
            )

            ),
            itemOfAddComment(context: context, uid: widget.uid, postId: cart.currentOnePostData!.id, )
          ],
        ): const Center(
          child: CircularProgressIndicator(
            color: AppColor.mainColor,
          ));})
      ),
    );
  }
}
