// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'material.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$MaterialFullView {

 int get id; String get name; double? get width; double? get height;@JsonKey(name: 'image_url') String? get imageUrl;@JsonKey(name: 'type_name') String get typeName;@JsonKey(name: 'supplier_name') String? get supplierName;@JsonKey(name: 'supplier_contact_person') String? get supplierContactPerson;@JsonKey(name: 'supplier_phone') String? get supplierPhone;@JsonKey(name: 'supplier_email') String? get supplierEmail;@JsonKey(name: 'supplier_address') String? get supplierAddress;
/// Create a copy of MaterialFullView
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$MaterialFullViewCopyWith<MaterialFullView> get copyWith => _$MaterialFullViewCopyWithImpl<MaterialFullView>(this as MaterialFullView, _$identity);

  /// Serializes this MaterialFullView to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is MaterialFullView&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.supplierContactPerson, supplierContactPerson) || other.supplierContactPerson == supplierContactPerson)&&(identical(other.supplierPhone, supplierPhone) || other.supplierPhone == supplierPhone)&&(identical(other.supplierEmail, supplierEmail) || other.supplierEmail == supplierEmail)&&(identical(other.supplierAddress, supplierAddress) || other.supplierAddress == supplierAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,width,height,imageUrl,typeName,supplierName,supplierContactPerson,supplierPhone,supplierEmail,supplierAddress);

@override
String toString() {
  return 'MaterialFullView(id: $id, name: $name, width: $width, height: $height, imageUrl: $imageUrl, typeName: $typeName, supplierName: $supplierName, supplierContactPerson: $supplierContactPerson, supplierPhone: $supplierPhone, supplierEmail: $supplierEmail, supplierAddress: $supplierAddress)';
}


}

