import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/image_data.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/advanced_options/advanced_options.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_basic_detaiils/temple_basic_details.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_contact_details/temple_contact_details.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_gallery/gallery_item.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/profile_repository.dart';
import 'package:aaraadhya_temple_dashboard/services/firebase_storage_service.dart';
import 'package:aaraadhya_temple_dashboard/services/image_service.dart';
import 'package:image_cropper/image_cropper.dart';

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
    final ImageData image = await _imageService.pickAndCropImage(
      cropAspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
    );

    final String imageUrl = await _firebaseStorageService.uploadFile(
      fileBytes: image.bytes,
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

  @override
  Future<AdvancedOptions?> getAdvancedOptions(String userId) async {
    return await _dbDataSource.getDocument('temples', userId).then((data) {
      if (data?['advancedOptions'] == null) return null;
      return AdvancedOptions.fromJson(data!['advancedOptions']);
    });
  }

  @override
  Future<void> saveAdvancedOptions(
    String userId,
    AdvancedOptions advancedOptions,
  ) async {
    return await _dbDataSource.updateDocument('temples', userId, {
      "advancedOptions": advancedOptions.toJson(),
    });
  }

  @override
  Future<List<GalleryItem>> getGalleryItems(String userId) async {
    return await _dbDataSource
        .getCollection('temples/$userId/gallery', orderBy: 'uploadedAt')
        .then((data) => data.map((doc) => GalleryItem.fromJson(doc)).toList());
  }

  @override
  Future<GalleryItem> uploadNewGalleryItem(String userId) async {
    final ImageData image = await _imageService.pickAndCropImage();

    final String id = _dbDataSource.generateId('temples/$userId/gallery');

    final String imageUrl = await _firebaseStorageService.uploadFile(
      fileBytes: image.bytes,
      path: "/temples/$userId/gallery/$id-${image.fileName}",
    );

    final item = GalleryItem(
      id: id,
      url: imageUrl,
      fileName: image.fileName,
      uploadedAt: DateTime.now(),
    );

    await _dbDataSource.createDocument(
      'temples/$userId/gallery',
      id,
      item.toJson(),
    );

    return item;
  }

  @override
  Future<void> deleteGalleryItem(String userId, GalleryItem item) async {
    await _firebaseStorageService.deleteFile(fileUrl: item.url);
    return await _dbDataSource.deleteDocument(
      'temples/$userId/gallery',
      item.id,
    );
  }
}
