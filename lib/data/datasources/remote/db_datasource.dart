import 'package:aaraadhya_temple_dashboard/data/datasources_impl/remote/firestore_db_datasource_impl.dart';
import 'package:aaraadhya_temple_dashboard/di/firebase_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'db_datasource.g.dart';

class QueryCondition {
  final String field;
  final String operator;
  final dynamic value;

  QueryCondition({
    required this.field,
    required this.operator,
    required this.value,
  });
}

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

  Future<List<Map<String, dynamic>>> getCollection(
    String collectionPath, {
    String? orderBy,
    bool descending = true,
  });

  Future<List<Map<String, dynamic>>> getCollectionByField(
    String collectionPath, {
    required Object field,
    required dynamic value,
    String? orderBy,
    bool descending = true,
  });

  Future<List<Map<String, dynamic>>> queryCollection(
    String collectionPath, {
    required List<QueryCondition> conditions,
    String? orderBy,
    bool descending = true,
  });

  Future<void> updateDocument(
    String collectionPath,
    String docId,
    Map<String, dynamic> data,
  );

  Future<void> deleteDocument(String collectionPath, String docId);

  Stream<List<Map<String, dynamic>>> listenToCollection(String collectionPath);
}

@riverpod
DbDatasource dbDatasource(Ref ref) {
  final db = ref.watch(databaseProvider);
  return FirestoreDbDatasourceImpl(db);
}
