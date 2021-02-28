import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:team_at/model/user_model.dart';

class FireStoreUser {
  final CollectionReference userCollectionRef =
      FirebaseFirestore.instance.collection("Users");

  Future<void> addUserToFireStore(UserModel userModel) async {
    await userCollectionRef.doc(userModel.userID).set(userModel.toJson());
  }
}
