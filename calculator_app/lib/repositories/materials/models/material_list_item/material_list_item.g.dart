// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'material_list_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MaterialListItem _$MaterialListItemFromJson(Map<String, dynamic> json) =>
    _MaterialListItem(
      id: (json['id'] as num).toInt(),
      name: json['name'] as String,
      type: json['type'] as String,
      width: (json['width'] as num).toDouble(),
      height: (json['height'] as num).toDouble(),
      imageUrl: json['image_url'] as String,
      supplier: json['supplier'] as String,
    );

Map<String, dynamic> _$MaterialListItemToJson(_MaterialListItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'type': instance.type,
      'width': instance.width,
      'height': instance.height,
      'image_url': instance.imageUrl,
      'supplier': instance.supplier,
    };
