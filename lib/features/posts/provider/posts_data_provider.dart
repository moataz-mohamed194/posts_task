import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
export 'package:provider/provider.dart';

import '../../../core/model/posts_model.dart';
import '../data/posts_requests.dart';

class PostsDataProvider extends ChangeNotifier {
  String? imageState;

  changeImageState(String? newState) {
    imageState = newState;
    notifyListeners();
  }
  clearImageState() {
    imageState = null;
    body = null;
    notifyListeners();
  }
  String? body;
  changeBodyState(String? newState) {
    body = newState;
    notifyListeners();
  }
  String? errorMessageAddPosts = '';
  bool? stateOfLoadingAddPosts = false;
  addNewPostsProvider(
      {required String uid,
      String? body,
      String? image,
      int? timeToShare}) async {
    try {
      stateOfLoadingAddPosts = null;
      errorMessageAddPosts = null;
      notifyListeners();
      await PostsRequests().sendPostRequest(
          uid: uid, body: body, image: image, timeToShare: timeToShare);
      stateOfLoadingAddPosts = true;
      clearImageState();
      notifyListeners();
    } catch (e) {
      errorMessageAddPosts = e.toString();
      stateOfLoadingAddPosts = false;
      notifyListeners();
    }
  }

  Stream<QuerySnapshot>? stateOfGetPostsData;
  bool? stateOfLoadingGetPostsData;
  String? errorMessageGetGroup = '';
  getPostsDataProvider() async {
    try {
      stateOfGetPostsData = null;
      errorMessageGetGroup = null;
      stateOfLoadingGetPostsData = null;
      notifyListeners();

      stateOfGetPostsData = await PostsRequests().getPostsRequest();
      stateOfLoadingGetPostsData = true;
      notifyListeners();
    } catch (e) {
      print('error:$e');
      errorMessageGetGroup = e.toString();
      notifyListeners();
    }
    stateOfLoadingGetPostsData = false;
    notifyListeners();
  }

  addLikedProvider({required String uid, required String idPost}) async {
    print('addLikedProvider');
    await PostsRequests().addLikedRequest(uid: uid, idPost: idPost);
  }


  removeLikedProvider({required String uid, required String idPost}) async {
    print('removeLikedProvider');
    await PostsRequests().removeLikedRequest(uid: uid, idPost: idPost);
  }

  addCommentProvider(
      {required String uid,
      required String idPost,
      required String comment}) async {
    await PostsRequests()
        .addCommentRequest(uid: uid, idPost: idPost, comment: comment);
  }

  DocumentSnapshot<PostsModel>? currentOnePostData;
  bool? stateOfLoadingGetCurrentOnePostData;
  String? errorMessageGetCurrentOnePostData = '';

  getOnePostDataProvider({required String idPost}) async {
    try {
      currentOnePostData = null;
      stateOfLoadingGetCurrentOnePostData = null;
      errorMessageGetCurrentOnePostData = null;
      notifyListeners();

      currentOnePostData = await PostsRequests().getOnePost(idPost: idPost);
      stateOfLoadingGetCurrentOnePostData = true;
      notifyListeners();
    } catch (e) {
      print('error:$e');
      errorMessageGetCurrentOnePostData = e.toString();
      notifyListeners();
    }
    stateOfLoadingGetCurrentOnePostData = false;
    notifyListeners();
  }

  clear(){

  }
}
