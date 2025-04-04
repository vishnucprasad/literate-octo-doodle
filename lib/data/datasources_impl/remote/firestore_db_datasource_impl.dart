import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreDbDatasourceImpl implements DbDatasource {
  final FirebaseFirestore _db;

  FirestoreDbDatasourceImpl(this._db);

  @override
  Future<void> createDocument(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection(collectionPath).doc(docId).set(data);
    } on FirebaseException catch (e) {
      throw DatabaseException.fromFirebaseException(e);
    } on PlatformException catch (e) {
      throw DatabaseException.fromPlatformException(e);
    } catch (e) {
      throw DatabaseException.unexpected(e.toString());
    }
  }

  @override
  Future<Map<String, dynamic>?> getDocument(
    String collectionPath,
    String docId,
  ) async {
    try {
      final docSnapshot = await _db.collection(collectionPath).doc(docId).get();
      if (docSnapshot.exists) return docSnapshot.data();
      throw DatabaseException.notFound();
    } on FirebaseException catch (e) {
      throw DatabaseException.fromFirebaseException(e);
    } on PlatformException catch (e) {
      throw DatabaseException.fromPlatformException(e);
    } on DatabaseException {
      rethrow;
    } catch (e) {
      throw DatabaseException.unexpected(e.toString());
    }
  }

  @override
  Future<void> updateDocument(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  ) async {
    try {
      await _db.collection(collectionPath).doc(docId).update(data);
    } on FirebaseException catch (e) {
      throw DatabaseException.fromFirebaseException(e);
    } on PlatformException catch (e) {
      throw DatabaseException.fromPlatformException(e);
    } catch (e) {
      throw DatabaseException.unexpected(e.toString());
    }
  }

  @override
  Future<void> deleteDocument(String collectionPath, String docId) async {
    try {
      await _db.collection(collectionPath).doc(docId).delete();
    } on FirebaseException catch (e) {
      throw DatabaseException.fromFirebaseException(e);
    } on PlatformException catch (e) {
      throw DatabaseException.fromPlatformException(e);
    } catch (e) {
      throw DatabaseException.unexpected(e.toString());
    }
  }

  @override
  Stream<List<Map<String, dynamic>>> listenToCollection(String collectionPath) {
    try {
      return _db.collection(collectionPath).snapshots().map((snapshot) {
        return snapshot.docs.map((doc) => doc.data()).toList();
      });
    } on FirebaseException catch (e) {
      throw DatabaseException.fromFirebaseException(e);
    } on PlatformException catch (e) {
      throw DatabaseException.fromPlatformException(e);
    } catch (e) {
      throw DatabaseException.unexpected(e.toString());
    }
  }
}
