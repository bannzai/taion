import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/provider/auth.dart';

import '../entity/user.codegen.dart';

DocumentReference<User> userDocumentReference({required String userID}) {
  return FirebaseFirestore.instance.doc("/users/$userID").withConverter(
        fromFirestore: (snapshot, _) =>
            User.fromJson(snapshot.data()!)..copyWith(id: snapshot.id),
        toFirestore: (User value, _) {
          return value.toJson();
        },
      );
}

final userProvider = StreamProvider<User?>((ref) {
  final firebaseCurrentUser = ref.watch(firebaseCurrentUserProvider);
  if (firebaseCurrentUser is AsyncLoading) {
    return const Stream.empty();
  }

  final firebaseCurrentUserValue = firebaseCurrentUser.asData?.value;
  if (firebaseCurrentUserValue == null) {
    return Stream.value(null);
  }

  debugPrint("userID: ${firebaseCurrentUserValue.uid}");
  return userDocumentReference(userID: firebaseCurrentUserValue.uid)
      .snapshots()
      .map((event) => event.data());
});

final mustUserIDProvider =
    Provider<String>((ref) => ref.watch(userProvider).value!.id!);

class SetUser {
  Future<void> call(User user) async {
    await userDocumentReference(userID: user.id!)
        .set(user, SetOptions(merge: true));
  }
}

final setUserProvider = Provider((ref) => SetUser());
