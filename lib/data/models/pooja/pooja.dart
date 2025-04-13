import 'package:aaraadhya_temple_dashboard/core/enums/pooja_type.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'pooja.freezed.dart';
part 'pooja.g.dart';

@freezed
class Pooja with _$Pooja {
  const factory Pooja({
    required String id,
    required String name,
    required PoojaType? poojaType,
    required String? purpose,
    required String description,
    required String imageUrl,
    required String createdBy,
    required DateTime createdAt,
    required DateTime? modifiedAt,
  }) = _Pooja;

  factory Pooja.empty() {
    return Pooja(
      id: '',
      name: '',
      poojaType: null,
      purpose: null,
      description: '',
      imageUrl: '',
      createdBy: '',
      createdAt: DateTime.now(),
      modifiedAt: null,
    );
  }

  const Pooja._();

  bool get isEmpty => name.isEmpty || description.isEmpty || poojaType == null;

  factory Pooja.fromJson(Map<String, dynamic> json) => _$PoojaFromJson(json);
}
