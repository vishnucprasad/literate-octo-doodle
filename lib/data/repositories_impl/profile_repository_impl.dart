import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_basic_detaiils/temple_basic_details.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_contact_details/temple_contact_details.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/profile_repository.dart';
import 'package:aaraadhya_temple_dashboard/services/firebase_storage_service.dart';
import 'package:aaraadhya_temple_dashboard/services/image_service.dart';
import 'package:flutter/services.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final ImageService _imageService;
  final FirebaseStorageService _firebaseStorageService;
  final DbDatasource _dbDataSource;

  ProfileRepositoryImpl(
    this._imageService,
    this._firebaseStorageService,
    this._dbDataSource,
  );

  @override
  Future<String> updateProfilePicture(
    String userId,
    TempleBasicDetails templeBasicDetails,
  ) async {
    final Uint8List image = await _imageService.pickAndCropImage();

    final String imageUrl = await _firebaseStorageService.uploadImage(
      imageBytes: image,
      path: "/temples/$userId/profile-pic.png",
    );

    await _dbDataSource.updateDocument('temples', userId, {
      "basicDetails":
          templeBasicDetails.copyWith(profilePictureUrl: imageUrl).toJson(),
    });

    return imageUrl;
  }

  @override
  Future<TempleBasicDetails?> getBasicDetails(String userId) async {
    return await _dbDataSource.getDocument('temples', userId).then((data) {
      if (data?['basicDetails'] == null) return null;
      return TempleBasicDetails.fromJson(data!['basicDetails']);
    });
  }

  @override
  Future<void> saveBasicDetails(
    String userId,
    TempleBasicDetails templeBasicDetails,
  ) async {
    return await _dbDataSource.updateDocument('temples', userId, {
      "basicDetails": templeBasicDetails.toJson(),
    });
  }

  @override
  Future<TempleContactDetails?> getContactDetails(String userId) async {
    return await _dbDataSource.getDocument('temples', userId).then((data) {
      if (data?['contactDetails'] == null) return null;
      return TempleContactDetails.fromJson(data!['contactDetails']);
    });
  }

  @override
  Future<void> saveContactDetails(
    String userId,
    TempleContactDetails templeContactDetails,
  ) async {
    return await _dbDataSource.updateDocument('temples', userId, {
      "contactDetails": templeContactDetails.toJson(),
    });
  }
}
