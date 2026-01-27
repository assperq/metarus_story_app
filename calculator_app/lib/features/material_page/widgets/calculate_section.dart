import 'package:calculator_app/features/material_page/widgets/calculate.dart';
import 'package:calculator_app/features/material_page/widgets/calculator_imput.dart';
import 'package:calculator_app/features/material_page/widgets/decline_materials.dart';
import 'package:calculator_app/repositories/materials/models/material_full_view/material.dart';
import 'package:flutter/material.dart';

class CalculateSection extends StatefulWidget {
  final MaterialFullView material;
  const CalculateSection({super.key, required this.material});

  @override
  State<CalculateSection> createState() => _CalculateSectionState();
}

class _CalculateSectionState extends State<CalculateSection> {
  final _formKey = GlobalKey<FormState>();
  final _wallWidthController = TextEditingController();
  final _wallHeightController = TextEditingController();
  final _floorWidthController = TextEditingController();
  final _floorLengthController = TextEditingController();
  final _ceilingWidthController = TextEditingController();
  final _ceilingLengthController = TextEditingController();

  int _calculatedAmount = 0;
  CalculatorMode _mode = CalculatorMode.wall;

  @override
  void dispose() {
    _wallWidthController.dispose();
    _wallHeightController.dispose();
    _floorWidthController.dispose();
    _floorLengthController.dispose();
    _ceilingWidthController.dispose();
    _ceilingLengthController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var material = widget.material;
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Калькулятор количества',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),

              // Выбор режима расчета
              SegmentedButton<CalculatorMode>(
                segments: const [
                  ButtonSegment<CalculatorMode>(
                    value: CalculatorMode.wall,
                    label: Text('Стена'),
                    icon: Icon(Icons.wallpaper),
                  ),
                  ButtonSegment<CalculatorMode>(
                    value: CalculatorMode.floor,
                    label: Text('Пол'),
                    icon: Icon(Icons.rectangle),
                  ),
                  ButtonSegment<CalculatorMode>(
                    value: CalculatorMode.ceiling,
                    label: Text('Потолок'),
                    icon: Icon(Icons.roofing),
                  ),
                ],
                selected: {_mode},
                onSelectionChanged: (Set<CalculatorMode> newSelection) {
                  setState(() {
                    _mode = newSelection.first;
                  });
                },
              ),

              const SizedBox(height: 20),

              // Поля ввода в зависимости от выбранного режима
              if (_mode == CalculatorMode.wall) ...[
                CalculatorInput(
                  label: 'Ширина стены (м)',
                  controller: _wallWidthController,
                ),
                const SizedBox(height: 12),
                CalculatorInput(
                  label: 'Высота стены (м)',
                  controller: _wallHeightController,
                ),
              ] else if (_mode == CalculatorMode.floor) ...[
                CalculatorInput(
                  label: 'Ширина пола (м)',
                  controller: _floorWidthController,
                ),
                const SizedBox(height: 12),
                CalculatorInput(
                  label: 'Длина пола (м)',
                  controller: _floorLengthController,
                ),
              ] else ...[
                CalculatorInput(
                  label: 'Ширина потолка (м)',
                  controller: _ceilingWidthController,
                ),
                const SizedBox(height: 12),
                CalculatorInput(
                  label: 'Длина потолка (м)',
                  controller: _ceilingLengthController,
                ),
              ],

              const SizedBox(height: 20),

              // Кнопка расчета
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: _calculateAmount,
                  child: const Text('Рассчитать количество'),
                ),
              ),

              // Результат расчета
              if (_calculatedAmount > 0)
                Center(
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Theme.of(
                            context,
                          ).colorScheme.secondary.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(
                            color: Theme.of(context).colorScheme.secondary,
                          ),
                        ),
                        child: Column(
                          children: [
                            Text(
                              'Результат расчета',
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 8),
                            RichText(
                              text: TextSpan(
                                style: Theme.of(context).textTheme.bodyLarge,
                                children: [
                                  const TextSpan(text: 'Необходимо '),
                                  TextSpan(
                                    text: '$_calculatedAmount',
                                    style: TextStyle(
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.secondary,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                    ),
                                  ),
                                  TextSpan(
                                    text: declineMaterial(
                                      material.name,
                                      _calculatedAmount,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (material.width != null &&
                                material.height != null)
                              Text(
                                'Размер единицы: ${material.width} × ${material.height} м',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  void _calculateAmount() {
    var material = widget.material;
    if (!_formKey.currentState!.validate()) return;

    final materialWidth = material.width ?? 0;
    final materialHeight = material.height ?? 0;

    if (materialWidth == 0 || materialHeight == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('У материала не указаны размеры')),
      );
      return;
    }

    int result = 0;

    switch (_mode) {
      case CalculatorMode.wall:
        final wallWidth = double.parse(_wallWidthController.text);
        final wallHeight = double.parse(_wallHeightController.text);
        result = MaterialCalculator.calculateForWall(
          wallWidth,
          wallHeight,
          materialWidth,
          materialHeight,
        );
        break;

      case CalculatorMode.floor:
        final floorWidth = double.parse(_floorWidthController.text);
        final floorLength = double.parse(_floorLengthController.text);
        result = MaterialCalculator.calculateForFloor(
          floorWidth,
          floorLength,
          materialWidth,
          materialHeight,
        );
        break;

      case CalculatorMode.ceiling:
        final ceilingWidth = double.parse(_ceilingWidthController.text);
        final ceilingLength = double.parse(_ceilingLengthController.text);
        result = MaterialCalculator.calculateForFloor(
          ceilingWidth,
          ceilingLength,
          materialWidth,
          materialHeight,
        );
        break;
    }

    setState(() {
      _calculatedAmount = result;
    });
  }
}
