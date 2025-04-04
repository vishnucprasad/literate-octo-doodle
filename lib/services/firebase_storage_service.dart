import 'package:aaraadhya_temple_dashboard/di/firebase_providers.dart';
import 'package:aaraadhya_temple_dashboard/services_impl/firebase_storage_service_impl.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'firebase_storage_service.g.dart';

abstract class FirebaseStorageService {
  Future<String> uploadImage({
    required String path,
    required Uint8List imageBytes,
  });
}

@riverpod
FirebaseStorageService firebaseStorageService(Ref ref) {
  final storage = ref.watch(firebaseStorageProvider);
  return FirebaseStorageServiceImpl(storage);
}
