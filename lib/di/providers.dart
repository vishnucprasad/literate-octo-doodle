import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'providers.g.dart';

@riverpod
Future<PackageInfo> packageInfo(Ref ref) async {
  return await PackageInfo.fromPlatform();
}

@riverpod
ImagePicker imagePicker(Ref ref) => ImagePicker();

@riverpod
ImageCropper imageCropper(Ref ref) => ImageCropper();

@riverpod
FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin(Ref ref) {
  return FlutterLocalNotificationsPlugin();
}
