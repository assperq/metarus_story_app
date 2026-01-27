import 'package:auto_route/auto_route.dart';
import 'package:calculator_app/features/material_page/bloc/material_page_bloc.dart';
import 'package:calculator_app/features/material_page/widgets/main_material_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

@RoutePage()
class MaterialPageScreen extends StatefulWidget {
  const MaterialPageScreen({
    super.key,
    @PathParam('materialId') required this.materialId,
  });

  final int materialId;

  @override
  State<MaterialPageScreen> createState() => _MaterialPageScreenState();
}

class _MaterialPageScreenState extends State<MaterialPageScreen> {
  late final MaterialPageBloc _bloc;

  @override
  void initState() {
    super.initState();
    _bloc = MaterialPageBloc();
    _bloc.add(LoadMaterialPage(materialId: widget.materialId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MaterialPageBloc, MaterialPageBlocState>(
        bloc: _bloc,
        builder: (context, state) {
          if (state is MaterialPageLoadedState) {
            return MaterialDetailPage(material: state.material);
          } else if (state is MaterialPageErrorState) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Ошибка: ${state.message}"),
                  ElevatedButton(
                    onPressed: () => _bloc.add(
                      LoadMaterialPage(materialId: widget.materialId),
                    ),
                    child: const Text("Повторить"),
                  ),
                ],
              ),
            );
          }

          return const Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  @override
  void dispose() {
    _bloc.close();
    super.dispose();
  }
}
