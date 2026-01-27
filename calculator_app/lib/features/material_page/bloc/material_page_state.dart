part of 'material_page_bloc.dart';

abstract class MaterialPageBlocState extends Equatable {
  const MaterialPageBlocState();

  @override
  List<Object?> get props => [];
}

class MaterialPageBlocInitial extends MaterialPageBlocState {}

class MaterialPageLoadingState extends MaterialPageBlocState {
  const MaterialPageLoadingState();
}

class MaterialPageLoadedState extends MaterialPageBlocState {
  final MaterialFullView material;

  const MaterialPageLoadedState({required this.material});

  @override
  List<Object?> get props => super.props..addAll([material]);
}

class MaterialPageErrorState extends MaterialPageBlocState {
  final String message;
  const MaterialPageErrorState(this.message);

  @override
  List<Object?> get props => super.props..add(message);
}
