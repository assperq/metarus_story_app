// supplier.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'supplier.freezed.dart';
part 'supplier.g.dart';

@freezed
abstract class Supplier with _$Supplier {
  const factory Supplier({
    required int id,
    required String name,
    @JsonKey(name: 'contact_person') String? contactPerson,
    String? phone,
    String? email,
    String? address,
    DateTime? createdAt,
  }) = _Supplier;

  factory Supplier.fromJson(Map<String, dynamic> json) =>
      _$SupplierFromJson(json);
}
