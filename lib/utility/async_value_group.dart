import 'package:riverpod/riverpod.dart';

class Tuple2<T1, T2> {
  final T1 a1;
  final T2 a2;

  Tuple2(this.a1, this.a2);
}

class Tuple3<T1, T2, T3> {
  final T1 a1;
  final T2 a2;
  final T3 a3;

  Tuple3(this.a1, this.a2, this.a3);
}

extension AsyncValueGroup on AsyncValue {
  static AsyncValue<Tuple2<T1, T2>> group2<T1, T2>(
      AsyncValue<T1> a1, AsyncValue<T2> a2) {
    if (a1 is AsyncLoading || a2 is AsyncLoading) {
      return const AsyncLoading();
    }
    try {
      return AsyncData(Tuple2(a1.value as T1, a2.value as T2));
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }

  static AsyncValue<Tuple3<T1, T2, T3>> group3<T1, T2, T3>(
      AsyncValue<T1> a1, AsyncValue<T2> a2, AsyncValue<T3> a3) {
    if (a1 is AsyncLoading || a2 is AsyncLoading || a3 is AsyncLoading) {
      return const AsyncLoading();
    }
    try {
      return AsyncData(Tuple3(a1.value as T1, a2.value as T2, a3.value as T3));
    } catch (e, st) {
      return AsyncError(e, st);
    }
  }
}
