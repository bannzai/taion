import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:taion/entity/user.codegen.dart';
import 'package:taion/provider/auth.dart';
import 'package:taion/provider/user.dart';

class Root extends HookConsumerWidget {
  const Root({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncUser = ref.watch(userStreamProvider);
    final user = asyncUser.asData?.value;
    final setUser = ref.watch(setUserProvider);
    final signIn = ref.watch(signInAnonymouslyProvider);

    if (asyncUser is AsyncLoading) {
      return CircularProgressIndicator();
    }

    useEffect(() {
      final f = () async {
        if (user == null) {
          await signIn();
          await setUser(User(id: null, createdDateTime: DateTime.now()));
          ref.refresh(firebaseCurrentUserProvider);
        } else {
          final userID = user.id;
          if (userID != null) {
            unawaited(FirebaseAnalytics.instance.setUserId(id: userID));
            unawaited(FirebaseCrashlytics.instance.setUserIdentifier(userID));
          }
        }
      };

      f();
      return null;
    }, [user]);

    return asyncUser.when(
      data: (user) {
        if (user != null) {
          return AppHome(user: user);
        } else {
          return CircularProgressIndicator();
        }
      },
      error: (error, st) => ErrorPage(
        error: error,
        reload: () => ref.refresh(firebaseCurrentUserProvider),
      ),
      loading: () => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}