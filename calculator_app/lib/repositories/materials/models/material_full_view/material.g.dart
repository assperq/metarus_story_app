// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaterialFullView _$MaterialFullViewFromJson(Map<String, dynamic> json) =>
    _MaterialFullView(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      width: (json['width'] as num?)?.toDouble(),
      height: (json['height'] as num?)?.toDouble(),
      imageUrl: json['image_url'] as String?,
      typeName: json['type_name'] as String,
      supplierName: json['supplier_name'] as String?,
      supplierContactPerson: json['supplier_contact_person'] as String?,
      supplierPhone: json['supplier_phone'] as String?,
      supplierEmail: json['supplier_email'] as String?,
      supplierAddress: json['supplier_address'] as String?,
    );

Map<String, dynamic> _$MaterialFullViewToJson(_MaterialFullView instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'width': instance.width,
      'height': instance.height,
      'image_url': instance.imageUrl,
      'type_name': instance.typeName,
      'supplier_name': instance.supplierName,
      'supplier_contact_person': instance.supplierContactPerson,
      'supplier_phone': instance.supplierPhone,
      'supplier_email': instance.supplierEmail,
      'supplier_address': instance.supplierAddress,
    };