/// @nodoc
abstract mixin class $MaterialFullViewCopyWith<$Res>  {
  factory $MaterialFullViewCopyWith(MaterialFullView value, $Res Function(MaterialFullView) _then) = _$MaterialFullViewCopyWithImpl;
@useResult
$Res call({
 int id, String name, double? width, double? height,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'type_name') String typeName,@JsonKey(name: 'supplier_name') String? supplierName,@JsonKey(name: 'supplier_contact_person') String? supplierContactPerson,@JsonKey(name: 'supplier_phone') String? supplierPhone,@JsonKey(name: 'supplier_email') String? supplierEmail,@JsonKey(name: 'supplier_address') String? supplierAddress
});




}
/// @nodoc
class _$MaterialFullViewCopyWithImpl<$Res>
    implements $MaterialFullViewCopyWith<$Res> {
  _$MaterialFullViewCopyWithImpl(this._self, this._then);

  final MaterialFullView _self;
  final $Res Function(MaterialFullView) _then;

/// Create a copy of MaterialFullView
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? width = freezed,Object? height = freezed,Object? imageUrl = freezed,Object? typeName = null,Object? supplierName = freezed,Object? supplierContactPerson = freezed,Object? supplierPhone = freezed,Object? supplierEmail = freezed,Object? supplierAddress = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,typeName: null == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String,supplierName: freezed == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String?,supplierContactPerson: freezed == supplierContactPerson ? _self.supplierContactPerson : supplierContactPerson // ignore: cast_nullable_to_non_nullable
as String?,supplierPhone: freezed == supplierPhone ? _self.supplierPhone : supplierPhone // ignore: cast_nullable_to_non_nullable
as String?,supplierEmail: freezed == supplierEmail ? _self.supplierEmail : supplierEmail // ignore: cast_nullable_to_non_nullable
as String?,supplierAddress: freezed == supplierAddress ? _self.supplierAddress : supplierAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [MaterialFullView].
extension MaterialFullViewPatterns on MaterialFullView {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _MaterialFullView value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _MaterialFullView() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _MaterialFullView value)  $default,){
final _that = this;
switch (_that) {
case _MaterialFullView():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _MaterialFullView value)?  $default,){
final _that = this;
switch (_that) {
case _MaterialFullView() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int id,  String name,  double? width,  double? height, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'type_name')  String typeName, @JsonKey(name: 'supplier_name')  String? supplierName, @JsonKey(name: 'supplier_contact_person')  String? supplierContactPerson, @JsonKey(name: 'supplier_phone')  String? supplierPhone, @JsonKey(name: 'supplier_email')  String? supplierEmail, @JsonKey(name: 'supplier_address')  String? supplierAddress)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _MaterialFullView() when $default != null:
return $default(_that.id,_that.name,_that.width,_that.height,_that.imageUrl,_that.typeName,_that.supplierName,_that.supplierContactPerson,_that.supplierPhone,_that.supplierEmail,_that.supplierAddress);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int id,  String name,  double? width,  double? height, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'type_name')  String typeName, @JsonKey(name: 'supplier_name')  String? supplierName, @JsonKey(name: 'supplier_contact_person')  String? supplierContactPerson, @JsonKey(name: 'supplier_phone')  String? supplierPhone, @JsonKey(name: 'supplier_email')  String? supplierEmail, @JsonKey(name: 'supplier_address')  String? supplierAddress)  $default,) {final _that = this;
switch (_that) {
case _MaterialFullView():
return $default(_that.id,_that.name,_that.width,_that.height,_that.imageUrl,_that.typeName,_that.supplierName,_that.supplierContactPerson,_that.supplierPhone,_that.supplierEmail,_that.supplierAddress);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int id,  String name,  double? width,  double? height, @JsonKey(name: 'image_url')  String? imageUrl, @JsonKey(name: 'type_name')  String typeName, @JsonKey(name: 'supplier_name')  String? supplierName, @JsonKey(name: 'supplier_contact_person')  String? supplierContactPerson, @JsonKey(name: 'supplier_phone')  String? supplierPhone, @JsonKey(name: 'supplier_email')  String? supplierEmail, @JsonKey(name: 'supplier_address')  String? supplierAddress)?  $default,) {final _that = this;
switch (_that) {
case _MaterialFullView() when $default != null:
return $default(_that.id,_that.name,_that.width,_that.height,_that.imageUrl,_that.typeName,_that.supplierName,_that.supplierContactPerson,_that.supplierPhone,_that.supplierEmail,_that.supplierAddress);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _MaterialFullView extends MaterialFullView {
  const _MaterialFullView({required this.id, required this.name, this.width, this.height, @JsonKey(name: 'image_url') this.imageUrl, @JsonKey(name: 'type_name') required this.typeName, @JsonKey(name: 'supplier_name') this.supplierName, @JsonKey(name: 'supplier_contact_person') this.supplierContactPerson, @JsonKey(name: 'supplier_phone') this.supplierPhone, @JsonKey(name: 'supplier_email') this.supplierEmail, @JsonKey(name: 'supplier_address') this.supplierAddress}): super._();
  factory _MaterialFullView.fromJson(Map<String, dynamic> json) => _$MaterialFullViewFromJson(json);

@override final  int id;
@override final  String name;
@override final  double? width;
@override final  double? height;
@override@JsonKey(name: 'image_url') final  String? imageUrl;
@override@JsonKey(name: 'type_name') final  String typeName;
@override@JsonKey(name: 'supplier_name') final  String? supplierName;
@override@JsonKey(name: 'supplier_contact_person') final  String? supplierContactPerson;
@override@JsonKey(name: 'supplier_phone') final  String? supplierPhone;
@override@JsonKey(name: 'supplier_email') final  String? supplierEmail;
@override@JsonKey(name: 'supplier_address') final  String? supplierAddress;

/// Create a copy of MaterialFullView
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$MaterialFullViewCopyWith<_MaterialFullView> get copyWith => __$MaterialFullViewCopyWithImpl<_MaterialFullView>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$MaterialFullViewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _MaterialFullView&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.width, width) || other.width == width)&&(identical(other.height, height) || other.height == height)&&(identical(other.imageUrl, imageUrl) || other.imageUrl == imageUrl)&&(identical(other.typeName, typeName) || other.typeName == typeName)&&(identical(other.supplierName, supplierName) || other.supplierName == supplierName)&&(identical(other.supplierContactPerson, supplierContactPerson) || other.supplierContactPerson == supplierContactPerson)&&(identical(other.supplierPhone, supplierPhone) || other.supplierPhone == supplierPhone)&&(identical(other.supplierEmail, supplierEmail) || other.supplierEmail == supplierEmail)&&(identical(other.supplierAddress, supplierAddress) || other.supplierAddress == supplierAddress));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,width,height,imageUrl,typeName,supplierName,supplierContactPerson,supplierPhone,supplierEmail,supplierAddress);

