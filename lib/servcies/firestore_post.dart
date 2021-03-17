import 'package:cloud_firestore/cloud_firestore.dart';


class FireStorePosts {
  final CollectionReference postCollectionRef =
  FirebaseFirestore.instance.collection("Posts");

}
