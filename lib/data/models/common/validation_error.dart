import 'package:freezed_annotation/freezed_annotation.dart';

part 'validation_error.freezed.dart';

@freezed
class ValidationError with _$ValidationError {
  const factory ValidationError.empty() = _Empty;
  const factory ValidationError.invalid() = _Invalid;
  const factory ValidationError.short(int minLength) = _Short;
  const factory ValidationError.exceedingLength(int maxLength) =
      _ExceedingLength;
}
