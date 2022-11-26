import 'package:async_value_group/async_value_group.dart';
import 'package:collection/collection.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod/riverpod.dart';
import 'package:taion/provider/shared_preferences.dart';

import '../entity/actor.codegen.dart';

String _collectionPathBuilder({required String userID}) {
  return "/users/$userID/actors";
}

FromFirestore<Actor> _fromFirestore() =>
    (snapshot, _) => Actor.fromJson(snapshot.data()!).copyWith(id: snapshot.id);
ToFirestore<Actor> _toFirestore() => (value, _) => value.toJson();

CollectionReference<Actor> actorCollectionReference({required String userID}) =>
    FirebaseFirestore.instance
        .collection(_collectionPathBuilder(userID: userID))
        .withConverter(
          fromFirestore: _fromFirestore(),
          toFirestore: _toFirestore(),
        );

final actorsProvider = StreamProvider((ref) =>
    actorCollectionReference(userID: FirebaseAuth.instance.currentUser!.uid)
        .orderBy("index", descending: false)
        .snapshots()
        .map((event) => event.docs.map((e) => e.data()).toList()));

final currentActorProvider = Provider<AsyncValue<Actor?>>((ref) {
  return AsyncValueGroup.group2(
    ref.watch(actorsProvider),
    ref.watch(stringSharedPreferencesProvider(StringKey.latestUsedActorID)),
  ).whenData((data) {
    final actors = data.t1;
    final latestUsedActorID = data.t2;
    if (actors.isEmpty) {
      return null;
    }
    if (latestUsedActorID == null) {
      return actors.last;
    }
    final latestUsedActor =
        actors.firstWhereOrNull((element) => element.id == latestUsedActorID);
    if (latestUsedActor == null) {
      return actors.last;
    } else {
      return latestUsedActor;
    }
  });
});

final mustCurrentActorProvider =
    Provider<Actor>((ref) => ref.watch(currentActorProvider).valueOrNull!);

class SetActor {
  Future<void> call(
    Actor actor, {
    required String userID,
  }) async {
    await actorCollectionReference(userID: userID)
        .doc(actor.id)
        .set(actor, SetOptions(merge: true));
  }
}

final setActorProvider = Provider((ref) => SetActor());

class DeleteActor {
  Future<void> call(
    Actor actor, {
    required String userID,
  }) async {
    await actorCollectionReference(userID: userID).doc(actor.id).delete();
  }
}

final deleteActorProvider = Provider((ref) => DeleteActor());
