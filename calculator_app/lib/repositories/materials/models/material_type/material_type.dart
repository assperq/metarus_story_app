// material_type.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'material_type.freezed.dart';
part 'material_type.g.dart';

@freezed
abstract class MaterialType with _$MaterialType {
  const factory MaterialType({required int id, required String name}) =
      _MaterialType;

  factory MaterialType.fromJson(Map<String, dynamic> json) =>
      _$MaterialTypeFromJson(json);
}
