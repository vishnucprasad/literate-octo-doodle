import 'package:aaraadhya_temple_dashboard/data/datasources_impl/remote/firebase_auth_datasource_impl.dart';
import 'package:aaraadhya_temple_dashboard/di/firebase_providers.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_datasource.g.dart';

abstract class AuthDatasource {
  Stream<User?> authStateChanges();
  Future<void> signInWithEmailAndPassword(String email, String password);
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  User? getCurrentUser();
  Future<void> changePassword(String currentPassword, String newPassword);
}

@riverpod
AuthDatasource authDatasource(Ref ref) {
  final auth = ref.watch(authProvider);
  return FirebaseAuthDatasourceImpl(auth);
}
