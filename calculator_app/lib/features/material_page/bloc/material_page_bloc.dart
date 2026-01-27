import 'package:calculator_app/repositories/materials/abstract_materials_repository.dart';
import 'package:calculator_app/repositories/materials/models/material_full_view/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'material_page_event.dart';
part 'material_page_state.dart';

class MaterialPageBloc
    extends Bloc<MaterialPageBlocEvent, MaterialPageBlocState> {
  MaterialPageBloc() : super(MaterialPageBlocInitial()) {
    on<MaterialPageBlocEvent>((event, emit) async {
      if (event is LoadMaterialPage) {
        try {
          emit(const MaterialPageLoadingState());
          var material = await GetIt.I<AbstractMaterialsRepository>()
              .singleMaterial(event.materialId);
          emit(MaterialPageLoadedState(material: material));
        } catch (e, stk) {
          GetIt.I<Talker>().error(e, stk);
          emit(MaterialPageErrorState(e.toString()));
        }
      }
    });
  }
}
