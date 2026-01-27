import 'package:calculator_app/features/material_page/widgets/dimension_card.dart';
import 'package:calculator_app/repositories/materials/models/material_full_view/material.dart';
import 'package:flutter/material.dart';

class DimensionInfo extends StatelessWidget {
  const DimensionInfo({
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
                  Icons.straighten,
                  color: Theme.of(context).colorScheme.secondary,
                ),
                const SizedBox(width: 8),
                Text(
                  'Габариты материала',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (_material.width != null && _material.height != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  DimensionCard(
                    context: context,
                    title: 'Ширина',
                    value: '${_material.width} м',
                  ),
                  DimensionCard(
                    context: context,
                    title: 'Высота',
                    value: '${_material.height} м',
                  ),
                ],
              )
            else
              const Text('Размеры не указаны'),
          ],
        ),
      ),
    );
  }
}
