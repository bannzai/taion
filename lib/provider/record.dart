import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';

import '../entity/record.codegen.dart';

String _collectionPathBuilder({required String userID}) {
  return "/users/$userID/records";
}

FromFirestore<Record> _fromFirestore() => (snapshot, _) =>
    Record.fromJson(snapshot.data()!)..copyWith(id: snapshot.id);
ToFirestore<Record> _toFirestore() => (value, _) => value.toJson();

CollectionReference<Record> recordCollectionReference(
        {required String userID}) =>
    FirebaseFirestore.instance
        .collection(_collectionPathBuilder(userID: userID))
        .withConverter(
          fromFirestore: _fromFirestore(),
          toFirestore: _toFirestore(),
        );

final recordsProvider = StreamProvider((ref) =>
    recordCollectionReference(userID: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("createdDateTime", descending: true)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList()));

class SetRecord {
  Future<void> call(
    Record record, {
    required String userID,
  }) async {
    await recordCollectionReference(userID: userID)
        .doc(record.id)
        .set(record, SetOptions(merge: true));
  }
}

final setRecordProvider = Provider((ref) => SetRecord());
