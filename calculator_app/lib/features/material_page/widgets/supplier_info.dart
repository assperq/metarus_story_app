import 'package:calculator_app/features/material_page/widgets/contact_row.dart';
import 'package:calculator_app/repositories/materials/models/material_full_view/material.dart';
import 'package:flutter/material.dart';

class SupplierInfo extends StatelessWidget {
  const SupplierInfo({
    super.key,
    required this.context,
    required MaterialFullView material,
  }) : _material = material;

  final BuildContext context;
  final MaterialFullView _material;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  Icons.business,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Поставщик',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_material.supplierName != null)
              Text(
                _material.supplierName!,
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
            if (_material.supplierContactPerson != null)
              Text('Контакт: ${_material.supplierContactPerson!}'),
            if (_material.supplierPhone != null)
              ContactRow(icon: Icons.phone, text: _material.supplierPhone!),
            if (_material.supplierEmail != null)
              ContactRow(icon: Icons.email, text: _material.supplierEmail!),
            if (_material.supplierAddress != null)
              ContactRow(
                icon: Icons.location_on,
                text: _material.supplierAddress!,
              ),
          ],
        ),
      ),
    );
  }
}
