// test/unit/material_calculator_test.dart
import 'package:calculator_app/features/material_page/widgets/calculate.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('MaterialCalculator - calculateForWall', () {
    test('should return correct number of materials for wall', () {
      // Arrange
      const wallWidth = 500.0;
      const wallHeight = 300.0;
      const materialWidth = 50.0;
      const materialHeight = 60.0;

      // Act
      final result = MaterialCalculator.calculateForWall(
        wallWidth,
        wallHeight,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 50); // (500/50) = 10, (300/60) = 5, 10*5 = 50
    });

    test('should round up when dimensions are not exact multiples', () {
      // Arrange
      const wallWidth = 505.0;
      const wallHeight = 301.0;
      const materialWidth = 50.0;
      const materialHeight = 60.0;

      // Act
      final result = MaterialCalculator.calculateForWall(
        wallWidth,
        wallHeight,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 66); // ceil(505/50)=11, ceil(301/60)=6, 11*6=66
    });

    test('should return 0 when material width is 0', () {
      // Arrange
      const wallWidth = 500.0;
      const wallHeight = 300.0;
      const materialWidth = 0.0;
      const materialHeight = 60.0;

      // Act
      final result = MaterialCalculator.calculateForWall(
        wallWidth,
        wallHeight,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 0);
    });

    test('should return 0 when material height is 0', () {
      // Arrange
      const wallWidth = 500.0;
      const wallHeight = 300.0;
      const materialWidth = 50.0;
      const materialHeight = 0.0;

      // Act
      final result = MaterialCalculator.calculateForWall(
        wallWidth,
        wallHeight,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 0);
    });

    test('should handle very small dimensions', () {
      // Arrange
      const wallWidth = 0.5;
      const wallHeight = 0.3;
      const materialWidth = 0.1;
      const materialHeight = 0.1;

      // Act
      final result = MaterialCalculator.calculateForWall(
        wallWidth,
        wallHeight,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 15); // ceil(0.5/0.1)=5, ceil(0.3/0.1)=3, 5*3=15
    });
  });

  group('MaterialCalculator - calculateForFloor', () {
    test('should return optimal orientation for rectangle materials', () {
      // Arrange
      const floorWidth = 500.0;
      const floorLength = 300.0;
      const materialWidth = 60.0;
      const materialHeight = 50.0;

      // Act
      final result = MaterialCalculator.calculateForFloor(
        floorWidth,
        floorLength,
        materialWidth,
        materialHeight,
      );

      // Assert
      // Orientation 1: (500/60)=9, (300/50)=6, 9*6=54
      // Orientation 2: (500/50)=10, (300/60)=5, 10*5=50
      // Should choose minimum: 50
      expect(result, 50);
    });

    test('should handle square materials', () {
      // Arrange
      const floorWidth = 500.0;
      const floorLength = 300.0;
      const materialWidth = 50.0;
      const materialHeight = 50.0;

      // Act
      final result = MaterialCalculator.calculateForFloor(
        floorWidth,
        floorLength,
        materialWidth,
        materialHeight,
      );

      // Assert
      // Both orientations are the same for square materials
      expect(result, 60); // (500/50)=10, (300/50)=6, 10*6=60
    });

    test('should return 0 when material dimensions are 0', () {
      // Arrange
      const floorWidth = 500.0;
      const floorLength = 300.0;
      const materialWidth = 0.0;
      const materialHeight = 50.0;

      // Act
      final result = MaterialCalculator.calculateForFloor(
        floorWidth,
        floorLength,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 0);
    });

    test('should handle exact fit scenario', () {
      // Arrange
      const floorWidth = 200.0;
      const floorLength = 150.0;
      const materialWidth = 50.0;
      const materialHeight = 50.0;

      // Act
      final result = MaterialCalculator.calculateForFloor(
        floorWidth,
        floorLength,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 12); // (200/50)=4, (150/50)=3, 4*3=12
    });
  });

  group('MaterialCalculator - edge cases', () {
    test('should handle wall smaller than material', () {
      // Arrange
      const wallWidth = 30.0;
      const wallHeight = 20.0;
      const materialWidth = 50.0;
      const materialHeight = 50.0;

      // Act
      final result = MaterialCalculator.calculateForWall(
        wallWidth,
        wallHeight,
        materialWidth,
        materialHeight,
      );

      // Assert
      // ceil(30/50)=1, ceil(20/50)=1, 1*1=1
      expect(result, 1);
    });

    test('should handle floor smaller than material', () {
      // Arrange
      const floorWidth = 30.0;
      const floorLength = 20.0;
      const materialWidth = 50.0;
      const materialHeight = 50.0;

      // Act
      final result = MaterialCalculator.calculateForFloor(
        floorWidth,
        floorLength,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 1);
    });

    test('should handle very large numbers without overflow', () {
      // Arrange
      const floorWidth = 10000.0;
      const floorLength = 10000.0;
      const materialWidth = 0.1;
      const materialHeight = 0.1;

      // Act
      final result = MaterialCalculator.calculateForFloor(
        floorWidth,
        floorLength,
        materialWidth,
        materialHeight,
      );

      // Assert
      expect(result, 10000000000); // 100,000,000
    });
  });
}
