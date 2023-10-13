import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserAuth {

  Future<User?> checkUserData({required String emailAddress}) async {
    User? user = FirebaseAuth.instance.currentUser;
    return user;

  }

  Future<String?> loginRequest(
      {required String emailAddress, required String password}) async {
    try {
      final credential =await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      DocumentReference docRef = FirebaseFirestore.instance.collection('admin').doc(credential.user!.uid);

      // Fetch the document
      DocumentSnapshot docSnapshot = await docRef.get();
      if (!docSnapshot.exists) {

               return 'check your data';
      }else{
        return 'success';

      }

    } on FirebaseAuthException catch (e) {

      print('error:$e');
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message.toString();
    } catch (e) {
      print('error:${e}');
      return e.toString();
    }
  }


  Future<String?> createAccountRequest(
      {required String emailAddress,
        required String password,
        required String userName,
        required String phoneNumber}) async {
    try {
      final credential =
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      final users = FirebaseFirestore.instance
          .collection('admin')
          .doc(credential.user!.uid.toString());
      await users
          .set({
        'email': emailAddress,
        'user_name': userName,
        'phone': phoneNumber,
        'years_of_experience':null,
        'count_of_people':null
      });
      User? user = FirebaseAuth.instance.currentUser;

      await user!.sendEmailVerification();

      return 'success';
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message.toString();
    } catch (e) {
      return e.toString();
    }
  }
}
