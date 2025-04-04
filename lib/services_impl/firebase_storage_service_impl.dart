import 'package:aaraadhya_temple_dashboard/core/exceptions/firebase_storage_exception.dart';
import 'package:aaraadhya_temple_dashboard/services/firebase_storage_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';

class FirebaseStorageServiceImpl implements FirebaseStorageService {
  final FirebaseStorage _storage;

  FirebaseStorageServiceImpl(this._storage);

  @override
  Future<String> uploadImage({
    required String path,
    required Uint8List imageBytes,
  }) async {
    try {
      final ref = _storage.ref().child(path);
      await ref.putData(imageBytes);
      return await ref.getDownloadURL();
    } on FirebaseException catch (e) {
      throw FirebaseStorageException.fromFirebaseException(e);
    } catch (e) {
      throw FirebaseStorageException.unexpected(e.toString());
    }
  }
}
