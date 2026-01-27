// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'router.dart';

/// generated route for
/// [MaterialListScreen]
class MaterialListRoute extends PageRouteInfo<void> {
  const MaterialListRoute({List<PageRouteInfo>? children})
    : super(MaterialListRoute.name, initialChildren: children);

  static const String name = 'MaterialListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const MaterialListScreen();
    },
  );
}

/// generated route for
/// [MaterialPageScreen]
class MaterialRouteRoute extends PageRouteInfo<MaterialRouteRouteArgs> {
  MaterialRouteRoute({
    Key? key,
    required int materialId,
    List<PageRouteInfo>? children,
  }) : super(
         MaterialRouteRoute.name,
         args: MaterialRouteRouteArgs(key: key, materialId: materialId),
         rawPathParams: {'materialId': materialId},
         initialChildren: children,
       );

  static const String name = 'MaterialRouteRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final pathParams = data.inheritedPathParams;
      final args = data.argsAs<MaterialRouteRouteArgs>(
        orElse: () =>
            MaterialRouteRouteArgs(materialId: pathParams.getInt('materialId')),
      );
      return MaterialPageScreen(key: args.key, materialId: args.materialId);
    },
  );
}

class MaterialRouteRouteArgs {
  const MaterialRouteRouteArgs({this.key, required this.materialId});

  final Key? key;

  final int materialId;

  @override
  String toString() {
    return 'MaterialRouteRouteArgs{key: $key, materialId: $materialId}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! MaterialRouteRouteArgs) return false;
    return key == other.key && materialId == other.materialId;
  }

  @override
  int get hashCode => key.hashCode ^ materialId.hashCode;
}
