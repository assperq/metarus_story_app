part of 'material_list_bloc.dart';

abstract class MaterialListBlocState extends Equatable {
  const MaterialListBlocState();

  @override
  List<Object?> get props => [];
}

class MaterialListInitialState extends MaterialListBlocState {
  const MaterialListInitialState();
}

class MaterialLoadingState extends MaterialListBlocState {
  const MaterialLoadingState();
}

class MaterialListLoadedState extends MaterialListBlocState {
  final PaginatedResponse<MaterialListItem> materials;

  const MaterialListLoadedState(this.materials);

  @override
  List<Object?> get props => super.props..addAll([materials]);
}

class MaterialListErrorState extends MaterialListBlocState {
  final String message;
  const MaterialListErrorState(this.message);

  @override
  List<Object?> get props => super.props..add(message);
}
