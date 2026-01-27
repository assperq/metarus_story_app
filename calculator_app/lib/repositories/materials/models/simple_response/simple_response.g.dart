// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'simple_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SimpleResponse<T> _$SimpleResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) => _SimpleResponse<T>(
  data: (json['data'] as List<dynamic>).map(fromJsonT).toList(),
);

Map<String, dynamic> _$SimpleResponseToJson<T>(
  _SimpleResponse<T> instance,
  Object? Function(T value) toJsonT,
) => <String, dynamic>{'data': instance.data.map(toJsonT).toList()};
