import 'package:aaraadhya_temple_dashboard/core/exceptions/database_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/datasources/remote/db_datasource.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/image_data.dart';
import 'package:aaraadhya_temple_dashboard/data/models/core/query_condition.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja_schedule/pooja_schedule.dart';
import 'package:aaraadhya_temple_dashboard/data/repositories/pooja_repository.dart';
import 'package:aaraadhya_temple_dashboard/services/firebase_storage_service.dart';
import 'package:aaraadhya_temple_dashboard/services/image_service.dart';
import 'package:image_cropper/image_cropper.dart';

class PoojaRepositoryImpl implements PoojaRepository {
  final FirebaseStorageService _storageService;
  final DbDatasource _dbDatasource;
  final ImageService _imageService;

  PoojaRepositoryImpl(
    this._storageService,
    this._dbDatasource,
    this._imageService,
  );

  @override
  Future<Pooja> addPooja(Pooja pooja, ImageData image) async {
    final documents = await _dbDatasource.queryCollection('poojas');

    final isExistingName = documents.any(
      (doc) => doc['name'].toString().toLowerCase() == pooja.name.toLowerCase(),
    );

    if (isExistingName) {
      throw DatabaseException.alreadyExists();
    }

    final String id = _dbDatasource.generateId('poojas');
    final imageUrl = await _storageService.uploadFile(
      path: '/poojas/$id/${image.fileName}',
      fileBytes: image.bytes,
    );

    final data = pooja.copyWith(
      id: id,
      imageUrl: imageUrl,
      createdAt: DateTime.now(),
    );

    await _dbDatasource.createDocument('poojas', id, data.toJson());

    return data;
  }

  @override
  Future<List<Pooja>> getPoojas() async {
    return await _dbDatasource
        .queryCollection('poojas', orderBy: 'createdAt')
        .then((value) => value.map((e) => Pooja.fromJson(e)).toList());
  }

  @override
  Future<ImageData> pickPoojaImage() {
    return _imageService.pickAndCropImage(
      cropAspectRatio: CropAspectRatio(ratioX: 3, ratioY: 4),
    );
  }

  @override
  Future<PoojaSchedule> addNewPoojaSchedule(
    String userId,
    PoojaSchedule schedule,
  ) async {
    final String id = _dbDatasource.generateId('temple-poojas');

    final data = {
      "id": id,
      "templeId": userId,
      "poojaId": schedule.pooja.id,
      "isActive": schedule.isActive,
      "price": schedule.price,
      "deityName": schedule.deityName,
      "scheduleMode": schedule.scheduleMode?.name,
      "poojaDays": schedule.poojaDays,
      "poojaTime": schedule.poojaTime?.name,
      "poojaDateAndTime": schedule.poojaDateAndTime?.toIso8601String(),
      "createdAt": DateTime.now().toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    };

    await _dbDatasource.createDocument("temple-poojas", id, data);

    return PoojaSchedule.fromJson({...data, "pooja": schedule.pooja.toJson()});
  }

  @override
  Future<List<PoojaSchedule>> getPoojaSchedules(String userId) async {
    final docs = await _dbDatasource.queryCollection(
      'temple-poojas',
      conditions: [
        QueryCondition(field: 'templeId', operator: '==', value: userId),
      ],
    );

    final schedules = await Future.wait(
      docs.map((doc) async {
        final pooja = await _dbDatasource.getDocument('poojas', doc['poojaId']);
        return PoojaSchedule.fromJson({...doc, "pooja": pooja});
      }),
    );

    return schedules;
  }

  @override
  Future<PoojaSchedule> updatePoojaSchedule(PoojaSchedule schedule) async {
    final data = {
      "id": schedule.id,
      "templeId": schedule.templeId,
      "poojaId": schedule.pooja.id,
      "isActive": schedule.isActive,
      "price": schedule.price,
      "deityName": schedule.deityName,
      "scheduleMode": schedule.scheduleMode?.name,
      "poojaDays": schedule.poojaDays,
      "poojaTime": schedule.poojaTime?.name,
      "poojaDateAndTime": schedule.poojaDateAndTime?.toIso8601String(),
      "createdAt": schedule.createdAt.toIso8601String(),
      "updatedAt": DateTime.now().toIso8601String(),
    };

    await _dbDatasource.updateDocument("temple-poojas", schedule.id, data);

    return PoojaSchedule.fromJson({...data, "pooja": schedule.pooja.toJson()});
  }

  @override
  Future<void> deletePoojaSchedule(String id) async {
    await _dbDatasource.deleteDocument("temple-poojas", id);
  }
}
