part of 'material_page_bloc.dart';

abstract class MaterialPageBlocEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class LoadMaterialPage extends MaterialPageBlocEvent {
  final int materialId;
  LoadMaterialPage({required this.materialId});

  @override
  List<Object?> get props => super.props..add(materialId);
}
