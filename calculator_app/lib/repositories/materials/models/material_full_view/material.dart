// ignore_for_file: public_member_api_docs, sort_constructors_first
// material_full_view.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'material.freezed.dart';
part 'material.g.dart';

@freezed
abstract class MaterialFullView with _$MaterialFullView {
  const MaterialFullView._();

  const factory MaterialFullView({
    required int id,
    required String name,
    double? width,
    double? height,
    @JsonKey(name: 'image_url') String? imageUrl,
    @JsonKey(name: 'type_name') required String typeName,
    @JsonKey(name: 'supplier_name') String? supplierName,
    @JsonKey(name: 'supplier_contact_person') String? supplierContactPerson,
    @JsonKey(name: 'supplier_phone') String? supplierPhone,
    @JsonKey(name: 'supplier_email') String? supplierEmail,
    @JsonKey(name: 'supplier_address') String? supplierAddress,
  }) = _MaterialFullView;

  factory MaterialFullView.fromJson(Map<String, dynamic> json) =>
      _$MaterialFullViewFromJson(json);
}
