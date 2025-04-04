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
      throw AuthException.fromFirebaseAuthException(e);
    } catch (e) {
      throw AuthException.unexpected(e.toString());
    }
  }

  @override
  Future<void> signInWithEmailAndPassword(String email, String password) async {
    try {
      await _auth.signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw AuthException.fromFirebaseAuthException(e);
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
}
