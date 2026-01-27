// widgets/simple_search_filter.dart
import 'package:calculator_app/repositories/materials/abstract_materials_repository.dart';
import 'package:calculator_app/repositories/materials/models/material_type/material_type.dart'
    as material;
import 'package:calculator_app/repositories/materials/models/supplier/supplier.dart';
import 'package:flutter/material.dart';

import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

class SimpleSearchFilter extends StatefulWidget {
  final Function(String) onSearch;
  final Function(List<int>?, List<int>?) onFilter;

  const SimpleSearchFilter({
    super.key,
    required this.onSearch,
    required this.onFilter,
  });

  @override
  State<SimpleSearchFilter> createState() => _SimpleSearchFilterState();
}

class _SimpleSearchFilterState extends State<SimpleSearchFilter> {
  final TextEditingController _searchController = TextEditingController();
  final List<int> _selectedTypeIds = [];
  final List<int> _selectedSupplierIds = [];

  final List<material.MaterialType> _types = [];
  final List<Supplier> _suppliers = [];

  @override
  void initState() {
    super.initState();
    try {
      _loadData();
    } catch (e, stk) {
      GetIt.I<Talker>().error(e, stk);
    }

    _searchController.addListener(() {
      widget.onSearch(_searchController.text);
    });
  }

  void _loadData() async {
    _suppliers.addAll(
      await GetIt.I<AbstractMaterialsRepository>().getAllSuppliers(),
    );
    _types.addAll(await GetIt.I<AbstractMaterialsRepository>().getAllTypes());
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Поиск
        Padding(
          padding: const EdgeInsets.all(16),
          child: TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Поиск материалов...',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ),

        // Кнопка фильтров
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              const Text(
                'Фильтры:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Wrap(
                  spacing: 8,
                  children: [
                    // Кнопка типов
                    ActionChip(
                      label: const Text('Типы'),
                      onPressed: () => _showTypesDialog(),
                    ),
                    // Кнопка поставщиков
                    ActionChip(
                      label: const Text('Поставщики'),
                      onPressed: () => _showSuppliersDialog(),
                    ),
                    // Сброс
                    if (_selectedTypeIds.isNotEmpty ||
                        _selectedSupplierIds.isNotEmpty)
                      ActionChip(
                        label: const Text('Сбросить'),
                        backgroundColor: Colors.red[100],
                        onPressed: _resetFilters,
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),

        // Активные фильтры
        if (_selectedTypeIds.isNotEmpty || _selectedSupplierIds.isNotEmpty)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              runAlignment: WrapAlignment.start,
              children: [
                ..._selectedTypeIds.map(
                  (id) => Chip(
                    label: Text(_types[id - 1].name),
                    onDeleted: () => _removeType(id),
                  ),
                ),
                ..._selectedSupplierIds.map(
                  (id) => Chip(
                    label: Text(_suppliers[id - 1].name),
                    onDeleted: () => _removeSupplier(id),
                  ),
                ),
              ],
            ),
          ),
      ],
    );
  }

  void _showTypesDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Выберите типы'),
        children: [
          ..._types.asMap().entries.map((entry) {
            final name = entry.value;
            return CheckboxListTile(
              title: Text(name.name),
              value: _selectedTypeIds.contains(name.id),
              onChanged: (value) {
                if (value == true) {
                  _selectedTypeIds.add(name.id);
                } else {
                  _selectedTypeIds.remove(name.id);
                }
                widget.onFilter(_selectedTypeIds, _selectedSupplierIds);
                Navigator.pop(context);
                setState(() {});
              },
            );
          }),
        ],
      ),
    );
  }

  void _showSuppliersDialog() {
    showDialog(
      context: context,
      builder: (context) => SimpleDialog(
        title: const Text('Выберите поставщиков'),
        children: [
          ..._suppliers.asMap().entries.map((entry) {
            final name = entry.value;
            return CheckboxListTile(
              title: Text(name.name),
              value: _selectedSupplierIds.contains(name.id),
              onChanged: (value) {
                if (value == true) {
                  _selectedSupplierIds.add(name.id);
                } else {
                  _selectedSupplierIds.remove(name.id);
                }
                widget.onFilter(_selectedTypeIds, _selectedSupplierIds);
                Navigator.pop(context);
                setState(() {});
              },
            );
          }),
        ],
      ),
    );
  }

  void _removeType(int id) {
    setState(() {
      _selectedTypeIds.remove(id);
      widget.onFilter(_selectedTypeIds, _selectedSupplierIds);
    });
  }

  void _removeSupplier(int id) {
    setState(() {
      _selectedSupplierIds.remove(id);
      widget.onFilter(_selectedTypeIds, _selectedSupplierIds);
    });
  }

  void _resetFilters() {
    setState(() {
      _selectedTypeIds.clear();
      _selectedSupplierIds.clear();
      widget.onFilter(null, null);
    });
  }
}
