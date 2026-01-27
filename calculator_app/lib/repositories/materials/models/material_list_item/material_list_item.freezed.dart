// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material_list_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaterialListItem {

 int get id; String get name; String get type; double get width; double get height;@JsonKey(name: 'image_url') String get imageUrl; String get supplier;
/// Create a copy of MaterialListItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaterialListItemCopyWith<MaterialListItem> get copyWith => _$MaterialListItemCopyWithImpl<MaterialListItem>(this as MaterialListItem, _$identity);

  /// Serializes this MaterialListItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaterialListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.supplier, supplier) || other.supplier == supplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,width,height,imageUrl,supplier);

@override
String toString() {
  return 'MaterialListItem(id: $id, name: $name, type: $type, width: $width, height: $height, imageUrl: $imageUrl, supplier: $supplier)';
}


}

/// @nodoc
abstract mixin class $MaterialListItemCopyWith<$Res>  {
  factory $MaterialListItemCopyWith(MaterialListItem value, $Res Function(MaterialListItem) _then) = _$MaterialListItemCopyWithImpl;
@useResult
$Res call({
 int id, String name, String type, double width, double height,@JsonKey(name: 'image_url') String imageUrl, String supplier
});




}
/// @nodoc
class _$MaterialListItemCopyWithImpl<$Res>
    implements $MaterialListItemCopyWith<$Res> {
  _$MaterialListItemCopyWithImpl(this._self, this._then);

  final MaterialListItem _self;
  final $Res Function(MaterialListItem) _then;

/// Create a copy of MaterialListItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? type = null,Object? width = null,Object? height = null,Object? imageUrl = null,Object? supplier = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,supplier: null == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [MaterialListItem].
extension MaterialListItemPatterns on MaterialListItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaterialListItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaterialListItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaterialListItem value)  $default,){
final _that = this;
switch (_that) {
case _MaterialListItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaterialListItem value)?  $default,){
final _that = this;
switch (_that) {
case _MaterialListItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  String type,  double width,  double height, @JsonKey(name: 'image_url')  String imageUrl,  String supplier)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaterialListItem() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.width,_that.height,_that.imageUrl,_that.supplier);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  String type,  double width,  double height, @JsonKey(name: 'image_url')  String imageUrl,  String supplier)  $default,) {final _that = this;
switch (_that) {
case _MaterialListItem():
return $default(_that.id,_that.name,_that.type,_that.width,_that.height,_that.imageUrl,_that.supplier);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  String type,  double width,  double height, @JsonKey(name: 'image_url')  String imageUrl,  String supplier)?  $default,) {final _that = this;
switch (_that) {
case _MaterialListItem() when $default != null:
return $default(_that.id,_that.name,_that.type,_that.width,_that.height,_that.imageUrl,_that.supplier);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaterialListItem implements MaterialListItem {
  const _MaterialListItem({required this.id, required this.name, required this.type, required this.width, required this.height, @JsonKey(name: 'image_url') required this.imageUrl, required this.supplier});
  factory _MaterialListItem.fromJson(Map<String, dynamic> json) => _$MaterialListItemFromJson(json);

@override final  int id;
@override final  String name;
@override final  String type;
@override final  double width;
@override final  double height;
@override@JsonKey(name: 'image_url') final  String imageUrl;
@override final  String supplier;

/// Create a copy of MaterialListItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaterialListItemCopyWith<_MaterialListItem> get copyWith => __$MaterialListItemCopyWithImpl<_MaterialListItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaterialListItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaterialListItem&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.type, type) || other.type == type)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.supplier, supplier) || other.supplier == supplier));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,type,width,height,imageUrl,supplier);

@override
String toString() {
  return 'MaterialListItem(id: $id, name: $name, type: $type, width: $width, height: $height, imageUrl: $imageUrl, supplier: $supplier)';
}


}

/// @nodoc
abstract mixin class _$MaterialListItemCopyWith<$Res> implements $MaterialListItemCopyWith<$Res> {
  factory _$MaterialListItemCopyWith(_MaterialListItem value, $Res Function(_MaterialListItem) _then) = __$MaterialListItemCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, String type, double width, double height,@JsonKey(name: 'image_url') String imageUrl, String supplier
});




}
/// @nodoc
class __$MaterialListItemCopyWithImpl<$Res>
    implements _$MaterialListItemCopyWith<$Res> {
  __$MaterialListItemCopyWithImpl(this._self, this._then);

  final _MaterialListItem _self;
  final $Res Function(_MaterialListItem) _then;

/// Create a copy of MaterialListItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? type = null,Object? width = null,Object? height = null,Object? imageUrl = null,Object? supplier = null,}) {
  return _then(_MaterialListItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,width: null == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double,height: null == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double,imageUrl: null == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String,supplier: null == supplier ? _self.supplier : supplier // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
