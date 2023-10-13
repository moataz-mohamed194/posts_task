import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../core/model/comments_model.dart';
import '../../../core/model/posts_model.dart';
import '../../../core/model/user_model.dart';

class PostsRequests {
  sendPostRequest(
      {required String uid,
      String? body,
      String? image,
      int? timeToShare}) async {
    try {
      final users = FirebaseFirestore.instance
          .collection('admin')
          .doc(uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );
      DocumentSnapshot<UserModel> dataOfUser = await users.get();
      String? downloadImage;
      if (image != null) {
        Reference storageReference = FirebaseStorage.instance
            .ref()
            .child('posts/')
            .child(image.replaceAll("/", ""));
        await storageReference.putFile(File(image));
        downloadImage = await storageReference.getDownloadURL();
      }
      final posts = FirebaseFirestore.instance.collection('posts');

      final doc = await posts.add({
        'post_image': downloadImage,
        'post_body': body,
        'time_to_share': timeToShare.toString(),
        'uid': users.id,
        'user_name': dataOfUser.data()!.userName,
        'liked': []
      });

      return doc.id;
    } catch (e) {
      return e.toString();
    }
  }

  getPostsRequest() async {
    final group = FirebaseFirestore.instance.collection('posts').snapshots();
    return group;
  }

  addLikedRequest({required String uid, required String idPost}) async {
    print('addLikedRequest');
    try {
      final oldPostsData = FirebaseFirestore.instance
          .collection('posts')
          .doc(idPost)
          .withConverter<PostsModel>(
        fromFirestore: (snapshot, _) => PostsModel.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );
      DocumentSnapshot<PostsModel> currentPostData = await oldPostsData.get();
      final posts = FirebaseFirestore.instance.collection('posts').doc(idPost);
      List<String> newLikedList = [];
      newLikedList = currentPostData.data()!.liked ?? [];
      print(newLikedList.length);
      newLikedList.add(uid);
      print(newLikedList.length);
      await posts.update({'liked': newLikedList});
    }catch(e){
      print('error:$e');
    }
  }

  removeLikedRequest({required String uid, required String idPost}) async {
    try {
      final oldPostsData = FirebaseFirestore.instance
          .collection('posts')
          .doc(idPost)
          .withConverter<PostsModel>(
        fromFirestore: (snapshot, _) => PostsModel.fromJson(snapshot.data()!),
        toFirestore: (data, _) => data.toJson(),
      );
      DocumentSnapshot<PostsModel> currentPostData = await oldPostsData.get();
      final posts = FirebaseFirestore.instance.collection('posts').doc(idPost);
      List<String> newLikedList = [];
      newLikedList = currentPostData.data()!.liked ?? [];
      print(newLikedList.length);
      newLikedList.remove(uid);
      print(newLikedList.length);
      await posts.update({'liked': newLikedList});
    }catch(e){
      print('error:$e');
    }
  }

  addCommentRequest(
      {required String uid,
      required String idPost,
      required String comment}) async {
    try {
      final userData = FirebaseFirestore.instance
          .collection('admin')
          .doc(uid)
          .withConverter<UserModel>(
            fromFirestore: (snapshot, _) =>
                UserModel.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );
      DocumentSnapshot<UserModel> currentUserData = await userData.get();

      final oldPostsData = FirebaseFirestore.instance
          .collection('posts')
          .doc(idPost)
          .withConverter<PostsModel>(
            fromFirestore: (snapshot, _) =>
                PostsModel.fromJson(snapshot.data()!),
            toFirestore: (data, _) => data.toJson(),
          );
      DocumentSnapshot<PostsModel> currentPostData = await oldPostsData.get();
      List<CommentsModel> newCommentsList = [];
      newCommentsList = currentPostData.data()!.comment ?? [];
      CommentsModel newComment = CommentsModel(
          userId: uid,
          value: comment,
          userName: currentUserData.data()!.userName.toString());
      newCommentsList.add(newComment);
      List<Map<String, dynamic>> commentsMapList = newCommentsList
          .map((comment) => comment
              .toJson()) // Use toJson() to convert each CommentsModel to a Map
          .toList();

      await oldPostsData.update({'comment': commentsMapList});
    } catch (e) {
      print('error:$e');
    }
  }

  getOnePost({required String idPost}) async {
    final oldPostsData = FirebaseFirestore.instance
        .collection('posts')
        .doc(idPost)
        .withConverter<PostsModel>(
          fromFirestore: (snapshot, _) => PostsModel.fromJson(snapshot.data()!),
          toFirestore: (data, _) => data.toJson(),
        );
    // DocumentSnapshot<PostsModel> currentPostData =
    return await oldPostsData.get();
  }
}