@override
String toString() {
  return 'MaterialFullView(id: $id, name: $name, width: $width, height: $height, imageUrl: $imageUrl, typeName: $typeName, supplierName: $supplierName, supplierContactPerson: $supplierContactPerson, supplierPhone: $supplierPhone, supplierEmail: $supplierEmail, supplierAddress: $supplierAddress)';
}


}

/// @nodoc
abstract mixin class _$MaterialFullViewCopyWith<$Res> implements $MaterialFullViewCopyWith<$Res> {
  factory _$MaterialFullViewCopyWith(_MaterialFullView value, $Res Function(_MaterialFullView) _then) = __$MaterialFullViewCopyWithImpl;
@override @useResult
$Res call({
 int id, String name, double? width, double? height,@JsonKey(name: 'image_url') String? imageUrl,@JsonKey(name: 'type_name') String typeName,@JsonKey(name: 'supplier_name') String? supplierName,@JsonKey(name: 'supplier_contact_person') String? supplierContactPerson,@JsonKey(name: 'supplier_phone') String? supplierPhone,@JsonKey(name: 'supplier_email') String? supplierEmail,@JsonKey(name: 'supplier_address') String? supplierAddress
});




}
/// @nodoc
class __$MaterialFullViewCopyWithImpl<$Res>
    implements _$MaterialFullViewCopyWith<$Res> {
  __$MaterialFullViewCopyWithImpl(this._self, this._then);

  final _MaterialFullView _self;
  final $Res Function(_MaterialFullView) _then;

/// Create a copy of MaterialFullView
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? width = freezed,Object? height = freezed,Object? imageUrl = freezed,Object? typeName = null,Object? supplierName = freezed,Object? supplierContactPerson = freezed,Object? supplierPhone = freezed,Object? supplierEmail = freezed,Object? supplierAddress = freezed,}) {
  return _then(_MaterialFullView(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as int,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,width: freezed == width ? _self.width : width // ignore: cast_nullable_to_non_nullable
as double?,height: freezed == height ? _self.height : height // ignore: cast_nullable_to_non_nullable
as double?,imageUrl: freezed == imageUrl ? _self.imageUrl : imageUrl // ignore: cast_nullable_to_non_nullable
as String?,typeName: null == typeName ? _self.typeName : typeName // ignore: cast_nullable_to_non_nullable
as String,supplierName: freezed == supplierName ? _self.supplierName : supplierName // ignore: cast_nullable_to_non_nullable
as String?,supplierContactPerson: freezed == supplierContactPerson ? _self.supplierContactPerson : supplierContactPerson // ignore: cast_nullable_to_non_nullable
as String?,supplierPhone: freezed == supplierPhone ? _self.supplierPhone : supplierPhone // ignore: cast_nullable_to_non_nullable
as String?,supplierEmail: freezed == supplierEmail ? _self.supplierEmail : supplierEmail // ignore: cast_nullable_to_non_nullable
as String?,supplierAddress: freezed == supplierAddress ? _self.supplierAddress : supplierAddress // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
