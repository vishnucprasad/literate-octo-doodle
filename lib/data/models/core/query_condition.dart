import 'package:freezed_annotation/freezed_annotation.dart';

part 'query_condition.freezed.dart';

@freezed
class QueryCondition with _$QueryCondition {
  const factory QueryCondition({
    required String field,
    required String operator,
    required dynamic value,
  }) = _QueryCondition;
}
