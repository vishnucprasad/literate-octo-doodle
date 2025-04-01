import 'package:aaraadhya_temple_dashboard/core/exceptions/auth_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/auth_datasource.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthDatasourceImpl implements AuthDatasource {
  final FirebaseAuth _auth;

  FirebaseAuthDatasourceImpl(this._auth);

  @override
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  @override
  User? getCurrentUser() => _auth.currentUser;

  @override
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthException.unexpected(e.toString());
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw _mapFirebaseAuthException(e);
    } catch (e) {
      throw AuthException.unexpected(e.toString());
    }
  }

  @override
  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      throw AuthException.unexpected(e.toString());
    }
  }

  AuthException _mapFirebaseAuthException(FirebaseAuthException exception) {
    switch (exception.code) {
      case 'invalid-email':
        return const AuthException.invalidEmail();
      case 'user-disabled':
        return const AuthException.userDisabled();
      case 'user-not-found':
        return const AuthException.userNotFound();
      case 'operation-not-allowed':
        return const AuthException.operationNotAllowed();
      case 'invalid-credential':
        return const AuthException.invalidCredential();
      case 'too-many-requests':
        return const AuthException.tooManyRequests();
      default:
        return AuthException.generic(
          exception.message ?? 'An unknown error occurred.',
        );
    }
  }
}
