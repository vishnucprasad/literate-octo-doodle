import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/temple/temple_basic_detaiils/temple_basic_details.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories_impl/profile_repository_impl.dart';
import 'package:aaraadhya_temple_dashboard/services/firebase_storage_service.dart';
import 'package:aaraadhya_temple_dashboard/services/image_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_repository.g.dart';

abstract class ProfileRepository {
  Future<TempleBasicDetails?> getBasicDetails(String userId);
  Future<String> updateProfilePicture(
    String userId,
    TempleBasicDetails templeBasicDetails,
  );
  Future<void> saveBasicDetails(
    String userId,
    TempleBasicDetails templeBasicDetails,
  );
}

@riverpod
ProfileRepository profileRepository(Ref ref) {
  final imageService = ref.watch(imageServiceProvider);
  final firebaseStorageService = ref.watch(firebaseStorageServiceProvider);
  final dbDataSource = ref.watch(dbDatasourceProvider);
  return ProfileRepositoryImpl(
    imageService,
    firebaseStorageService,
    dbDataSource,
  );
}
