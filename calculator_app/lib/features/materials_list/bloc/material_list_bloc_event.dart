part of 'material_list_bloc.dart';

abstract class MaterialListBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMaterialList extends MaterialListBlocEvent {
  final Completer? completer;
  final String? query;
  final MaterialFilter? filter;
  final int offset;
  LoadMaterialList({
    required this.offset,
    this.completer,
    this.query,
    this.filter,
  });

  @override
  List<Object?> get props =>
      super.props..addAll([completer, query, filter, offset]);
}
