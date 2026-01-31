// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

// test/widget/simple_search_filter_test.dart
import 'package:calculator_app/features/materials_list/widgets/search_widget.dart';
import 'package:calculator_app/repositories/materials/abstract_materials_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:talker_flutter/talker_flutter.dart';

// Мок-классы для зависимостей
class MockAbstractMaterialsRepository extends Mock
    implements AbstractMaterialsRepository {}

class MockTalker extends Mock implements Talker {}

void main() {
  late MockAbstractMaterialsRepository mockRepository;
  late MockTalker mockTalker;
  late Function(String) onSearchCallback;
  late Function(List<int>?, List<int>?) onFilterCallback;

  setUp(() {
    GetIt.I.reset();
    mockRepository = MockAbstractMaterialsRepository();
    mockTalker = MockTalker();
    GetIt.I.registerSingleton<AbstractMaterialsRepository>(mockRepository);
    GetIt.I.registerSingleton<Talker>(mockTalker);
    // Настройка моков
    when(() => mockRepository.getAllSuppliers()).thenAnswer((_) async => []);
    when(() => mockRepository.getAllTypes()).thenAnswer((_) async => []);
    when(() => mockTalker.error(any(), any())).thenReturn(null);

    // Инициализация callback-ов
    onSearchCallback = (String value) {};
    onFilterCallback = (List<int>? types, List<int>? suppliers) {};
  });

  testWidgets('should find search field and enter text', (
    WidgetTester tester,
  ) async {
    // Arrange
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SimpleSearchFilter(
            onSearch: onSearchCallback,
            onFilter: onFilterCallback,
          ),
        ),
      ),
    );

    // Act: находим поле поиска
    final searchFieldFinder = find.byType(TextField);
    expect(searchFieldFinder, findsOneWidget);

    // Вводим текст в поле поиска
    await tester.enterText(searchFieldFinder, 'кирпич');
    await tester.pump();

    // Assert: проверяем, что текст введен корректно
    final textField = tester.widget<TextField>(searchFieldFinder);
    expect(textField.controller?.text, 'кирпич');
  });

  testWidgets('should display search hint text', (WidgetTester tester) async {
    // Arrange & Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SimpleSearchFilter(
            onSearch: onSearchCallback,
            onFilter: onFilterCallback,
          ),
        ),
      ),
    );

    // Assert: проверяем наличие подсказки
    expect(find.text('Поиск материалов...'), findsOneWidget);
    expect(find.byIcon(Icons.search), findsOneWidget);
  });

  testWidgets('should trigger search callback when typing', (
    WidgetTester tester,
  ) async {
    // Arrange
    String? capturedSearchText;
    void testOnSearch(String text) {
      capturedSearchText = text;
    }

    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SimpleSearchFilter(
            onSearch: testOnSearch,
            onFilter: onFilterCallback,
          ),
        ),
      ),
    );

    // Act: вводим текст
    await tester.enterText(find.byType(TextField), 'цемент');
    await tester.pump();

    // Assert: проверяем, что callback был вызван с правильным текстом
    expect(capturedSearchText, 'цемент');
  });

  testWidgets('should display filter chips', (WidgetTester tester) async {
    // Arrange & Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SimpleSearchFilter(
            onSearch: onSearchCallback,
            onFilter: onFilterCallback,
          ),
        ),
      ),
    );

    // Assert: проверяем наличие кнопок фильтров
    expect(find.text('Фильтры:'), findsOneWidget);
    expect(find.text('Типы'), findsOneWidget);
    expect(find.text('Поставщики'), findsOneWidget);
  });

  testWidgets('should not show reset chip when no filters selected', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SimpleSearchFilter(
            onSearch: onSearchCallback,
            onFilter: onFilterCallback,
          ),
        ),
      ),
    );

    // Assert: кнопка "Сбросить" не должна отображаться
    expect(find.text('Сбросить'), findsNothing);
  });

  testWidgets('should have correct border radius on search field', (
    WidgetTester tester,
  ) async {
    // Arrange & Act
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: SimpleSearchFilter(
            onSearch: onSearchCallback,
            onFilter: onFilterCallback,
          ),
        ),
      ),
    );

    // Assert: проверяем стилизацию поля поиска
    final textField = tester.widget<TextField>(find.byType(TextField));
    final decoration = textField.decoration as InputDecoration;
    final border = decoration.border as OutlineInputBorder;

    expect(border.borderRadius, BorderRadius.circular(8));
  });
}
