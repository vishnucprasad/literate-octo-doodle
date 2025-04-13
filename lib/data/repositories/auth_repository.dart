import 'package:aaraadhya_temple_dashboard/data/datasources/remote/auth_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/auth/credentials/credentials.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories_impl/auth_repository_impl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_repository.g.dart';

abstract class AuthRepository {
  Stream<User?> authStateChanges();
  Future<void> signIn(Credentials credentials);
  Future<void> signOut();
  Future<void> sendPasswordResetEmail(String email);
  User? getCurrentUser();
  Future<void> changePassword(String currentPassword, String newPassword);
}

@riverpod
AuthRepository authRepository(Ref ref) {
  final dataSource = ref.watch(authDatasourceProvider);
  return AuthRepositoryImpl(dataSource);
}
