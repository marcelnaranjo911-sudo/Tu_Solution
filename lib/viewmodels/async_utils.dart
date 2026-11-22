import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Combina dos AsyncValue en uno solo (cargando / error / datos).
AsyncValue<R> combinar2<A, B, R>(
  AsyncValue<A> a,
  AsyncValue<B> b,
  R Function(A, B) f,
) {
  if (a.hasError) {
    return AsyncValue<R>.error(a.error!, a.stackTrace ?? StackTrace.current);
  }
  if (b.hasError) {
    return AsyncValue<R>.error(b.error!, b.stackTrace ?? StackTrace.current);
  }
  final va = a.value;
  final vb = b.value;
  if (va == null || vb == null) return AsyncValue<R>.loading();
  return AsyncValue<R>.data(f(va, vb));
}

/// Combina tres AsyncValue en uno solo.
AsyncValue<R> combinar3<A, B, C, R>(
  AsyncValue<A> a,
  AsyncValue<B> b,
  AsyncValue<C> c,
  R Function(A, B, C) f,
) {
  if (a.hasError) {
    return AsyncValue<R>.error(a.error!, a.stackTrace ?? StackTrace.current);
  }
  if (b.hasError) {
    return AsyncValue<R>.error(b.error!, b.stackTrace ?? StackTrace.current);
  }
  if (c.hasError) {
    return AsyncValue<R>.error(c.error!, c.stackTrace ?? StackTrace.current);
  }
  final va = a.value;
  final vb = b.value;
  final vc = c.value;
  if (va == null || vb == null || vc == null) return AsyncValue<R>.loading();
  return AsyncValue<R>.data(f(va, vb, vc));
}
