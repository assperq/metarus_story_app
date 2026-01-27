import 'package:auto_route/auto_route.dart';
import 'package:calculator_app/repositories/materials/models/material_list_item/material_list_item.dart';
import 'package:calculator_app/router/router.dart';
import 'package:flutter/material.dart';

class MaterialCard extends StatelessWidget {
  final MaterialListItem material;

  const MaterialCard({super.key, required this.material});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          AutoRouter.of(
            context,
          ).push(MaterialRouteRoute(materialId: material.id));
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      material.name,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 8),

              // Тип и поставщик
              Row(
                children: [
                  _buildInfoChip(
                    context,
                    label: material.type,
                    icon: Icons.category,
                  ),
                  const SizedBox(width: 8),
                  _buildInfoChip(
                    context,
                    label: material.supplier,
                    icon: Icons.store,
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // Изображение товара
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  material.imageUrl,
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Center(child: CircularProgressIndicator()),
                    );
                  },
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 150,
                      color: Colors.grey[200],
                      child: const Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.broken_image,
                            size: 48,
                            color: Colors.grey,
                          ),
                          SizedBox(height: 8),
                          Text('Ошибка загрузки'),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 12),

              // Размеры
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildDimensionInfo(
                    context,
                    label: 'Ширина',
                    value: '${material.width} мм',
                    icon: Icons.width_normal,
                  ),
                  const SizedBox(width: 8),
                  _buildDimensionInfo(
                    context,
                    label: 'Высота',
                    value: '${material.height} мм',
                    icon: Icons.height,
                  ),
                ],
              ),

              const SizedBox(height: 12),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoChip(
    BuildContext context, {
    required String label,
    required IconData icon,
  }) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label, style: Theme.of(context).textTheme.labelSmall),
      backgroundColor: Colors.grey[100],
      visualDensity: VisualDensity.compact,
    );
  }

  Widget _buildDimensionInfo(
    BuildContext context, {
    required String label,
    required String value,
    required IconData icon,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
        decoration: BoxDecoration(
          color: Colors.blue[50],
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          children: [
            Icon(icon, size: 20, color: Colors.blue[700]),
            const SizedBox(height: 4),
            Text(
              label,
              style: Theme.of(
                context,
              ).textTheme.labelSmall?.copyWith(color: Colors.blue[700]),
            ),
            Text(
              value,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
