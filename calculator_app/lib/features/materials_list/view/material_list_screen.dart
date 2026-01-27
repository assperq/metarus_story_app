import 'dart:async';
import 'dart:math';

import 'package:auto_route/auto_route.dart';
import 'package:calculator_app/features/materials_list/bloc/material_list_bloc.dart';
import 'package:calculator_app/features/materials_list/widgets/adaptive_grid_delegate.dart';
import 'package:calculator_app/features/materials_list/widgets/material_card.dart';
import 'package:calculator_app/features/materials_list/widgets/material_grid_card.dart';
import 'package:calculator_app/features/materials_list/widgets/search_widget.dart';
import 'package:calculator_app/repositories/materials/models/filter.dart';
import 'package:calculator_app/repositories/materials/models/material_list_item/material_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:talker_flutter/talker_flutter.dart';

@RoutePage()
class MaterialListScreen extends StatefulWidget {
  const MaterialListScreen({super.key});

  @override
  State<MaterialListScreen> createState() => _MaterialListScreenState();
}

class _MaterialListScreenState extends State<MaterialListScreen> {
  MaterialFilter? _filter;
  String? _query;
  int offset = 0;

  late final _pagingController = PagingController<int, MaterialListItem>(
    getNextPageKey: (state) =>
        state.lastPageIsEmpty ? null : state.nextIntPageKey,
    fetchPage: (pageKey) {
      try {
        var state = _materialBloc.state as MaterialListLoadedState;
        GetIt.I<Talker>().log('fetchPage on: ${state.materials.data.length}');
        offset += state.materials.total;
        return state.materials.data;
      } catch (e, stk) {
        GetIt.I<Talker>().error(e, stk);
        return [];
      }
    },
  );

  bool _isGrid = true;
  final _materialBloc = GetIt.I<MaterialListBloc>();

  @override
  void initState() {
    _loadMaterials();
    super.initState();
  }

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('ООО Метарус')),
      body: RefreshIndicator(
        onRefresh: () async {
          Completer completer = Completer();
          await Future.delayed(Duration(milliseconds: Random().nextInt(300)));
          completer.complete();
          return completer.future;
        },
        child: Column(
          children: [
            const SizedBox(height: 16),
            SimpleSearchFilter(
              onSearch: (str) async {
                _pagingController.refresh();
                _query = str;
                offset = 0;
                await _loadMaterials();
              },
              onFilter: (categories, supliers) async {
                _filter = MaterialFilter(
                  typeIds: categories,
                  supplierIds: supliers,
                );
                offset = 0;
                _pagingController.refresh();
                await _loadMaterials();
              },
            ),
            Expanded(
              child: BlocBuilder<MaterialListBloc, MaterialListBlocState>(
                bloc: _materialBloc,
                builder: (context, state) {
                  if (state is MaterialListLoadedState) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16),
                            child: SegmentedButton<bool>(
                              segments: const [
                                ButtonSegment<bool>(
                                  value: true,
                                  icon: Icon(Icons.grid_3x3),
                                ),
                                ButtonSegment<bool>(
                                  value: false,
                                  icon: Icon(Icons.list),
                                ),
                              ],
                              selected: {_isGrid},
                              onSelectionChanged: (Set<bool> newSelection) {
                                setState(() {
                                  _isGrid = newSelection.first;
                                });
                              },
                              showSelectedIcon: false,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        Expanded(
                          child: PagingListener(
                            controller: _pagingController,
                            builder: (context, state, fetchNextPage) => _isGrid
                                ? _buildMaterialGridView(state, fetchNextPage)
                                : _buildMaterialListView(state, fetchNextPage),
                          ),
                        ),
                      ],
                    );
                  }
                  if (state is MaterialListErrorState) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        spacing: 16,
                        children: [
                          Text(state.message),
                          Padding(
                            padding: const EdgeInsets.only(left: 16, right: 16),
                            child: ElevatedButton(
                              onPressed: () => _materialBloc.add(
                                LoadMaterialList(offset: 0),
                              ),
                              child: const Text('Повторить'),
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      ),
    );
    //
  }

  Widget _buildMaterialGridView(
    PagingState<int, MaterialListItem> state,
    Function fetchNextPage,
  ) {
    return PagedGridView<int, MaterialListItem>(
      state: state,
      fetchNextPage: () {
        fetchNextPage();
        _loadMaterials();
      },
      builderDelegate: PagedChildBuilderDelegate<MaterialListItem>(
        itemBuilder: (context, item, index) =>
            IntrinsicHeight(child: MaterialGridCard(material: item)),
      ),
      gridDelegate: AdaptiveGridDelegate.getDelegate(context),
    );
  }

  Widget _buildMaterialListView(
    PagingState<int, MaterialListItem> state,
    Function fetchNextPage,
  ) {
    return PagedListView<int, MaterialListItem>(
      state: state,
      fetchNextPage: () {
        fetchNextPage();
        _loadMaterials();
      },
      builderDelegate: PagedChildBuilderDelegate<MaterialListItem>(
        itemBuilder: (context, item, index) =>
            IntrinsicHeight(child: MaterialCard(material: item)),
      ),
    );
  }

  Future<void> _loadMaterials() async {
    final completer = Completer();
    _materialBloc.add(
      LoadMaterialList(
        offset: offset,
        query: _query,
        filter: _filter,
        completer: completer,
      ),
    );
    await completer.future;
  }
}
