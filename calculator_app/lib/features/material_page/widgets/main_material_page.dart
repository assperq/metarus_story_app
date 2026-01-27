import 'package:calculator_app/features/material_page/widgets/calculate_section.dart';
import 'package:calculator_app/features/material_page/widgets/dimension_info.dart';
import 'package:calculator_app/features/material_page/widgets/supplier_info.dart';
import 'package:calculator_app/repositories/materials/models/material_full_view/material.dart';
import 'package:flutter/material.dart';

class MaterialDetailPage extends StatefulWidget {
  final MaterialFullView material;

  const MaterialDetailPage({super.key, required this.material});

  @override
  State<MaterialDetailPage> createState() => _MaterialDetailPageState();
}

class _MaterialDetailPageState extends State<MaterialDetailPage> {
  late MaterialFullView _material;

  @override
  void initState() {
    super.initState();
    _material = widget.material;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(_material.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение материала
            Container(
              height: 200,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                image: DecorationImage(
                  image: NetworkImage(_material.imageUrl!),
                  fit: BoxFit.cover,
                ),
              ),
            ),

            const SizedBox(height: 16),

            // Информация о размерах
            DimensionInfo(context: context, material: _material),

            const SizedBox(height: 16),

            // Калькулятор
            CalculateSection(material: _material),

            const SizedBox(height: 16),

            // Информация о поставщике
            SupplierInfo(context: context, material: _material),

            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
