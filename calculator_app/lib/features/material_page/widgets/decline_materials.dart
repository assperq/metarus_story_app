String declineMaterial(String materialName, int quantity) {
  // Правила склонения для разных окончаний
  String getQuantityWord(int n) {
    n = n.abs();

    final int lastDigit = n % 10;
    final int lastTwoDigits = n % 100;

    if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
      return 'единиц';
    }

    switch (lastDigit) {
      case 1:
        return 'единица';
      case 2:
      case 3:
      case 4:
        return 'единицы';
      default:
        return 'единиц';
    }
  }

  String getGenitiveCase(String word) {
    final lowerWord = word.toLowerCase();

    // Простые правила для часто встречающихся окончаний
    if (lowerWord.endsWith('а')) {
      return '${word.substring(0, word.length - 1)}ы';
    } else if (lowerWord.endsWith('я')) {
      return '${word.substring(0, word.length - 1)}и';
    } else if (lowerWord.endsWith('о') || lowerWord.endsWith('е')) {
      return '${word.substring(0, word.length - 1)}а';
    } else if (lowerWord.endsWith('ь')) {
      return '${word.substring(0, word.length - 1)}я';
    } else if (lowerWord.endsWith('й')) {
      return '${word.substring(0, word.length - 1)}я';
    } else {
      return '$wordа';
    }
  }

  // Преобразование в родительный падеж множественного числа
  String getGenitivePlural(String word) {
    final lowerWord = word.toLowerCase();

    if (lowerWord.endsWith('а')) {
      return '${word.substring(0, word.length - 1)}ы';
    } else if (lowerWord.endsWith('я')) {
      return '${word.substring(0, word.length - 1)}ь';
    } else if (lowerWord.endsWith('о') || lowerWord.endsWith('е')) {
      return word.substring(0, word.length - 1);
    } else if (lowerWord.endsWith('ь')) {
      return '${word.substring(0, word.length - 1)}ей';
    } else if (lowerWord.endsWith('й')) {
      return '${word.substring(0, word.length - 1)}ев';
    } else {
      return '$wordов';
    }
  }

  // Функция для склонения названия материала
  String declineMaterialName(String name, int n) {
    n = n.abs();
    final int lastDigit = n % 10;
    final int lastTwoDigits = n % 100;

    // Исключения для 11-14
    if (lastTwoDigits >= 11 && lastTwoDigits <= 14) {
      return getGenitiveCase(name);
    }

    switch (lastDigit) {
      case 1:
        return name;
      case 2:
      case 3:
      case 4:
        return getGenitiveCase(name);
      default:
        return getGenitivePlural(name);
    }
  }

  final quantityWord = getQuantityWord(quantity);
  final declinedMaterial = declineMaterialName(materialName, quantity);

  return ' $quantityWord ${declinedMaterial.toLowerCase()}';
}
