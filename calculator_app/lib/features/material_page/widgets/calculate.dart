class MaterialCalculator {
  static int calculateForWall(
    double wallWidth,
    double wallHeight,
    double materialWidth,
    double materialHeight,
  ) {
    if (materialWidth == 0 || materialHeight == 0) return 0;

    final widthCount = (wallWidth / materialWidth).ceil();
    final heightCount = (wallHeight / materialHeight).ceil();

    return widthCount * heightCount;
  }

  static int calculateForFloor(
    double floorWidth,
    double floorLength,
    double materialWidth,
    double materialHeight,
  ) {
    if (materialWidth == 0 || materialHeight == 0) return 0;

    // Рассчитываем количество по двум вариантам укладки
    final option1 = _calculateForRectangle(
      floorWidth,
      floorLength,
      materialWidth,
      materialHeight,
    );
    final option2 = _calculateForRectangle(
      floorWidth,
      floorLength,
      materialHeight,
      materialWidth,
    );

    return option1 < option2 ? option1 : option2;
  }

  static int _calculateForRectangle(
    double rectWidth,
    double rectLength,
    double matWidth,
    double matHeight,
  ) {
    final widthCount = (rectWidth / matWidth).ceil();
    final lengthCount = (rectLength / matHeight).ceil();

    return widthCount * lengthCount;
  }
}

enum CalculatorMode { wall, floor, ceiling }
