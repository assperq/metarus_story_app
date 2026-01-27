import 'package:freezed_annotation/freezed_annotation.dart';

part 'simple_response.freezed.dart';
part 'simple_response.g.dart';

@Freezed(genericArgumentFactories: true)
abstract class SimpleResponse<T> with _$SimpleResponse<T> {
  const factory SimpleResponse({required List<T> data}) = _SimpleResponse<T>;

  factory SimpleResponse.fromJson(
    Map<String, dynamic> json,
    T Function(Object? json) fromJsonT,
  ) => _$SimpleResponseFromJson(json, fromJsonT);
}
