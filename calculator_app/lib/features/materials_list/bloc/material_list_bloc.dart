import 'dart:async';

import 'package:calculator_app/repositories/materials/abstract_materials_repository.dart';
import 'package:calculator_app/repositories/materials/models/filter.dart';
import 'package:calculator_app/repositories/materials/models/material_list_item/material_list_item.dart';
import 'package:calculator_app/repositories/materials/models/paginated_response/paginated_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'material_list_bloc_event.dart';
part 'material_list_bloc_state.dart';

class MaterialListBloc
    extends Bloc<MaterialListBlocEvent, MaterialListBlocState> {
  MaterialListBloc() : super(const MaterialListInitialState()) {
    on<MaterialListBlocEvent>((event, emit) async {
      if (event is LoadMaterialList) {
        try {
          emit(const MaterialLoadingState());
          var response = await GetIt.I<AbstractMaterialsRepository>()
              .getMaterials(
                offset: event.offset,
                query: event.query,
                filter: event.filter,
              );
          if (state is MaterialListLoadedState) {
            emit(MaterialListLoadedState(response));
          } else {
            emit(
              MaterialListLoadedState(
                response.copyWith(offset: response.total),
              ),
            );
          }
        } catch (e, stk) {
          emit(MaterialListErrorState(e.toString()));
          GetIt.I<Talker>().error(e, stk);
        } finally {
          event.completer?.complete();
        }
      }
    });
  }
}
