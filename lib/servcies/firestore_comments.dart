import 'package:cloud_firestore/cloud_firestore.dart';


class FireStoreComments {
  final CollectionReference commentCollectionRef =
  FirebaseFirestore.instance.collection("Comments");

}
