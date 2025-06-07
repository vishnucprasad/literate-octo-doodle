import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/core/query_condition.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/services.dart';

class FirestoreDbDatasourceImpl implements DbDatasource {
  final FirebaseFirestore _db;

  FirestoreDbDatasourceImpl(this._db);

  @override
  String generateId(String collectionPath) {
    try {
      final docRef = _db.collection(collectionPath).doc();
      return docRef.id;
    } on FirebaseException catch (e) {
      throw DatabaseException.fromFirebaseException(e);
    } on PlatformException catch (e) {
      throw DatabaseException.fromPlatformException(e);
    } catch (e) {
      throw DatabaseException.unexpected(e.toString());
    }
  }

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
      if (docSnapshot.exists && docSnapshot.data() != null) {
        return {"id": docSnapshot.id, ...docSnapshot.data()!};
      }
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
  Future<List<Map<String, dynamic>>> queryCollection(
    String collectionPath, {
    List<QueryCondition>? conditions,
    String? orderBy,
    bool descending = true,
  }) async {
    try {
      Query<Map<String, dynamic>> query = _db.collection(collectionPath);

      // Apply all query conditions if specified
      if (conditions != null) {
        for (final condition in conditions) {
          switch (condition.operator) {
            case "==":
              query = query.where(condition.field, isEqualTo: condition.value);
              break;
            case "!=":
              query = query.where(
                condition.field,
                isNotEqualTo: condition.value,
              );
              break;
            case ">":
              query = query.where(
                condition.field,
                isGreaterThan: condition.value,
              );
              break;
            case ">=":
              query = query.where(
                condition.field,
                isGreaterThanOrEqualTo: condition.value,
              );
              break;
            case "<":
              query = query.where(condition.field, isLessThan: condition.value);
              break;
            case "<=":
              query = query.where(
                condition.field,
                isLessThanOrEqualTo: condition.value,
              );
              break;
            case "array-contains":
              query = query.where(
                condition.field,
                arrayContains: condition.value,
              );
              break;
            case "array-contains-any":
              query = query.where(
                condition.field,
                arrayContainsAny: condition.value,
              );
              break;
            case "in":
              query = query.where(condition.field, whereIn: condition.value);
              break;
            case "not-in":
              query = query.where(condition.field, whereNotIn: condition.value);
              break;
          }
        }
      }

      // Apply ordering if specified
      if (orderBy != null) {
        query = query.orderBy(orderBy, descending: descending);
      }

      final querySnapshot = await query.get();

      return querySnapshot.docs
          .map((doc) => {"id": doc.id, ...doc.data()})
          .toList();
    } on FirebaseException catch (e) {
      throw DatabaseException.fromFirebaseException(e);
    } on PlatformException catch (e) {
      throw DatabaseException.fromPlatformException(e);
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
  Future<void> deleteCollection(
    String collectionPath, {
    int batchSize = 100,
  }) async {
    try {
      final collectionRef = _db.collection(collectionPath);
      final query = collectionRef.limit(batchSize);

      // Recursive delete function
      Future<void> deleteBatch(Query<Map<String, dynamic>> query) async {
        final snapshot = await query.get();

        if (snapshot.docs.isEmpty) return;

        final batch = _db.batch();
        for (final doc in snapshot.docs) {
          batch.delete(doc.reference);
        }

        await batch.commit();

        // Recursively delete next batch
        await deleteBatch(query);
      }

      await deleteBatch(query);
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
        return snapshot.docs
            .map((doc) => {'id': doc.id, ...doc.data()})
            .toList();
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
