// material_list_item.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'material_list_item.freezed.dart';
part 'material_list_item.g.dart';

@freezed
abstract class MaterialListItem with _$MaterialListItem {
  const factory MaterialListItem({
    required int id,
    required String name,
    required String type,
    required double width,
    required double height,
    @JsonKey(name: 'image_url') required String imageUrl,
    required String supplier,
  }) = _MaterialListItem;

  factory MaterialListItem.fromJson(Map<String, dynamic> json) =>
      _$MaterialListItemFromJson(json);
}
