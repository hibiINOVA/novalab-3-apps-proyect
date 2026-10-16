import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:produccion/core/theme/design_tokens.dart';

void main() {
  group('colorFromHex', () {
    test('parsea #RRGGBB', () {
      expect(colorFromHex('#00FF87'), const Color(0xFF00FF87));
    });

    test('parsea #AARRGGBB', () {
      expect(colorFromHex('#FF0B132B'), const Color(0xFF0B132B));
    });

    test('usa el fallback con valor inválido', () {
      expect(colorFromHex('no-es-color'), DesignTokens.midnightBlue);
      expect(colorFromHex(null), DesignTokens.midnightBlue);
    });
  });
}
