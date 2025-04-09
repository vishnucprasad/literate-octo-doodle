import 'package:aaraadhya_temple_dashboard/core/exceptions/base_exception.dart';
import 'package:aaraadhya_temple_dashboard/data/models/common/image_data.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/pooja.dart';
import 'package:aaraadhya_temple_dashboard/data/models/pooja/validation_errors/pooja_validation_errors.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'poojas_state.freezed.dart';

@freezed
class PoojasState with _$PoojasState {
  const factory PoojasState({
    @Default(false) bool isLoading,
    @Default(false) bool isSaving,
    @Default([]) List<Pooja> poojas,
    required Pooja pooja,
    required ImageData? poojaImage,
    @Default(PoojaValidationErrors()) PoojaValidationErrors validationErrors,
    BaseException? error,
  }) = _PoojasState;

  factory PoojasState.initial() {
    return PoojasState(pooja: Pooja.empty(), poojaImage: null);
  }

  const PoojasState._();

  bool get isValid =>
      !validationErrors.hasErrors &&
      !pooja.isEmpty &&
      poojaImage != null &&
      !isSaving;
}
