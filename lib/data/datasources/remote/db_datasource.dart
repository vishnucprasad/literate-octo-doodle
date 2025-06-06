import 'package:aaraadhya_temple_dashboard/data/datasources_impl/remote/firestore_db_datasource_impl.dart';
import 'package:aaraadhya_temple_dashboard/data/models/core/query_condition.dart';
import 'package:aaraadhya_temple_dashboard/di/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_datasource.g.dart';

abstract class DbDatasource {
  String generateId(String collectionPath);
  Future<void> createDocument(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  );
  Future<Map<String, dynamic>?> getDocument(
    String collectionPath,
    String docId,
  );
  Future<List<Map<String, dynamic>>> queryCollection(
    String collectionPath, {
    List<QueryCondition>? conditions,
    String? orderBy,
    bool descending = true,
  });
  Future<void> updateDocument(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  );
  Future<void> deleteDocument(String collectionPath, String docId);
  Future<void> deleteCollection(String collectionPath, {int batchSize = 100});
  Stream<List<Map<String, dynamic>>> listenToCollection(String collectionPath);
}

@riverpod
DbDatasource dbDatasource(Ref ref) {
  final db = ref.watch(databaseProvider);
  return FirestoreDbDatasourceImpl(db);
}
