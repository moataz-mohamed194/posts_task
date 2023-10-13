import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../model/social_media_model.dart';
import '../model/user_model.dart';

class PatientsData {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }

  getDoctorDataRequest({required String uid}) async {
    try {
      print('getDoctorDataRequest');
      final data = FirebaseFirestore.instance.collection('admin').doc(uid);
      DocumentSnapshot docSnapshot = await data.get();
      UserModel finalData =
      UserModel.fromJson(docSnapshot.data() as Map<String, dynamic>);
      finalData.articles = [];
      finalData.videos = [];
      finalData.pictures = [];

      QuerySnapshot subCollectionSnapshot1 =
      await data.collection('article').get();
      List<QueryDocumentSnapshot> subCollectionDocs1 = subCollectionSnapshot1.docs;
      for (QueryDocumentSnapshot subDocument in subCollectionDocs1) {
        SocialMediaModel finalSocialMediaData =
        SocialMediaModel.fromJson(subDocument.data() as Map<String, dynamic>);
        finalData.articles!.add(finalSocialMediaData);
      }


      QuerySnapshot subCollectionSnapshot2 =
      await data.collection('pictures').get();
      List<QueryDocumentSnapshot> subCollectionDocs2 = subCollectionSnapshot2.docs;
      for (QueryDocumentSnapshot subDocument in subCollectionDocs2) {
        SocialMediaModel finalSocialMediaData =
        SocialMediaModel.fromJson(subDocument.data() as Map<String, dynamic>);
        finalData.pictures!.add(finalSocialMediaData);
      }

      QuerySnapshot subCollectionSnapshot3 =
      await data.collection('videos').get();
      List<QueryDocumentSnapshot> subCollectionDocs3 = subCollectionSnapshot3.docs;
      for (QueryDocumentSnapshot subDocument in subCollectionDocs3) {
        SocialMediaModel finalSocialMediaData =
        SocialMediaModel.fromJson(subDocument.data() as Map<String, dynamic>);
        finalData.videos!.add(finalSocialMediaData);
      }
      print('finalData:$finalData');
      return finalData;
    } catch (e) {
      print('error:$e');
      return e.toString();
    }
  }
  getUserNotInGroup() async {
    final users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (data, _) => data.toJson(),
    );
    List<QueryDocumentSnapshot<UserModel>> data = await users
        .where('group', isNull: true)
        .get()
        .then((snapshot) => snapshot.docs);
    print('data22:${data}');

    return data;
  }

  getUsersUnActivateRequest() async {
    final users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (data, _) => data.toJson(),
    );
    List<QueryDocumentSnapshot<UserModel>> data = await users
        .where('Unactivate', isEqualTo: true)
        .get()
        .then((snapshot) => snapshot.docs);
    print('data22:${data}');

    return data;
  }


  getUsersFreezeRequest() async {
    final users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (data, _) => data.toJson(),
    );
    List<QueryDocumentSnapshot<UserModel>> data = await users
        .where('freez', isEqualTo: true)
        .get()
        .then((snapshot) => snapshot.docs);
    print('data22:${data}');

    return data;
  }
  getUserInGroup() async {
    final users = FirebaseFirestore.instance
        .collection('users')
        .withConverter<UserModel>(
      fromFirestore: (snapshot, _) => UserModel.fromJson(snapshot.data()!),
      toFirestore: (data, _) => data.toJson(),
    );
    List<QueryDocumentSnapshot<UserModel>> data = await users
        .where('group', isNull: false)
        .get()
        .then((snapshot) => snapshot.docs);
    print('data:${data}');

    return data;
  }

  addMemberToGroup({required String id, required String groupId}) async {
    try {
      final users = FirebaseFirestore.instance.collection('users').doc(id);

      await users
          .update({
            'group': groupId,
          })
          .catchError((error) {
        print('error:$error');

        return error;
          });
      final group = FirebaseFirestore.instance.collection('group').doc(groupId);

      await group
          .update({
            'count': FieldValue.increment(1),
          })
          .catchError((e) {
            print('error:$e');
            return e;
          });
      return users.id;
    } catch (e) {
      print('error:$e');
      return e.toString();
    }
  }
}
