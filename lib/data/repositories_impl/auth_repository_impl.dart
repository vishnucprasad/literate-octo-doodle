import 'package:aaraadhya_temple_dashboard/data/datasources/remote/auth_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/auth/credentials/credentials.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/auth_repository.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDatasource _authDatasource;

  AuthRepositoryImpl(this._authDatasource);

  @override
  Stream<User?> authStateChanges() => _authDatasource.authStateChanges();

  @override
  User? getCurrentUser() => _authDatasource.getCurrentUser();

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    await _authDatasource.sendPasswordResetEmail(email);
  }

  @override
  Future<void> signIn(Credentials credentials) async {
    await _authDatasource.signInWithEmailAndPassword(
      credentials.email,
      credentials.password,
    );
  }

  @override
  Future<void> signOut() async => await _authDatasource.signOut();
}
