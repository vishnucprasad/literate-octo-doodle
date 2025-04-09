import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/image_data.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories_impl/pooja_repository_impl.dart';
import 'package:aaraadhya_temple_dashboard/services/firebase_storage_service.dart';
import 'package:aaraadhya_temple_dashboard/services/image_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'pooja_repository.g.dart';

abstract class PoojaRepository {
  Future<List<Pooja>> getPoojas();
  Future<ImageData> pickPoojaImage();
  Future<Pooja> addPooja(Pooja pooja, ImageData image);
  Future<void> addNewPoojaSchedule(String userId, PoojaSchedule schedule);
  Future<List<PoojaSchedule>> getPoojaSchedules(String userId);
}

@riverpod
PoojaRepository poojaRepository(Ref ref) {
  final storage = ref.watch(firebaseStorageServiceProvider);
  final db = ref.watch(dbDatasourceProvider);
  final imageService = ref.watch(imageServiceProvider);
  return PoojaRepositoryImpl(storage, db, imageService);
}
