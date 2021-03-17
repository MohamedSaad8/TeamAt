import 'package:cloud_firestore/cloud_firestore.dart';


class FireStoreGroups {
  final CollectionReference groupCollectionRef =
  FirebaseFirestore.instance.collection("Groups");

}
