import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class AdaptiveGridDelegate {
  static SliverGridDelegate getDelegate(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    // Проверяем платформу
    if (kIsWeb) {
      return _getWebDelegate(screenWidth);
    }

    if (Platform.isAndroid || Platform.isIOS) {
      return _getMobileDelegate(screenWidth);
    }

    // Десктоп платформы (Windows, macOS, Linux)
    return _getDesktopDelegate(screenWidth);
  }

  static SliverGridDelegate _getWebDelegate(double screenWidth) {
    if (screenWidth > 1400) {
      return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.75,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      );
    } else if (screenWidth > 1000) {
      return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.8,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      );
    } else {
      return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.85,
        mainAxisSpacing: 8,
        crossAxisSpacing: 8,
      );
    }
  }

  static SliverGridDelegate _getMobileDelegate(double screenWidth) {
    // Для планшетов
    if (screenWidth > 600) {
      return SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: screenWidth > 900 ? 4 : 3,
        childAspectRatio: 0.85,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
      );
    }

    // Для телефонов
    return const SliverGridDelegateWithFixedCrossAxisCount(
      crossAxisCount: 2,
      childAspectRatio: 0.8,
      mainAxisSpacing: 8,
      crossAxisSpacing: 8,
    );
  }

  static SliverGridDelegate _getDesktopDelegate(double screenWidth) {
    if (screenWidth > 2000) {
      return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 6,
        childAspectRatio: 0.9,
        mainAxisSpacing: 20,
        crossAxisSpacing: 20,
      );
    } else if (screenWidth > 1600) {
      return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 5,
        childAspectRatio: 0.92,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
      );
    } else if (screenWidth > 1200) {
      return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: 0.98,
        mainAxisSpacing: 14,
        crossAxisSpacing: 14,
      );
    } else {
      return const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.98,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
      );
    }
  }
}
